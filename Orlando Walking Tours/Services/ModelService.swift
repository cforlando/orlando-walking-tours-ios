//
//  ModelService.swift
//  Orlando Walking Tours
//
//  Created by Greg Barr on 6/11/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation

typealias ModelServiceCompletionHandler = (Bool, NSError?) -> Void

protocol ModelService {
    
    func findAllTours() -> [Tour]?
    func findTour(byUUID uuid: NSUUID, completion: Tour? -> Void)

    func createTour(withName title: String, completion: ((uuid: NSUUID, success: Bool, error: NSError?) -> Void)?)
    func deleteTour(tour tour: Tour, completion: ModelServiceCompletionHandler?)

    func addLocation(location: HistoricLocation, toTour tour: Tour, completion: ModelServiceCompletionHandler?)
    func loadLocations(fromTour tour: Tour) -> [HistoricLocation]?
    func removeLocation(location: HistoricLocation, fromTour tour: Tour, completion: ModelServiceCompletionHandler?)
}