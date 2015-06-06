//
//  NSArray+HistoricLocation.h
//  Orlando Walking Tours
//
//  Created by John Li on 6/6/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HistoricLocation;

@interface NSArray (HistoricLocation)

-(BOOL)containsLocation: (HistoricLocation*) location;

@end
