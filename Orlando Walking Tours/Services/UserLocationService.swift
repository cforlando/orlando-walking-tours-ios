//
//  UserLocationService.swift
//  Orlando Walking Tours
//
//  Created by Greg Barr on 6/30/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import CoreLocation

class UserLocationService : NSObject, CLLocationManagerDelegate {
    
    typealias Callback = (CLLocation) -> Void
    var callback: Callback!

    let locationManager = CLLocationManager()

    static let sharedService = UserLocationService()
    
    func startTracking(callback: Callback) {
        self.callback = callback
        configureLocationManager()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocation related methods

    func configureLocationManager()
    {
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Denied && CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Restricted
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined
            {
                locationManager.requestWhenInUseAuthorization()
            }
            else if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse
            {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print(error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.last
        {
            callback(location)
        }
    }

}