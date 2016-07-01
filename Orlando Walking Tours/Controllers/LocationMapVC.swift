//
//  LocationMapVC.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 5/8/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import MapKit

class LocationMapVC: UIViewController, MKMapViewDelegate
{
    ////////////////////////////////////////////////////////////
    // MARK: - Outlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var modeButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var listView: UITableView!
    
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    let centerPoint = CLLocationCoordinate2DMake(28.540655, -81.381483)
    var locations = [HistoricLocation]()
    
    enum Mode {
        case List, Map
    }
    var mode: Mode = .List

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Lifecycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mapView.delegate = self
        listView.dataSource = self
        listView.delegate = self

        let region = MKCoordinateRegionMakeWithDistance(centerPoint, 2000, 2000)
        mapView.setRegion(region, animated: true)

        FirebaseDataService.sharedInstance.getLocations()
        { locations in
            self.locations = locations.sort {
                $0.locationTitle <= $1.locationTitle
            }
            
            var annotations = [LocationAnnotation]()
            for location in locations
            {
                let annotation = LocationAnnotation(location: location)
                annotations.append(annotation)
            }

            dispatch_async(dispatch_get_main_queue())
            {
                self.mapView.addAnnotations(annotations)
                self.listView.reloadData()
            }
        }
        toggleMode()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func modeButtonPressed(sender: AnyObject) {
        toggleMode()
        /*
        let storyboard = UIStoryboard(name: "LocationList", bundle: nil)
        let listVC = storyboard.instantiateViewControllerWithIdentifier("LocationList")
        listVC.modalTransitionStyle = .FlipHorizontal
        self.navigationController?.pushViewController(listVC, animated: true)
        */
    }

    func toggleMode() {
        var toggleAnim: (() -> Void)! = nil
        if mode == .Map {
            mode = .List
            modeButton.title = "Map"
            toggleAnim = {
                self.listView.alpha = 1
                self.mapView.alpha = 0
            }
        } else {
            mode = .Map
            modeButton.title = "List"
            toggleAnim = {
                self.mapView.alpha = 1
                self.listView.alpha = 0
            }
        }
        UIView.animateWithDuration(0.25, animations: toggleAnim)
    }
}

extension LocationMapVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    var cellIdentifier: String {
        return "cell"
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellView: UITableViewCell!
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            cellView = cell
        } else {
            cellView = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        let location = locations[indexPath.row]
        cellView.textLabel?.text = location.locationTitle
        cellView.detailTextLabel?.text = location.address
        return cellView
    }
}
