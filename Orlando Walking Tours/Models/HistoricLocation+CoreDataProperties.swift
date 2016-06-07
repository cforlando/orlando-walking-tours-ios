//
//  HistoricLocation+CoreDataProperties.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 6/7/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HistoricLocation {

    @NSManaged var address: String?
    @NSManaged var id: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var localRegistryDate: NSDate?
    @NSManaged var locationDescription: String?
    @NSManaged var locationTitle: String?
    @NSManaged var locationType: String?
    @NSManaged var longitude: NSNumber?
    @NSManaged var nrhpDate: NSDate?
    @NSManaged var sortOrder: NSNumber?
    @NSManaged var tour: Tour?

}
