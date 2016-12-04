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
    @IBOutlet weak var closestToMe: TouchableLabel!
    @IBOutlet weak var viewBarButton: UIBarButtonItem!
    @IBOutlet weak var sortButton: UIButton!

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
                viewController.mapView.isHidden = true
            case .Map:
                viewController.mapView.shown = true
                viewController.tableView.isHidden = true
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

    enum SortOrder
    {
        case alphabetical, byLocation
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var viewMode : ViewMode = .List
    {
        didSet
        {
            viewMode.update(viewController: self)
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
    var sortingOrder: SortOrder = .alphabetical

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
            let allLocations = locations.sorted
            {
                $0.locationTitle! <= $1.locationTitle!
            }
            DispatchQueue.main.async
            {
                self.setAvailableTourLocations(allLocations: allLocations)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        if let navController = segue.destination as? UINavigationController
        {
            if let vc = navController.topViewController as? CurrentTourVC,
                segue.identifier == "ShowCurrentTourSegue"
            {
                vc.tour = self.tour
            }
            else if let vc = navController.topViewController as? LocationDetailVC,
                segue.identifier == "ShowLocationDetailsSegue"
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
        if let cellView = sender.findSuperViewOfType(superViewClass: LocationTableViewCell.self) as? LocationTableViewCell
        {
            let locationId = cellView.locationId
            let locationIndex = self.locations.index { $0.locationId == locationId }!
            let location = self.locations.remove(at: locationIndex)
            if let tour = self.tour
            {
                modelService.add(location, to: tour)
                { (ok, error) in
                    if ok
                    {
                        let indexPath = IndexPath(item: locationIndex, section: 0)
                        self.tableView.deleteRows(at: [indexPath], with: .right)
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
        performSegue(withIdentifier: "ShowCurrentTourSegue", sender: nil)
    }

    ////////////////////////////////////////////////////////////

    @IBAction func sortButtonTapped(_ sender: Any)
    {
        if self.sortingOrder == .byLocation
        {
            self.sortAlphabetically()
            self.sortButton.setTitle("Current Location", for: .normal)
            self.sortingOrder = .alphabetical
        }
        else
        {
            self.sortClosestToMe()
            self.sortButton.setTitle("Location Name", for: .normal)
            self.sortingOrder = .byLocation
        }

        self.tableView.reloadData()
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
                    if !tourLocations.contains(where:
                    {
                        let a = $0 as! HistoricLocation
                        return a.locationTitle == tourLoc.locationTitle
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
                let distanceFromCur = siteLoc.distance(from: userLocation).asMiles
                return (distanceFromCur, loc)
            }
            // now sort by distance
            self.locations = locDist.sorted
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

    func sortAlphabetically()
    {
        self.locations.sort
        {
            guard let firstLocationTitle = $0.locationTitle,
                let secondLocationTitle = $1.locationTitle else
            {
                return false
            }

            return firstLocationTitle.localizedCaseInsensitiveCompare(secondLocationTitle) == ComparisonResult.orderedAscending
        }
    }

    ////////////////////////////////////////////////////////////

    func displayTour()
    {
        if let tour = self.tour
        {
            let locationsByOrder = tour.historicLocations?.sorted(by: {
                let a = $0 as! HistoricLocation
                let b = $1 as! HistoricLocation
                return a.sortOrder?.compare(b.sortOrder!) == ComparisonResult.orderedAscending
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
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.locations.count
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let location = locations[indexPath.row]
        guard let locationCell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier) as? LocationTableViewCell else
        {
            return UITableViewCell()
        }
        
        locationCell.locationId = location.locationId
        locationCell.configureImage(frame: locationCell.locationThumbnail.frame)
        
        var locationTitle = location.locationTitle ?? ""
        if let userLocation = self.userLocation
        {
            let siteLoc = location.locationPoint
            let distanceFromCur = siteLoc.distance(from: userLocation).asMiles
            locationTitle = String(format: "%@ (%0.1fmi)", locationTitle, distanceFromCur)
        }
        locationCell.locationTitle.text = locationTitle
        
        return locationCell
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "ShowLocationDetailsSegue", sender: indexPath)
    }
}
