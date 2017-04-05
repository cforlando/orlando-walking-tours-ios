//
//  AddTourVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/21/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class AddTourVC: UIViewController, UITextFieldDelegate
{
    ////////////////////////////////////////////////////////////
    // MARK: - Outlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var tourNameTextField: UITextField!
    @IBOutlet weak var addTourButton: CustomButton!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    let notificationCenter = NotificationCenter.default
    lazy var modelService: ModelService = MagicalRecordModelService()

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        tourNameTextField.delegate = self
        notificationCenter.addObserver(self, selector: #selector(AddTourVC.handleTextFieldDidChangeNotification(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }

    ////////////////////////////////////////////////////////////

    override func viewWillAppear(_ animated: Bool)
    {
        tourNameTextField.becomeFirstResponder()
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UITextFieldDelegate
    ////////////////////////////////////////////////////////////

    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        self.addTourButton.isEnabled = false
        return true
    }

    ////////////////////////////////////////////////////////////

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return true
    }

    ////////////////////////////////////////////////////////////
    // MARK: - IBActions
    ////////////////////////////////////////////////////////////

    @IBAction func addTourButtonTapped(sender: UIButton)
    {
        modelService.createTour(withName: self.tourNameTextField.text ?? "")
        { uuid, success, error in
            if success
            {
                self.performSegue(withIdentifier: "ShowLocationListSegue", sender: uuid)
            }
            else
            {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }

        removeTextFieldObserver()
    }

    ////////////////////////////////////////////////////////////

    @IBAction func cancelButtonTapped(sender: UIButton)
    {
        tourNameTextField.resignFirstResponder()
        removeTextFieldObserver()
        self.dismiss(animated: true, completion: nil)
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Helper functions
    ////////////////////////////////////////////////////////////

    func handleTextFieldDidChangeNotification(_ notification: NSNotification)
    {
        if let textField = notification.object as? UITextField
        {
            self.addTourButton.isEnabled = (textField.text?.characters.count)! >= 1
        }
    }

    ////////////////////////////////////////////////////////////

    func removeTextFieldObserver()
    {
        notificationCenter.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }

    ////////////////////////////////////////////////////////////

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowLocationListSegue"
        {
            if let navController = segue.destination as? UINavigationController,
               let vc = navController.topViewController as? LocationListVC
            {
                if let uuid = sender as? UUID
                {
                    modelService.findTour(by: uuid)
                    { tour in
                        vc.tour = tour
                    }
                }
            }
        }
    }
}
