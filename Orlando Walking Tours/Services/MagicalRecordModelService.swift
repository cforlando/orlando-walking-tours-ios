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

    func createTour(withName title: String, completion: ((_ uuid: UUID, _ success: Bool, _ error: Error?) -> Void)?)
    {
        let uuid = UUID()
        MagicalRecord.save(
        { localContext in
            let tour = Tour.mr_createEntity(in: localContext)
            tour?.uuid = uuid.uuidString
            tour?.title = title
        })
        { success, error in
            completion?(uuid, success, error)
        }
    }

    ////////////////////////////////////////////////////////////

    func deleteTour(tour: Tour, completion: ModelServiceCompletionHandler?)
    {
        MagicalRecord.save(
        { localContext in
            tour.mr_deleteEntity(in: localContext)
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

    func findTour(byUUID uuid: UUID, completion: (Tour?) -> Void)
    {
        if let tour = Tour.mr_findFirst(byAttribute: "uuid", withValue: uuid.uuidString)
        {
            completion(tour)
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - HistoricLocations
    ////////////////////////////////////////////////////////////

    func add(_ location: HistoricLocation, to tour: Tour, completion: ModelServiceCompletionHandler?)
    {
        MagicalRecord.save(
        { localContext in
            let localLocation = HistoricLocation.mr_createEntity(in: localContext)
            localLocation?.address = location.address;
            localLocation?.localRegistryDate = location.localRegistryDate;
            localLocation?.locationTitle = location.locationTitle;
            localLocation?.locationType = location.locationType;
            localLocation?.locationDescription = location.locationDescription;
            localLocation?.latitude = location.latitude;
            localLocation?.longitude = location.longitude;

            let localTour = tour.mr_(in: localContext)
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
