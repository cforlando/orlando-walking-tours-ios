//
//  DashboardTableViewController.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTourViewController.h"

@interface DashboardTableViewController : UITableViewController <AddTourViewControllerDelegate>

@property (nonatomic, retain) NSArray *toursArray;

@end
