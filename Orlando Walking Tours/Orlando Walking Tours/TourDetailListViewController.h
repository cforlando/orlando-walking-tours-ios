//
//  TourDetailListViewController.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 2/2/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationListTableViewController.h"
#import "LocationDetailViewController.h"

@class Tour;

@interface TourDetailListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, LocationListTableViewControllerDelegate, LocationDetailViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *locationsArray;
@property (nonatomic, retain) Tour *tour;

@end
