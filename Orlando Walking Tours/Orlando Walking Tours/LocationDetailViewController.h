//
//  LocationDetailViewController.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoricLocation.h"
#import <MapKit/MapKit.h>

@class LocationDetailViewController;

@protocol LocationDetailViewControllerDelegate <NSObject>

-(void)locationDetailViewController:(LocationDetailViewController *)controller didSelectHistoricLocation:(HistoricLocation *)location;

@end


@interface LocationDetailViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *address1Label;

@property (nonatomic, retain) IBOutlet UIButton *addButton;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property id delegate;

@property (nonatomic, retain) HistoricLocation *historicLocation;

-(IBAction)saveLocationTapped:(id)sender;

@end
