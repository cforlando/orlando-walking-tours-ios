//
//  DashboardVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/4/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import MagicalRecord

class DashboardVC: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    weak var AddAlertSaveAction: UIAlertAction?
    
    var toursArray: [Tour] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        toursArray = Tour.MR_findAll() as! [Tour]

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func newTourPressed(sender: UIBarButtonItem)
        
    {
        let alertController = UIAlertController(title: "Add Tour", message: nil, preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) in
            textField.placeholder = "Enter tour name"
            textField.returnKeyType = .Done
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DashboardVC.handleTextFieldTextDidChangeNotification), name: UITextFieldTextDidChangeNotification, object: textField)
        }
        
        func removeTextFieldObserver() {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: alertController.textFields![0])
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { action in
            print("Cancel Button Pressed")
            removeTextFieldObserver()
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { action in
            print("Saved")
            
            let nameTextField = alertController.textFields!.first
            
            MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) in
                let tour = Tour.MR_createEntityInContext(localContext)
                tour!.title = nameTextField!.text!
            })

            self.tableView.reloadData()
            removeTextFieldObserver()
        }
        
        // disable the 'save' button initially
        saveAction.enabled = false
        
        // save the other action to toggle the enabled/disabled state when the text changed.
        AddAlertSaveAction = saveAction
        
        // Add the actions.
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func handleTextFieldTextDidChangeNotification(notification: NSNotification) {
        let textField = notification.object as! UITextField
        
        // Enforce a minimum length of >= 1 for secure text alerts.
        AddAlertSaveAction!.enabled = textField.text?.characters.count >= 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dashboardCell", forIndexPath: indexPath)
        let currentTour = toursArray[indexPath.row]
        // Populate cell from the NSManagedObject instance
        cell.textLabel!.text = currentTour.title
        
        return cell
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toursArray.count
    }


}
