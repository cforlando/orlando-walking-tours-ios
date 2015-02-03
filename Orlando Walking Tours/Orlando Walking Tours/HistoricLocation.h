//
//  Location.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import "CoreData+MagicalRecord.h"

@class Tour;


@interface HistoricLocation : NSManagedObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSDate *localRegistryDate;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, retain) NSString *locationTitle;
@property (nonatomic, retain) NSString *locationType;
@property (nonatomic, retain) NSString *locationDescription;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) Tour *tour;

@end
