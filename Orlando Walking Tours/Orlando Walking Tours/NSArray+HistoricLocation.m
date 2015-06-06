//
//  NSArray+HistoricLocation.m
//  Orlando Walking Tours
//
//  Created by John Li on 6/6/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import "NSArray+HistoricLocation.h"
#import "HistoricLocation.h"

@implementation NSArray (HistoricLocation)

// NOTE: Without a unique id for historic locations, we are using address and locationTitle
-(BOOL) containsLocation: (HistoricLocation*) location
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"address == %@ && locationTitle == %@", location.address, location.locationTitle];
    NSArray * results = [self filteredArrayUsingPredicate:predicate];
    
    return [results count] > 0;
}


@end
