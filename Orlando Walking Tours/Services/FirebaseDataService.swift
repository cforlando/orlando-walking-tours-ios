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

struct FirebaseDataService : DataServiceProtocol
{
    let ref = FIRDatabase.database().reference()

    static let sharedInstance = FirebaseDataService()

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
                            if let title = locationJSON["name"].string
                            {
                                location.locationTitle = title
                            }

                            if let description = locationJSON["description"].string
                            {
                                location.locationDescription = description
                            }

                            if let address = locationJSON["address"].string
                            {
                                location.address = address
                            }

                            if let locationType = locationJSON["type"].string
                            {
                                location.locationType = locationType
                            }

                            if let latitude = locationJSON["location"]["latitude"].double
                            {
                                location.latitude = latitude
                            }

                            if let longitude = locationJSON["location"]["longitude"].double
                            {
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