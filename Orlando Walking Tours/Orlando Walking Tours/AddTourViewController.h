//
//  AddTourViewController.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddTourViewController;

@protocol AddTourViewControllerDelegate <NSObject>

-(void)addTourViewControllerDidSaveTour:(AddTourViewController *)controller;

@end

@interface AddTourViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *tourTitleTextField;
@property (weak) id delegate;

-(IBAction)saveTourTapped:(id)sender;

@end
