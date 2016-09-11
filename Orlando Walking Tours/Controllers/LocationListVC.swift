//
//  LocationListVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/4/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import MapKit
import MagicalRecord

class LocationListVC: UIViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - Outlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
//    @IBOutlet weak var closestToMe: TouchableLabel!
    @IBOutlet weak var viewBarButton: UIBarButtonItem!

    ////////////////////////////////////////////////////////////
    // MARK: - Enumerations
    ////////////////////////////////////////////////////////////

    enum ViewMode
    {
        case List, Map

        func update(viewController: LocationListVC)
        {
            switch self
            {
            case .List:
                viewController.tableView.shown = true
                viewController.mapView.hidden = true
            case .Map:
                viewController.mapView.shown = true
                viewController.tableView.hidden = true
                let zoomLevel = 1.0.asMeters
                let mapRegion = MKCoordinateRegionMakeWithDistance(viewController.simulatedLocation.coordinate, zoomLevel, zoomLevel)
                viewController.mapView.setRegion(mapRegion, animated: true)    // animate the zoom
                let locationAnnotations = viewController.locations.map
                {
                    return LocationAnnotation(location: $0)
                }
                viewController.mapView.addAnnotations(locationAnnotations)
            }
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var viewMode : ViewMode = .List
    {
        didSet
        {
            viewMode.update(self)
        }
    }
    
    var tour: Tour?
    var tourObjectID: NSManagedObjectID?
    var locations = [HistoricLocation]()
    var modelService: ModelService = MagicalRecordModelService()
    var dataService: DataService = FirebaseDataService()
    var userLocation: CLLocation?
    // Exchange Building
    let simulatedLocation = CLLocation(latitude: 28.540951, longitude: -81.381265)

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // TODO: Need to re-implement the "closestToMe" functionality
//        closestToMe.didTouch =
//        {
//            self.sortClosestToMe()
//            self.tableView.reloadData()
//        }

        self.navigationItem.title = self.tour?.title ?? ""

        self.dataService.getLocations
        { locations in
            let allLocations = locations.sort
            {
                $0.locationTitle <= $1.locationTitle
            }
            dispatch_async(dispatch_get_main_queue())
            {
                self.setAvailableTourLocations(allLocations)
                UserLocationService.sharedService.startTracking
                { userLocation in
                    if userLocation.coordinate != self.userLocation?.coordinate
                    {
                        // ? need to re-sort when location chgs (if using "closest to me")
                        self.userLocation = userLocation
                        self.tableView.reloadData()
                    }
                }
                self.tableView.reloadData()
            }
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Navigation
    ////////////////////////////////////////////////////////////

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        super.prepareForSegue(segue, sender: sender)
        
        if let navController = segue.destinationViewController as? UINavigationController
        {
            if let vc = navController.topViewController as? CurrentTourVC where segue.identifier == "ShowCurrentTourSegue"
            {
                vc.tour = self.tour
            }
            else if let vc = navController.topViewController as? LocationDetailVC where segue.identifier == "ShowLocationDetailsSegue"
            {
                if let indexPath = sender as? NSIndexPath
                {
                    vc.location = locations[indexPath.row]
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Actions
    ////////////////////////////////////////////////////////////

    @IBAction func addToTourPressed(sender: UIButton)
    {
        if let cellView = sender.findSuperViewOfType(LocationTableViewCell) as? LocationTableViewCell
        {
            let locationId = cellView.locationId
            let locationIndex = self.locations.indexOf { $0.locationId == locationId }!
            let location = self.locations.removeAtIndex(locationIndex)
            if let tour = self.tour
            {
                print("In addToTourPressed, localRegistryDate is \(location.localRegistryDate)")
                modelService.addLocation(location, toTour: tour)
                { (ok, error) in
                    if ok
                    {
                        let indexPath = NSIndexPath(forItem: locationIndex, inSection: 0)
                        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
                        self.displayTour()
                    }
                    else
                    {
                        // !!! need to handle errors here
                    }
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////

    @IBAction func viewBarButtonTapped(sender: UIBarButtonItem)
    {
        if self.viewMode == .List
        {
            self.viewMode = .Map
            self.viewBarButton.title = "List"
        }
        else
        {
            self.viewMode = .List
            self.viewBarButton.title = "Map"
        }
    }

    ////////////////////////////////////////////////////////////
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem)
    {
        performSegueWithIdentifier("ShowCurrentTourSegue", sender: nil)
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Helper Functions
    ////////////////////////////////////////////////////////////

    func setAvailableTourLocations(allLocations: [HistoricLocation])
    {
        if let tourLocations = self.tour?.historicLocations
        {
            if tourLocations.count > 0
            {
                print("Tour Locations Count is \(tourLocations.count)")
                var availableTourLocations = [HistoricLocation]()
                for tourLoc in allLocations
                {
                    if !tourLocations.contains(
                        {
                            $0.locationTitle == tourLoc.locationTitle
                    })
                    {
                        availableTourLocations.append(tourLoc)
                    }
                }
                self.locations = availableTourLocations
            }
            else
            {
                self.locations = allLocations
            }
        }
    }

    ////////////////////////////////////////////////////////////
    
    func sortClosestToMe()
    {
        if let userLocation = self.userLocation
        {
            // first collect loc and distance together in a tuple
            let locDist = locations.map
            { loc -> (CLLocationDistance, HistoricLocation) in
                let siteLoc = loc.locationPoint
                let distanceFromCur = siteLoc.distanceFromLocation(userLocation).asMiles
                return (distanceFromCur, loc)
            }
            // now sort by distance
            self.locations = locDist.sort
            { (a,b) in
                return a.0 <= b.0
            }
            // and finally pull out the location
            .map
            { (dist, loc) in
                return loc
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func displayTour()
    {
        if let tour = self.tour
        {
            let locationsByOrder = tour.historicLocations?.sort({
                let a = $0 as! HistoricLocation
                let b = $1 as! HistoricLocation
                return a.sortOrder?.compare(b.sortOrder!) == NSComparisonResult.OrderedAscending
            })
            if let locationsInOrder = locationsByOrder
            {
                for loc in locationsInOrder
                {
                    let tourLoc = loc as! HistoricLocation
                    print("  \(tourLoc.sortOrder) \(tourLoc.locationTitle)")
                }
            }
        }
    }
}

////////////////////////////////////////////////////////////
// MARK: - LocationListVC Extension
////////////////////////////////////////////////////////////

extension LocationListVC : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.locations.count
    }

    ////////////////////////////////////////////////////////////

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 70
    }

    ////////////////////////////////////////////////////////////

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let location = locations[indexPath.row]
        guard let locationCell = tableView.dequeueReusableCellWithIdentifier(LocationTableViewCell.reuseIdentifier) as? LocationTableViewCell else
        {
            return UITableViewCell()
        }
        
        locationCell.locationId = location.locationId
        locationCell.configureImage(locationCell.locationThumbnail.frame)
        
        var locationTitle = location.locationTitle ?? ""
        if let userLocation = self.userLocation
        {
            let siteLoc = location.locationPoint
            let distanceFromCur = siteLoc.distanceFromLocation(userLocation).asMiles
            locationTitle = String(format: "%@ (%0.1fmi)", locationTitle, distanceFromCur)
        }
        locationCell.locationTitle.text = locationTitle
        
        return locationCell
    }

    ////////////////////////////////////////////////////////////

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        // TODO: Implement this function; should segue to the LocationDetail storyboard
        performSegueWithIdentifier("ShowLocationDetailsSegue", sender: indexPath)
    }
}
