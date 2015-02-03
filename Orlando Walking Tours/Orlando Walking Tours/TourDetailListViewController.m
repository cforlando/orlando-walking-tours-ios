//
//  TourDetailListViewController.m
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 2/2/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import "TourDetailListViewController.h"
#import "Tour.h"
#import "HistoricLocation.h"
#import "LocationListTableViewController.h"

@interface TourDetailListViewController ()

@end

@implementation TourDetailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.tour.title;
    
    self.locationsArray = [NSMutableArray new];
    
    [self loadLocations];
    
    // Do any additional setup after loading the view.
}

-(void)loadLocations {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tour == %@", self.tour];
    NSArray *locations = [HistoricLocation MR_findAllWithPredicate:predicate];
    self.locationsArray = [NSMutableArray arrayWithArray:locations];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locationsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    HistoricLocation *location = [self.locationsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = location.locationTitle;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    view.backgroundColor = [UIColor blueColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150, 0, 140, 40)];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [button setTitle:@"Add Locations" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addLocationsTapped:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


-(void)addLocationsTapped:(id)sender {
    [self performSegueWithIdentifier:@"ShowLocationList" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowLocationList"]) {
        LocationListTableViewController *vc = (LocationListTableViewController *)segue.destinationViewController;
        vc.delegate = self;
    }
}

-(void)locationListTableViewController:(LocationListTableViewController *)controller didSelectHistoricLocation:(HistoricLocation *)location {

    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        HistoricLocation *localLocation = [HistoricLocation MR_createInContext:localContext];
        
        localLocation.address = location.address;
        localLocation.localRegistryDate = location.localRegistryDate;
        localLocation.locationTitle = location.locationTitle;
        localLocation.locationType = location.locationType;
        localLocation.locationDescription = location.locationDescription;
        localLocation.latitude = location.latitude;
        localLocation.longitude = location.longitude;
        
        localLocation.tour = [self.tour MR_inContext:localContext];
        
        [self.locationsArray addObject:localLocation];
        
    } completion:^(BOOL success, NSError *error) {
        if (!error) {
            
        } else {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        
        [self.tableView reloadData];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
