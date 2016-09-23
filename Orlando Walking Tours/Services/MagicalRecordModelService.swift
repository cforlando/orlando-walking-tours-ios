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

class MagicalRecordModelService : ModelService
{
    ////////////////////////////////////////////////////////////
    // MARK: - Tours
    ////////////////////////////////////////////////////////////

    func createTour(withName title: String, completion: ((_ uuid: NSUUID, _ success: Bool, _ error: NSError?) -> Void)?)
    {
        let uuid = NSUUID()
        MagicalRecord.saveWithBlock(
        { localContext in
            let tour = Tour.MR_createEntityInContext(localContext)
            tour?.uuid = uuid.UUIDString
            tour?.title = title
        })
        { success, error in
            completion?(uuid: uuid, success: success, error: error)
        }
    }

    ////////////////////////////////////////////////////////////

    func deleteTour(tour: Tour, completion: ModelServiceCompletionHandler?)
    {
        MagicalRecord.saveWithBlock(
        { localContext in
            tour.MR_deleteEntityInContext(localContext)
        }, completion: completion)
    }

    ////////////////////////////////////////////////////////////

    func findAllTours() -> [Tour]?
    {
        if let tours = Tour.mr_findAll() as? [Tour]
        {
            return tours
        }

        return nil
    }

    ////////////////////////////////////////////////////////////

    func findTour(byUUID uuid: NSUUID, completion: (Tour?) -> Void)
    {
        if let tour = Tour.mr_findFirst(byAttribute: "uuid", withValue: uuid.uuidString)
        {
            completion(tour)
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - HistoricLocations
    ////////////////////////////////////////////////////////////

    func addLocation(location: HistoricLocation, toTour tour: Tour, completion: ModelServiceCompletionHandler?)
    {
        MagicalRecord.saveWithBlock(
        { localContext in
            let localLocation = HistoricLocation.MR_createEntityInContext(localContext)
            localLocation?.address = location.address;
            localLocation?.localRegistryDate = location.localRegistryDate;
            localLocation?.locationTitle = location.locationTitle;
            localLocation?.locationType = location.locationType;
            localLocation?.locationDescription = location.locationDescription;
            localLocation?.latitude = location.latitude;
            localLocation?.longitude = location.longitude;

            let localTour = tour.MR_inContext(localContext)
            localLocation?.tour = localTour
        }, completion: completion)
    }

    ////////////////////////////////////////////////////////////

    func loadLocations(fromTour tour: Tour) -> [HistoricLocation]?
    {
        let predicate = NSPredicate(format: "tour == %@", argumentArray: [tour])
        if let locations = HistoricLocation.mr_findAll(with: predicate) as? [HistoricLocation]
        {
            return locations
        }

        return nil
    }

    ////////////////////////////////////////////////////////////

    // !!! Needs work, update sortOrder, etc
    func removeLocation(location: HistoricLocation, fromTour tour: Tour, completion: ModelServiceCompletionHandler?)
    {
        let locations = tour.historicLocations?.filter
        {
            let loc = $0 as! HistoricLocation
            return loc.locationId != location.locationId
        }

        tour.historicLocations = NSSet(array: locations!)
    }
}
