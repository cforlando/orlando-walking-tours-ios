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
        self.addLocation(locations[0], toTour: cityTour, completion: nil)
        self.addLocation(locations[2], toTour: cityTour, completion: nil)
        self.addLocation(locations[3], toTour: cityTour, completion: nil)
        self.addLocation(locations[5], toTour: cityTour, completion: nil)
    }
    
    func findAllTours() -> [Tour]? {
        return tours
    }

    func findTour(byUUID uuid: NSUUID, completion: Tour? -> Void) {
        for tour in tours {
            if tour.uuid == uuid {
                completion(tour)
            }
        }
    }
    
    func createTour(withName title: String, completion: ((uuid: NSUUID, success: Bool, error: NSError?) -> Void)?) {
        let newTour = Tour.MR_createEntity()!
        newTour.title = title
        tours.append(newTour)
        completion?(uuid: NSUUID(), success: true, error: nil)
    }

    func deleteTour(tour tour: Tour, completion: ModelServiceCompletionHandler?) {
        for localTour in tours {
            if localTour.uuid == tour.uuid {
                localTour.MR_deleteEntity()
                completion?(true, nil)
                break
            }
        }
    }
    
    func addLocation(location: HistoricLocation, toTour tour: Tour, completion: ModelServiceCompletionHandler?) {
        if let historicLocations = tour.historicLocations {
            location.sortOrder = historicLocations.count
            print("Tour \(tour.title) Loc: \(location.sortOrder) \(location.locationTitle)")
            tour.historicLocations = historicLocations.setByAddingObject(location)
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
                if loc.sortOrder!.compare(sortOrder!) == NSComparisonResult.OrderedDescending {
                    loc.sortOrder = NSNumber(int: (loc.sortOrder?.intValue)! - 1)
                }
            }
        }
        completion?(true, nil)
    }
}