//
//  DashboardVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/4/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class DashboardVC: UIViewController, UICollectionViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
{
    ////////////////////////////////////////////////////////////
    // MARK: - Outlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var collectionView: UICollectionView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var tours = [Tour]()

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.emptyDataSetSource = self
        self.collectionView.emptyDataSetDelegate = self
        self.collectionView.collectionViewLayout = DashboardViewFlowLayout()

        if let tours = Tour.MR_findAll() as? [Tour]
        {
            self.tours = tours
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - DZNEmptyDataSetSource
    ////////////////////////////////////////////////////////////

    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage!
    {
        return UIImage(named: "plus")
    }

    ////////////////////////////////////////////////////////////

    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString!
    {
        var attributes: [String: AnyObject] =
        [
            NSForegroundColorAttributeName: UIColor.blackColor()
        ]

        if let titleFont = UIFont(name: "HelveticaNeue", size: 28.0)
        {
            attributes[NSFontAttributeName] = titleFont
        }

        return NSAttributedString(string: "New Tour", attributes: attributes)
    }

    ////////////////////////////////////////////////////////////

    func backgroundColorForEmptyDataSet(scrollView: UIScrollView!) -> UIColor!
    {
        return UIColor.whiteColor()
    }

    ////////////////////////////////////////////////////////////

    func verticalOffsetForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat
    {
        return -75.0
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewDataSource
    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.tours.count
    }

    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardCell", forIndexPath: indexPath) as? DashboardCollectionViewCell
        {
            // TODO: Image view for cell should be random photo of a location from the tour
            //cell.imageView.image = UIImage(named: "plus")
            return cell
        }
        
        return UICollectionViewCell()
    }
}
