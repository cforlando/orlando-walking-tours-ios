//
//  LocationAnnotation.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 5/8/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import UIKit
import MapKit

class LocationAnnotation: NSObject, MKAnnotation
{
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    let coordinate: CLLocationCoordinate2D
    var title: String? = nil
    var subtitle: String? = nil
    let churchStreetStation = CLLocationCoordinate2DMake(28.540655, -81.381483)

    ////////////////////////////////////////////////////////////
    // MARK: - MKAnnotation
    ////////////////////////////////////////////////////////////

    init(location: HistoricLocation)
    {
        if let latitude = location.latitude?.doubleValue,
            let longitude = location.longitude?.doubleValue
        {
            self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        }
        else
        {
            self.coordinate = churchStreetStation
        }

        if let title = location.locationTitle,
            let subtitle = location.address
        {
            self.title = title
            self.subtitle = subtitle
        }
    }
}
