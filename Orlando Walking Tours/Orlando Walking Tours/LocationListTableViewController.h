//
//  LocationListTableViewController.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoricLocation.h"

@interface LocationListTableViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *locationsArray;
@property (nonatomic, retain) HistoricLocation *selectedHistoricLocation;

@end
