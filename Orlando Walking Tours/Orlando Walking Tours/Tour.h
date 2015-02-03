//
//  Tour.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 2/2/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreData+MagicalRecord.h"

@interface Tour : NSManagedObject

@property (nonatomic, retain) NSString * title;

@end
