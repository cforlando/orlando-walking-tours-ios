//
//  Location.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HistoricLocation : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSDate *localRegistryDate;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, retain) NSString *locationTitle;
@property (nonatomic, retain) NSString *locationType;
@property (nonatomic, retain) NSString *locationDescription;

@end
