//
//  SocrataDataService.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/16/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SocrataDataService : DataService
{
    let locationsUrlString = "https://brigades.opendatanetwork.com/resource/aq56-mwpv.json"

    ////////////////////////////////////////////////////////////
    
    func getLocations(completion: @escaping (_ locations: [HistoricLocation]) -> Void)
    {
        var locations = [HistoricLocation]()

        Alamofire.request(locationsUrlString).validate().responseJSON
        { response in
            switch response.result
            {
            case .success:
                if let value = response.result.value
                {
                    let json = JSON(value)
                    for (_, subJson) in json
                    {
                        let location = HistoricLocation.mr_createEntity()
                        if let location = location
                        {
                            if let id = subJson["id"].string
                            {
                                location.id = NumberFormatter().number(from: id)
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
                                location.longitude = NSNumber(value: longitude)
                            }
                            
                            if let latitude = subJson["location"]["coordinates"][1].double
                            {
                                location.latitude = NSNumber(value: latitude)
                            }
                            
                            if let localRegistryDate = subJson["local"].string
                            {
                                location.localRegistryDate = DateFormatter().date(from: localRegistryDate) as NSDate?
                            }
                            
                            if let nrhpDate = subJson["nhrp"].string
                            {
                                location.nrhpDate = DateFormatter().date(from: nrhpDate) as NSDate?
                            }
                            
                            locations.append(location)
                        }
                    }
                    
                    completion(locations)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func getPhotos(for location: HistoricLocation, at path: String, completion: ([UIImage]?) -> Void)
    {
        completion(nil)
    }
}
