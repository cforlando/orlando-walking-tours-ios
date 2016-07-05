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
        MagicalRecord.saveWithBlock
        { context in
            let tour = Tour.MR_createEntityInContext(context)
            tour?.title = self.tourNameTextField.text

            // At this point, tour is valid
            print("tour == \(tour)")
            // I want to pass the tour to prepareForSegue, but I have to do it on the main thread
            dispatch_async(dispatch_get_main_queue())
            {
                // Tour even seems to be valid here
                print("tour again == \(tour)")
                self.performSegueWithIdentifier("ShowLocationListSegue", sender: tour)
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
                // By the time I get here, that Tour object is nil
                print("sender as tour == \(sender as? Tour)")
                vc.tour = sender as? Tour
            }
        }
    }
}
