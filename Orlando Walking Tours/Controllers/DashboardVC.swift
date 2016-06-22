//
//  DashboardVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/4/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController, UICollectionViewDataSource
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

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = DashboardViewFlowLayout()

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
            cell.imageView.image = UIImage(named: "plus")
            cell.tourName.text = self.tours[indexPath.row].title
            return cell
        }
        
        return UICollectionViewCell()
    }
}
