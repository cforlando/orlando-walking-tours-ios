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
#import "HistoricLocationTableViewCell.h"
#import "NSArray+HistoricLocation.h"

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

-(void)viewDidAppear:(BOOL)animated {
    [self loadLocations];
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

#pragma mark - UITableViewDataSource Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locationsArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

#pragma mark - UITableViewDelegate Methods
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoricLocationTableViewCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoricLocationTableViewCell"];
    }
    
    HistoricLocation *location = [self.locationsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = location.locationTitle;
    cell.textLabel.numberOfLines = 0;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoricLocation *location = [self.locationsArray objectAtIndex:indexPath.row];
    NSLog(@"%@", location.locationTitle);
    [self performSegueWithIdentifier:@"LocationDetailSegue" sender:location];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Yes");
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoricLocation *location = [self.locationsArray objectAtIndex:indexPath.row];
    
    NSLog(@"Location: %@", location.locationTitle);
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
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
    } else if ([[segue identifier] isEqualToString:@"LocationDetailSegue"])
    {
        // Get reference to the destination view controller
        LocationDetailViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.historicLocation = (HistoricLocation *)sender;
        vc.delegate = self;
    }
}

#pragma mark - Custom Delegate Methods
-(void)locationListTableViewController:(LocationListTableViewController *)controller didSelectHistoricLocation:(HistoricLocation *)location {
    
    if(![self.locationsArray containsLocation:location])
        [self saveLocation:location];
}

-(void)locationDetailViewController:(LocationDetailViewController *)controller didSelectHistoricLocation:(HistoricLocation *)location {
    
    if(![self.locationsArray containsLocation:location])
        [self saveLocation:location];
}

-(void)saveLocation:(HistoricLocation *)location {
    
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
        
        [self.locationsArray addObject:location];
        
    } completion:^(BOOL success, NSError *error) {
        if (!error) {
            
        } else {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }];
}

@end
