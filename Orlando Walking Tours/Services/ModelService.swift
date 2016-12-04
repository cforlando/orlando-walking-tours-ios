//
//  ModelService.swift
//  Orlando Walking Tours
//
//  Created by Greg Barr on 6/11/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation

typealias ModelServiceCompletionHandler = (Bool, Error?) -> Void

protocol ModelService {
    
    func findAllTours() -> [Tour]?
    func findTour(byUUID uuid: UUID, completion: (Tour?) -> Void)

    func createTour(withName title: String, completion: ((_ uuid: UUID, _ success: Bool, _ error: Error?) -> Void)?)
    func deleteTour(tour: Tour, completion: ModelServiceCompletionHandler?)

    func add(_ location: HistoricLocation, to tour: Tour, completion: ModelServiceCompletionHandler?)
    func loadLocations(fromTour tour: Tour) -> [HistoricLocation]?
    func removeLocation(location: HistoricLocation, fromTour tour: Tour, completion: ModelServiceCompletionHandler?)
}
