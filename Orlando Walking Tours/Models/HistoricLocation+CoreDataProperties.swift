//
//  HistoricLocation+CoreDataProperties.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 9/23/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import CoreData

extension HistoricLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoricLocation> {
        return NSFetchRequest<HistoricLocation>(entityName: "HistoricLocation");
    }

    @NSManaged public var address: String?
    @NSManaged public var id: NSNumber?
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var localRegistryDate: NSDate?
    @NSManaged public var locationDescription: String?
    @NSManaged public var locationTitle: String?
    @NSManaged public var locationType: String?
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var nrhpDate: NSDate?
    @NSManaged public var sortOrder: NSNumber?
    @NSManaged public var tour: Tour?

}
