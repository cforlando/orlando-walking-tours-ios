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

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.loadLocations()
    }

    ////////////////////////////////////////////////////////////
    // MARK: - IBActions
    ////////////////////////////////////////////////////////////

    @IBAction func addMoreLocationsTapped(sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "AddMoreLocationsSegue", sender: nil)
    }

    ////////////////////////////////////////////////////////////

    @IBAction func homeTapped(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "unwindToDashboard", sender: nil)
    }
    
    ////////////////////////////////////////////////////////////
    // MARK: - Navigation
    ////////////////////////////////////////////////////////////

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)

        if let navController = segue.destination as? UINavigationController
        {
            if let vc = navController.topViewController as? LocationListVC,
                segue.identifier == "AddMoreLocationsSegue"
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
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tour?.historicLocations?.count ?? 0
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        tableView.rowHeight = UITableViewAutomaticDimension
        return 70
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let location = self.locations[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentLocationTableViewCell.reuseIdentifier, for: indexPath) as? CurrentLocationTableViewCell else
        {
            return UITableViewCell()
        }
        
        cell.configureImage(frame: cell.locationThumbnail.frame)
        cell.locationLabel.text = location.locationTitle
        cell.addressLabel.text = location.address

        return cell
    }

    ////////////////////////////////////////////////////////////

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "ShowLocationDetailsSegue", sender: indexPath)
    }
}
