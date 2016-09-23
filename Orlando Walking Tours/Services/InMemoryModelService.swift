//
//  InMemoryModelService.swift
//  Orlando Walking Tours
//
//  Created by Greg Barr on 6/12/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation

class InMemoryModelService : ModelService {
    
    var tours: [Tour]
    
    init() {
        self.tours = []
    }

    func seed(locations:[HistoricLocation]) {
        self.createTour(withName: "Classic Homes", completion: nil)
        self.createTour(withName: "City Buildings", completion: nil)
        let cityTour = self.tours[1]
        // add some locations to tour
        // when printed to verify why were first two in reverse order?
        self.addLocation(location: locations[0], toTour: cityTour, completion: nil)
        self.addLocation(location: locations[2], toTour: cityTour, completion: nil)
        self.addLocation(location: locations[3], toTour: cityTour, completion: nil)
        self.addLocation(location: locations[5], toTour: cityTour, completion: nil)
    }
    
    func findAllTours() -> [Tour]? {
        return tours
    }

    func findTour(byUUID uuid: UUID, completion: (Tour?) -> Void) {
        for tour in tours {
            if tour.uuid! == uuid.uuidString {
                completion(tour)
            }
        }
    }
    
    func createTour(withName title: String, completion: ((_ uuid: UUID, _ success: Bool, _ error: Error?) -> Void)?) {
        let newTour = Tour.mr_createEntity()!
        newTour.title = title
        tours.append(newTour)
        completion?(UUID(), true, nil)
    }

    func deleteTour(tour: Tour, completion: ModelServiceCompletionHandler?) {
        for localTour in tours {
            if localTour.uuid == tour.uuid {
                localTour.mr_deleteEntity()
                completion?(true, nil)
                break
            }
        }
    }
    
    func addLocation(location: HistoricLocation, toTour tour: Tour, completion: ModelServiceCompletionHandler?) {
        if let historicLocations = tour.historicLocations {
            location.sortOrder = historicLocations.count as NSNumber?
            print("Tour \(tour.title) Loc: \(location.sortOrder) \(location.locationTitle)")
            tour.historicLocations = historicLocations.adding(location) as NSSet?
        } else {
            location.sortOrder = 0
            tour.historicLocations = [location]
        }
        completion?(true, nil)
    }

    func loadLocations(fromTour tour: Tour) -> [HistoricLocation]?
    {
        return nil
    }
    
    func removeLocation(location: HistoricLocation, fromTour tour: Tour, completion: ModelServiceCompletionHandler?) {
        let sortOrder = location.sortOrder
        // since Set is immutable we can't remove,
        // so effectively remove by filtering all but the location we want to remove
        if let locations = tour.historicLocations?.filter({
            let loc = $0 as! HistoricLocation
            return loc.locationId != location.locationId
        }) {
            tour.historicLocations = NSSet(array: locations)
            // now update sortOrder of locations since we removed one
            for locTemp in tour.historicLocations! {
                let loc = locTemp as! HistoricLocation
                if loc.sortOrder!.compare(sortOrder!) == ComparisonResult.orderedDescending {
                    loc.sortOrder = NSNumber(value: (loc.sortOrder?.int32Value)! - 1)
                }
            }
        }
        completion?(true, nil)
    }
}
