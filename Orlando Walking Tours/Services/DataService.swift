//
//  DataService.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/16/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import UIKit

protocol DataService
{
    func getLocations(completion: @escaping (_ locations: [HistoricLocation]) -> Void)
    func getPhotos(for location: HistoricLocation, at path: String, completion: ([UIImage]?) -> Void)
}
