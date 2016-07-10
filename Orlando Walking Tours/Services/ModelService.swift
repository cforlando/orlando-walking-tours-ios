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

    func createTour(uuid uuid: NSUUID, title: String, completion: ModelServiceCompletionHandler?)
    func deleteTour(tour tour: Tour, completion: ModelServiceCompletionHandler?)

    func addLocation(location: HistoricLocation, toTour tour: Tour, completion: ModelServiceCompletionHandler?)
    func removeLocation(location: HistoricLocation, fromTour tour: Tour, completion: ModelServiceCompletionHandler?)
}