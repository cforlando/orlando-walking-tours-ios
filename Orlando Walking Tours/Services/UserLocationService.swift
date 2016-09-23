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
    
    func startTracking(callback: @escaping Callback) {
        self.callback = callback
        configureLocationManager()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocation related methods

    func configureLocationManager()
    {
        if CLLocationManager.authorizationStatus() != .denied && CLLocationManager.authorizationStatus() != .restricted
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            if CLLocationManager.authorizationStatus() == .notDetermined
            {
                locationManager.requestWhenInUseAuthorization()
            }
            else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
            {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.last
        {
            callback(location)
        }
    }

}
