//
//  LocationDetailViewController.m
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import "LocationDetailViewController.h"
#import "LocationAnnotation.h"

@interface LocationDetailViewController ()

@end

@implementation LocationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.historicLocation.locationTitle);
    
    self.titleLabel.text = self.historicLocation.locationTitle;
    self.typeLabel.text = self.historicLocation.locationType;
    self.descriptionLabel.text = self.historicLocation.locationDescription;
    self.address1Label.text = self.historicLocation.address;
    
    // Set the location's annotation and zoom in
    LocationAnnotation *annotation = [[LocationAnnotation alloc] initWithHistoricLocation:self.historicLocation];
    [self.mapView addAnnotation:annotation];
    [self.mapView setRegion:MKCoordinateRegionMake(annotation.coordinate, MKCoordinateSpanMake(.0125, .0125))];
}

-(void)viewDidAppear:(BOOL)animated {
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000); 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
-(IBAction)saveLocationTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(locationDetailViewController:didSelectHistoricLocation:)]) {
        [self.delegate locationDetailViewController:self didSelectHistoricLocation:self.historicLocation];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
