//
//  CurrentTourVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 7/9/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import MapKit

class CurrentTourVC: UIViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var tour: Tour?
    lazy var locations = [HistoricLocation]()
    lazy var modelService: ModelService = MagicalRecordModelService()
    var userLocation: CLLocation?
    // Exchange Building
    let simulatedLocation = CLLocation(latitude: 28.540951, longitude: -81.381265)

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.navigationItem.title = self.tour?.title
        self.loadLocations()

        let zoomLevel = 1.0.asMeters
        let mapRegion = MKCoordinateRegionMakeWithDistance(self.simulatedLocation.coordinate, zoomLevel, zoomLevel)
        self.mapView.setRegion(mapRegion, animated: true)    // animate the zoom
        let locationAnnotations = self.locations.map
        {
            return LocationAnnotation(location: $0)
        }
        self.mapView.addAnnotations(locationAnnotations)

    }

    ////////////////////////////////////////////////////////////

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.loadLocations()
    }

    ////////////////////////////////////////////////////////////
    // MARK: - IBActions
    ////////////////////////////////////////////////////////////

    @IBAction func addMoreLocationsTapped(sender: UIBarButtonItem)
    {
        performSegueWithIdentifier("AddMoreLocationsSegue", sender: nil)
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Navigation
    ////////////////////////////////////////////////////////////

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        super.prepareForSegue(segue, sender: sender)

        if let navController = segue.destinationViewController as? UINavigationController,
           let vc = navController.topViewController as? LocationListVC where segue.identifier == "AddMoreLocationsSegue"
        {
            vc.tour = self.tour
        }

    }

    ////////////////////////////////////////////////////////////

    func loadLocations()
    {
        if let tour = self.tour,
           let locations = modelService.loadLocations(fromTour: tour)
        {
            self.locations = locations
            self.tableView.reloadData()
        }
    }
}

////////////////////////////////////////////////////////////

extension CurrentTourVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tour?.historicLocations?.count ?? 0
    }

    ////////////////////////////////////////////////////////////

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 70
    }

    ////////////////////////////////////////////////////////////

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let location = self.locations[indexPath.row]

        guard let cell = tableView.dequeueReusableCellWithIdentifier(CurrentLocationTableViewCell.reuseIdentifier, forIndexPath: indexPath) as? CurrentLocationTableViewCell else
        {
            return UITableViewCell()
        }
        
        cell.configureImage(cell.locationThumbnail.frame)
        cell.locationLabel.text = location.locationTitle
        cell.addressLabel.text = location.address

        return cell
    }
}