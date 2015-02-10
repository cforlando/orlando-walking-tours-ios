//
//  LocationListTableViewController.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoricLocation.h"
#import "LocationDetailViewController.h"

@class LocationListTableViewController;

@protocol LocationListTableViewControllerDelegate <NSObject>

-(void)locationListTableViewController:(LocationListTableViewController *)controller didSelectHistoricLocation:(HistoricLocation *)location;

@end

@interface LocationListTableViewController : UITableViewController <LocationDetailViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray *locationsArray;
@property (nonatomic, retain) HistoricLocation *selectedHistoricLocation;
@property (weak) id delegate;

-(IBAction)tappedSave:(id)sender;

@end
