//
//  DataService.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 5/9/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct DataService
{
    static let sharedInstance = DataService()

    func getLocations(completion: (locations: [HistoricLocation]) -> Void)
    {
        let locationsUrlString = "https://brigades.opendatanetwork.com/resource/aq56-mwpv.json"
        var locations = [HistoricLocation]()
        
        Alamofire.request(.GET, locationsUrlString).validate().responseJSON
        { response in
            switch response.result
            {
            case .Success:
                if let value = response.result.value
                {
                    let json = JSON(value)
                    for (_, subJson) in json
                    {
                        let location = HistoricLocation.MR_createEntity()
                        if let location = location
                        {
                            if let id = subJson["id"].string
                            {
                                location.id = Int(id)
                            }

                            if let title = subJson["name"].string
                            {
                                location.locationTitle = title
                            }

                            if let description = subJson["downtown_walking_tour"].string
                            {
                                location.locationDescription = description
                            }

                            if let address = subJson["address"].string
                            {
                                location.address = address
                            }

                            if let locationType = subJson["type"].string
                            {
                                location.locationType = locationType
                            }

                            if let longitude = subJson["location"]["coordinates"][0].double
                            {
                               location.longitude = longitude
                            }

                            if let latitude = subJson["location"]["coordinates"][1].double
                            {
                                location.latitude = latitude
                            }

                            if let localRegistryDate = subJson["local"].string
                            {
                                location.localRegistryDate = NSDateFormatter().dateFromString(localRegistryDate)
                            }

                            if let nrhpDate = subJson["nhrp"].string
                            {
                                location.nrhpDate = NSDateFormatter().dateFromString(nrhpDate)
                            }

                            locations.append(location)
                        }
                    }

                    completion(locations: locations)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
}