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
import FirebaseStorage

struct FirebaseDataService : DataService
{
   ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference(forURL: "gs://orlando-walking-tours.appspot.com")

    ////////////////////////////////////////////////////////////

    func getLocations(completion: @escaping ([HistoricLocation]) -> Void)
    {
        let historicLocationsRef = databaseRef.child("historic-locations").child("orlando")

        historicLocationsRef.observeSingleEvent(of: .value, with:
        { snapshot in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000"

            var locations = [HistoricLocation]()

            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                for snap in snapshots
                {
                    if let locationDict = snap.value as? [String : AnyObject]
                    {
                        let locationJSON = JSON(locationDict)

                        if let location = HistoricLocation.mr_createEntity()
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
                                location.latitude = latitude as NSNumber
                                location.longitude = longitude as NSNumber
                            }

                            if let localRegistryDate = locationJSON["localRegistryDate"].string
                            {
                                location.localRegistryDate = formatter.date(from: localRegistryDate) as NSDate?
                            }

                            if let nationalRegistryDate = locationJSON["nationalRegistryDate"].string
                            {
                                location.nrhpDate = formatter.date(from: nationalRegistryDate) as NSDate?
                            }

                            locations.append(location)
                        }
                    }
                }
                
                print(locations.count)
                completion(locations)
            }
        })
    }

    ////////////////////////////////////////////////////////////

    func getPhotos(forLocation location: HistoricLocation, completion: ([UIImage]?) -> Void)
    {
        // TODO: Implement this function
        completion(nil)
    }
}
