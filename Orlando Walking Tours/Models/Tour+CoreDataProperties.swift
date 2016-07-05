//
//  Tour+CoreDataProperties.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 7/5/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Tour {

    @NSManaged var title: String?
    @NSManaged var uuid: String?
    @NSManaged var historicLocations: NSSet?

}
