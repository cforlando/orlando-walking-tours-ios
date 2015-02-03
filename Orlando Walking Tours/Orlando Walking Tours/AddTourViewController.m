//
//  AddTourViewController.m
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import "AddTourViewController.h"
#import "Tour.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

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
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Tour *tour = [Tour MR_createInContext:localContext];
        tour.title = self.tourTitleTextField.text;
    } completion:^(BOOL success, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(addTourViewControllerDidSaveTour:)]) {
            [self.delegate addTourViewControllerDidSaveTour:self];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
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
