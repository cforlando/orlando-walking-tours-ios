//
//  AddTourVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/21/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import MagicalRecord

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

    let notificationCenter = NSNotificationCenter.defaultCenter()

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        tourNameTextField.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddTourVC.handleTextFieldDidChangeNotification(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
    }

    ////////////////////////////////////////////////////////////

    override func viewWillAppear(animated: Bool)
    {
        tourNameTextField.becomeFirstResponder()
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UITextFieldDelegate
    ////////////////////////////////////////////////////////////

    func textFieldDidBeginEditing(textField: UITextField)
    {
        self.addTourButton.enabled = true
    }

    ////////////////////////////////////////////////////////////

    func textFieldShouldClear(textField: UITextField) -> Bool
    {
        self.addTourButton.enabled = false
        return true
    }

    ////////////////////////////////////////////////////////////
    // MARK: - IBActions
    ////////////////////////////////////////////////////////////

    @IBAction func addTourButtonTapped(sender: UIButton)
    {
        MagicalRecord.saveWithBlock
        { context in
            let tour = Tour.MR_createEntityInContext(context)
            tour?.title = self.tourNameTextField.text
        }

        removeTextFieldObserver()
    }

    ////////////////////////////////////////////////////////////

    @IBAction func cancelButtonTapped(sender: UIButton)
    {
        tourNameTextField.resignFirstResponder()
        removeTextFieldObserver()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Helper functions
    ////////////////////////////////////////////////////////////

    func handleTextFieldDidChangeNotification(notification: NSNotification)
    {
        if let textField = notification.object as? UITextField
        {
            self.addTourButton.enabled = textField.text?.characters.count >= 1
        }
    }

    ////////////////////////////////////////////////////////////

    func removeTextFieldObserver()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }
}
