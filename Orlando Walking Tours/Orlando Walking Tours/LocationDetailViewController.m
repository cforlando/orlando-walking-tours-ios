//
//  LocationDetailViewController.m
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import "LocationDetailViewController.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
