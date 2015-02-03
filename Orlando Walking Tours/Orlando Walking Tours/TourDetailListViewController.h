//
//  TourDetailListViewController.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 2/2/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tour;

@interface TourDetailListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *locationsArray;
@property (nonatomic, retain) Tour *tour;

@end
