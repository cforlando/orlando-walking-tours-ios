//
//  FirebaseDataService.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 5/9/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase

struct FirebaseDataService : DataService
{
    let ref = FIRDatabase.database().reference()

    ////////////////////////////////////////////////////////////

    func getLocations(completion: (locations: [HistoricLocation]) -> Void)
    {
        let historicLocationsRef = ref.child("historic-locations")

        historicLocationsRef.observeSingleEventOfType(.Value, withBlock:
        { snapshot in
            var locations = [HistoricLocation]()

            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                for snap in snapshots
                {
                    if let locationDict = snap.value as? [String : AnyObject]
                    {
                        let locationJSON = JSON(locationDict)

                        if let location = HistoricLocation.MR_createEntity()
                        {
                            if let title = locationJSON["name"].string,
                               let description = locationJSON["description"].string,
                               let address = locationJSON["address"].string,
                               let locationType = locationJSON["type"].string
                            {
                                location.locationTitle = title
                                location.locationDescription = description
                                location.address = address
                                location.locationType = locationType
                            }

                            if let latitude = locationJSON["location"]["latitude"].double,
                               let longitude = locationJSON["location"]["longitude"].double
                            {
                                location.latitude = latitude
                                location.longitude = longitude
                            }

                            if let localRegistryDate = locationJSON["localRegistryDate"].string
                            {
                                location.localRegistryDate = NSDateFormatter().dateFromString(localRegistryDate)
                            }

                            if let nationalRegistryDate = locationJSON["nationalRegistryDate"].string
                            {
                                location.nrhpDate = NSDateFormatter().dateFromString(nationalRegistryDate)
                            }

                            locations.append(location)
                        }
                    }
                }
                
                print(locations.count)
                completion(locations: locations)
            }
        })
    }
}