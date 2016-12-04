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
    func findTour(by uuid: UUID, completion: (Tour?) -> Void)

    func createTour(withName title: String, completion: ((_ uuid: UUID, _ success: Bool, _ error: Error?) -> Void)?)
    func deleteTour(_ tour: Tour, completion: ModelServiceCompletionHandler?)

    func add(location: HistoricLocation, to tour: Tour, completion: ModelServiceCompletionHandler?)
    func loadLocations(fromTour tour: Tour) -> [HistoricLocation]?
    func remove(location: HistoricLocation, from tour: Tour, completion: ModelServiceCompletionHandler?)
}
