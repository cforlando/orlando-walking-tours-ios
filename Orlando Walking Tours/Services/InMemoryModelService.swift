//
//  InMemoryModelService.swift
//  Orlando Walking Tours
//
//  Created by Greg Barr on 6/12/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation

class InMemoryModelService : ModelService {
    
    var tours: NSMutableArray
    
    init() {
        self.tours = NSMutableArray()
    }
    
    func seed(locations:[HistoricLocation]) {
        self.createTour(title: "Classic Homes", completion: nil)
        self.createTour(title: "City Buildings", completion: nil)
        let cityTour = self.tours[1] as! Tour
        // add some locations to tour
        // when printed to verify why were first two in reverse order?
        self.addLocation(locations[0], toTour: cityTour, completion: nil)
        self.addLocation(locations[2], toTour: cityTour, completion: nil)
        self.addLocation(locations[3], toTour: cityTour, completion: nil)
        self.addLocation(locations[5], toTour: cityTour, completion: nil)
    }
    
    func findAllTours() -> NSArray {
        return tours
    }
    
    func createTour(title title: String, completion: ModelServiceCompletionHandler?) {
        let newTour = Tour.MR_createEntity()!
        newTour.title = title
        tours.addObject(newTour)
        completion?(true, nil)
    }
    
    func addLocation(location: HistoricLocation, toTour tour: Tour, completion: ModelServiceCompletionHandler?) {
        if let historicLocations = tour.historiclocations {
            location.sortOrder = historicLocations.count
            print("Tour \(tour.title) Loc: \(location.sortOrder) \(location.locationTitle)")
            tour.historiclocations = historicLocations.setByAddingObject(location)
        } else {
            location.sortOrder = 0
            tour.historiclocations = [location]
        }
        completion?(true, nil)
    }
    
    func removeLocation(location: HistoricLocation, fromTour tour: Tour, completion: ModelServiceCompletionHandler?) {
        let sortOrder = location.sortOrder
        // since Set is immutable we can't remove,
        // so effectively remove by filtering all but the location we want to remove
        if let locations = tour.historiclocations?.filter({
            let loc = $0 as! HistoricLocation
            return loc.locationId != location.locationId
        }) {
            tour.historiclocations = NSSet(array: locations)
            // now update sortOrder of locations since we removed one
            for locTemp in tour.historiclocations! {
                let loc = locTemp as! HistoricLocation
                if loc.sortOrder!.compare(sortOrder!) == NSComparisonResult.OrderedDescending {
                    loc.sortOrder = NSNumber(int: (loc.sortOrder?.intValue)! - 1)
                }
            }
        }
        completion?(true, nil)
    }
}