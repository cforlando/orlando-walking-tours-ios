//
//  Tour+CoreDataProperties.swift
//  Orlando Walking Tours
//
//  Created by Keli'i Martin on 9/23/16.
//  Copyright © 2016 Code for Orlando. All rights reserved.
//

import Foundation
import CoreData

extension Tour {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tour> {
        return NSFetchRequest<Tour>(entityName: "Tour");
    }

    @NSManaged public var title: String?
    @NSManaged public var uuid: String?
    @NSManaged public var historicLocations: NSSet?

}

// MARK: Generated accessors for historicLocations
extension Tour {

    @objc(addHistoricLocationsObject:)
    @NSManaged public func addToHistoricLocations(_ value: HistoricLocation)

    @objc(removeHistoricLocationsObject:)
    @NSManaged public func removeFromHistoricLocations(_ value: HistoricLocation)

    @objc(addHistoricLocations:)
    @NSManaged public func addToHistoricLocations(_ values: NSSet)

    @objc(removeHistoricLocations:)
    @NSManaged public func removeFromHistoricLocations(_ values: NSSet)

}
