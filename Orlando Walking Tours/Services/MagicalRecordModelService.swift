//
//  MagicalRecordModelService.swift
//  Orlando Walking Tours
//
//  Created by Greg Barr on 6/11/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import MagicalRecord

// !!! Needs work, especially adding location.

class MagicalRecordModelService : ModelService {
    
    func createTour(uuid uuid: NSUUID, title: String, completion: ModelServiceCompletionHandler?) {
        MagicalRecord.saveWithBlock({ localContext in
            let tour = Tour.MR_createEntityInContext(localContext)
            tour?.uuid = uuid.UUIDString
            tour?.title = title
        }, completion: completion)
    }

    func deleteTour(tour tour: Tour, completion: ModelServiceCompletionHandler?) {
        MagicalRecord.saveWithBlock({ localContext in
            tour.MR_deleteEntityInContext(localContext)
        }, completion: completion)
    }

    func findAllTours() -> [Tour]? {
        if let tours = Tour.MR_findAll() as? [Tour] {
            return tours
        }
        return nil
    }

    func findTour(byUUID uuid: NSUUID, completion: Tour? -> Void) {
        if let tour = Tour.MR_findFirstByAttribute("uuid", withValue: uuid.UUIDString) {
            completion(tour)
        }
    }
    
    func addLocation(location: HistoricLocation, toTour tour: Tour, completion: ModelServiceCompletionHandler?) {
        MagicalRecord.saveWithBlock({ localContext in
            let localLocation = HistoricLocation.MR_createEntity()!
            localLocation.address = location.address;
            localLocation.localRegistryDate = location.localRegistryDate;
            localLocation.locationTitle = location.locationTitle;
            localLocation.locationType = location.locationType;
            localLocation.locationDescription = location.locationDescription;
            localLocation.latitude = location.latitude;
            localLocation.longitude = location.longitude;

            // MagicalRecord: Not sure proper way to add an entity to the parent's collection.
//            let localTour = tour.MR_inContext(localContext)
            localLocation.tour = tour
//            localTour?.historiclocations = tour.historiclocations?.setByAddingObjectsFromArray([location])
        }, completion: completion)
    }
    
    // !!! Needs work, update sortOrder, etc
    func removeLocation(location: HistoricLocation, fromTour tour: Tour, completion: ModelServiceCompletionHandler?) {
        let locations = tour.historicLocations?.filter {
            let loc = $0 as! HistoricLocation
            return loc.locationId != location.locationId
        }
        tour.historicLocations = NSSet(array: locations!)
    }
}