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
    
    func findAllTours() -> NSArray
    
    func createTour(title title: String, completion: ModelServiceCompletionHandler?)
    
    func addLocation(location: HistoricLocation, toTour tour: Tour, completion: ModelServiceCompletionHandler?)
    func removeLocation(location: HistoricLocation, fromTour tour: Tour, completion: ModelServiceCompletionHandler?)
}