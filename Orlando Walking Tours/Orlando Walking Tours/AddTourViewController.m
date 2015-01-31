//
//  AddTourViewController.m
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import "AddTourViewController.h"
#import "Tour.h"

@interface AddTourViewController ()

@end

@implementation AddTourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveTourTapped:(id)sender {
    
    Tour *tour = [Tour new];
    tour.title = self.tourTitleTextField.text;
    NSLog(@"%@", self.tourTitleTextField.text);
    
    // TODO: Implement saving a tour
    
    [self performSegueWithIdentifier:@"ShowLocationList" sender:self];
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
