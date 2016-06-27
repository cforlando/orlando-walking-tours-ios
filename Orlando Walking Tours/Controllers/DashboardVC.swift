//
//  DashboardVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/4/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate//, UIGestureRecognizerDelegate, DashboardViewLayoutDelegate
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
    //var deletionModeActive = false

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = DashboardViewFlowLayout()
/*
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(DashboardVC.activateDeletionMode(_:)))
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        self.collectionView.addGestureRecognizer(longPress)

        let tap = UITapGestureRecognizer(target: self, action: #selector(DashboardVC.endDeletionMode(_:)))
        tap.delegate = self
        self.collectionView.addGestureRecognizer(tap)
*/
        if let tours = Tour.MR_findAll() as? [Tour]
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
/*
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
                self.deletionModeActive = true
                let layout = self.collectionView.collectionViewLayout as! DashboardViewFlowLayout
                layout.invalidateLayout()
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func endDeletionMode(tapRecognizer: UITapGestureRecognizer)
    {
        if self.deletionModeActive
        {
            if (self.collectionView.indexPathForItemAtPoint(tapRecognizer.locationInView(self.collectionView)) == nil)
            {
                self.deletionModeActive = false
                let layout = self.collectionView.collectionViewLayout as! DashboardViewFlowLayout
                layout.invalidateLayout()
            }
        }
    }
*/
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
            // TODO: Image view for cell should be random photo of a location from the tour
            cell.imageView?.image = UIImage.getPlaceholderImage(sized: Int(cell.frame.width), by: Int(cell.frame.height))
            cell.tourName?.text = self.tours[indexPath.item].title
            return cell
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewDelegate
    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        // TODO
    }

    ////////////////////////////////////////////////////////////
/*
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return (deletionModeActive) ? false : true
    }
*/
    ////////////////////////////////////////////////////////////
    // MARK: - DashboardViewLayoutDelegate
    ////////////////////////////////////////////////////////////
/*
    func isDeletionModeActiveForCollectionView(collectionView: UICollectionView, layout: UICollectionViewLayout) -> Bool
    {
        return deletionModeActive
    }
*/
}
