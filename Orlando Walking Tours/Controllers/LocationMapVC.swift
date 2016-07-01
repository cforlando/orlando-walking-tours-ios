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

    @IBOutlet weak var mapView: MKMapView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    let centerPoint = CLLocationCoordinate2DMake(28.540655, -81.381483)
    var locations = [HistoricLocation]()

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Lifecycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        mapView.delegate = self

        let region = MKCoordinateRegionMakeWithDistance(centerPoint, 2000, 2000)
        mapView.setRegion(region, animated: true)

        DataService.sharedInstance.getLocations()
        { locations in
            var annotations = [LocationAnnotation]()
            for location in locations
            {
                let annotation = LocationAnnotation(location: location)
                annotations.append(annotation)
            }

            dispatch_async(dispatch_get_main_queue())
            {
                self.mapView.addAnnotations(annotations)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
