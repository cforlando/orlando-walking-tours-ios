//
//  DataServiceProtocol.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/16/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation

protocol DataServiceProtocol
{
    func getLocations(completion: (locations: [HistoricLocation]) -> Void)
}