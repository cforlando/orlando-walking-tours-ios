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
    @IBOutlet weak var backgroundImageView: UIImageView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    lazy var tours = [Tour]()
    var isDeletionModeActive = false
    lazy var modelService: ModelService = MagicalRecordModelService()

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

        self.populateDataSource()
    }

    ////////////////////////////////////////////////////////////

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.populateDataSource()
    }

    ////////////////////////////////////////////////////////////

    @IBAction func newTourPressed(sender: UIButton)
    {
        
    }

    ////////////////////////////////////////////////////////////

    func populateDataSource()
    {
        if let tours = modelService.findAllTours()
        {
            self.tours = tours
        }
        self.collectionView.reloadData()

        self.newTourView.isHidden = (self.tours.count > 0)
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UIGestureRecognizerDelegate
    ////////////////////////////////////////////////////////////

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
        let point = touch.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        if ((indexPath != nil) && (gestureRecognizer is UITapGestureRecognizer))
        {
            return false
        }

        return true
    }

    ////////////////////////////////////////////////////////////

    func activateDeletionMode(_ gestureRecognizer: UILongPressGestureRecognizer)
    {
        if gestureRecognizer.state == .began
        {
            if (self.collectionView.indexPathForItem(at: gestureRecognizer.location(in: self.collectionView)) != nil)
            {
                self.isDeletionModeActive = true
                let layout = self.collectionView.collectionViewLayout as! DashboardViewFlowLayout
                layout.invalidateLayout()
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func endDeletionMode(_ tapRecognizer: UITapGestureRecognizer)
    {
        if self.isDeletionModeActive
        {
            if (self.collectionView.indexPathForItem(at: tapRecognizer.location(in: self.collectionView)) == nil)
            {
                self.isDeletionModeActive = false
                let layout = self.collectionView.collectionViewLayout as! DashboardViewFlowLayout
                layout.invalidateLayout()
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func deleteTour(_ sender: UIButton)
    {
        if let cell = sender.superview?.superview as? DashboardCollectionViewCell
        {
            let alertController = UIAlertController(title: "Are you sure?", message: "Are you sure you want to delete \(cell.tourName.text!)?", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
            { action in
                if let indexPath = self.collectionView.indexPath(for: cell)
                {
                    self.modelService.deleteTour(self.tours[indexPath.item])
                    { (success, error) in
                        self.tours.remove(at: indexPath.item)
                        if self.tours.count == 0
                        {
                            self.isDeletionModeActive = false
                        }
                        self.collectionView.reloadData()
                    }
                }
            }

            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)

            present(alertController, animated: true, completion: nil)
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewDataSource
    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (self.tours.count == 0) && (self.newTourView.isHidden)
        {
            self.newTourView.isHidden = false
        }

        return (self.tours.count > 0) ? self.tours.count + 1 : self.tours.count
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.item == self.tours.count
        {
            return collectionView.dequeueReusableCell(withReuseIdentifier: AddTourCollectionViewCell.reuseIdentifier, for: indexPath) as! AddTourCollectionViewCell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCollectionViewCell.reuseIdentifier, for: indexPath) as! DashboardCollectionViewCell
            cell.configureImage(frame: cell.frame)
            cell.tourName?.text = self.tours[indexPath.item].title
            cell.deleteButton.addTarget(self, action: #selector(DashboardVC.deleteTour(_:)), for: .touchUpInside)
            return cell
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewDelegate
    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "CurrentTourSegue", sender: self.tours[indexPath.item])
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        if let navController = segue.destination as? UINavigationController,
           let vc = navController.topViewController as? CurrentTourVC,
            segue.identifier == "CurrentTourSegue"
        {
            vc.tour = sender as? Tour
        }
    }

    ////////////////////////////////////////////////////////////

    @IBAction func unwindToDashboard(unwindseque: UIStoryboardSegue)
    {
        
    }
}
