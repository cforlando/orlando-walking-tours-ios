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
    var uuid: NSUUID?

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        tourNameTextField.delegate = self
        notificationCenter.addObserver(self, selector: #selector(AddTourVC.handleTextFieldDidChangeNotification(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
    }

    ////////////////////////////////////////////////////////////

    override func viewWillAppear(animated: Bool)
    {
        tourNameTextField.becomeFirstResponder()
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UITextFieldDelegate
    ////////////////////////////////////////////////////////////

    func textFieldShouldClear(textField: UITextField) -> Bool
    {
        self.addTourButton.enabled = false
        return true
    }

    ////////////////////////////////////////////////////////////

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        return true
    }

    ////////////////////////////////////////////////////////////
    // MARK: - IBActions
    ////////////////////////////////////////////////////////////

    @IBAction func addTourButtonTapped(sender: UIButton)
    {
        // This block with create and save a Tour entity on a background thread
        MagicalRecord.saveWithBlock(
        { context in
            self.uuid = NSUUID()

            let tour = Tour.MR_createEntityInContext(context)
            tour?.title = self.tourNameTextField.text
            tour?.uuid = self.uuid?.UUIDString
        })
        { success, error in
            if success
            {
                self.performSegueWithIdentifier("ShowLocationListSegue", sender: nil)
            }
            else
            {
                print("Error: \(error?.localizedDescription)")
            }
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
        notificationCenter.removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }

    ////////////////////////////////////////////////////////////

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowLocationListSegue"
        {
            if let navController = segue.destinationViewController as? UINavigationController,
               let vc = navController.topViewController as? LocationListVC
            {
                let tour = Tour.MR_findFirstByAttribute("uuid", withValue: (self.uuid?.UUIDString)!)
                vc.tour = tour
            }
        }
    }
}
