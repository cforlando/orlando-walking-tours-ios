//
//  DashboardVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/4/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, DashboardViewLayoutDelegate
{
    ////////////////////////////////////////////////////////////
    // MARK: - Outlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newTourView: UIStackView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var tours = [Tour]()
    var isDeletionModeActive = false
    var modelService: ModelService = MagicalRecordModelService()

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = DashboardViewFlowLayout()

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(DashboardVC.activateDeletionMode(_:)))
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        self.collectionView.addGestureRecognizer(longPress)

        let tap = UITapGestureRecognizer(target: self, action: #selector(DashboardVC.endDeletionMode(_:)))
        tap.delegate = self
        self.collectionView.addGestureRecognizer(tap)

        if let tours = modelService.findAllTours()
        {
            self.tours = tours
        }

        self.newTourView.hidden = (self.tours.count > 0)
    }

    ////////////////////////////////////////////////////////////

    @IBAction func newTourPressed(sender: UIButton)
    {
        
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UIGestureRecognizerDelegate
    ////////////////////////////////////////////////////////////

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool
    {
        let point = touch.locationInView(self.collectionView)
        let indexPath = self.collectionView.indexPathForItemAtPoint(point)
        if ((indexPath != nil) && (gestureRecognizer is UITapGestureRecognizer))
        {
            return false
        }

        return true
    }

    ////////////////////////////////////////////////////////////

    func activateDeletionMode(gestureRecognizer: UILongPressGestureRecognizer)
    {
        if gestureRecognizer.state == .Began
        {
            if (self.collectionView.indexPathForItemAtPoint(gestureRecognizer.locationInView(self.collectionView)) != nil)
            {
                self.isDeletionModeActive = true
                let layout = self.collectionView.collectionViewLayout as! DashboardViewFlowLayout
                layout.invalidateLayout()
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func endDeletionMode(tapRecognizer: UITapGestureRecognizer)
    {
        if self.isDeletionModeActive
        {
            if (self.collectionView.indexPathForItemAtPoint(tapRecognizer.locationInView(self.collectionView)) == nil)
            {
                self.isDeletionModeActive = false
                let layout = self.collectionView.collectionViewLayout as! DashboardViewFlowLayout
                layout.invalidateLayout()
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func deleteTour(sender: UIButton)
    {
        if let cell = sender.superview?.superview as? DashboardCollectionViewCell
        {
            let alertController = UIAlertController(title: "Are you sure?", message: "Are you sure you want to delete \(cell.tourName.text!)?", preferredStyle: .Alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive)
            { action in
                if let indexPath = self.collectionView.indexPathForCell(cell)
                {
                    self.modelService.deleteTour(tour: self.tours[indexPath.item])
                    { (success, error) in
                        self.tours.removeAtIndex(indexPath.item)
                        self.collectionView.deleteItemsAtIndexPaths([indexPath])
                    }
                }
            }

            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)

            presentViewController(alertController, animated: true, completion: nil)
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewDataSource
    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return (self.tours.count > 0) ? self.tours.count + 1 : self.tours.count
    }

    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if indexPath.item == self.tours.count
        {
            return collectionView.dequeueReusableCellWithReuseIdentifier("AddTourCell", forIndexPath: indexPath) as! AddTourCollectionViewCell
        }
        else
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardCell", forIndexPath: indexPath) as! DashboardCollectionViewCell
            cell.configureImage(cell.frame)
            cell.tourName?.text = self.tours[indexPath.item].title
            cell.deleteButton.addTarget(self, action: #selector(DashboardVC.deleteTour(_:)), forControlEvents: .TouchUpInside)
            return cell
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewDelegate
    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        performSegueWithIdentifier("CurrentTourSegue", sender: self.tours[indexPath.item])
    }

    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return (isDeletionModeActive) ? false : true
    }

    ////////////////////////////////////////////////////////////
    // MARK: - DashboardViewLayoutDelegate
    ////////////////////////////////////////////////////////////

    func isDeletionModeActiveForCollectionView(collectionView: UICollectionView, layout: UICollectionViewLayout) -> Bool
    {
        return isDeletionModeActive
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Navigation
    ////////////////////////////////////////////////////////////

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let navController = segue.destinationViewController as? UINavigationController,
           let vc = navController.topViewController as? CurrentTourVC where segue.identifier == "CurrentTourSegue"
        {
            vc.tour = sender as? Tour
        }
    }
}
