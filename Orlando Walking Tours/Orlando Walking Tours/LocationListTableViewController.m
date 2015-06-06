//
//  LocationListTableViewController.m
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 1/31/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import "LocationListTableViewController.h"
#import "LocationDetailViewController.h"
#import "HistoricLocation.h"
#import "LocationTableViewCell.h"

@interface LocationListTableViewController ()

@end

@implementation LocationListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0; // set to whatever your "average" cell height is
    
    self.locationsArray = [NSMutableArray new];
    NSString *locationsUrlString = @"https://brigades.opendatanetwork.com/resource/hzkr-id6u.json";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:locationsUrlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSError *jsonError;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        for (NSDictionary *loc in json) {
            HistoricLocation *location = [HistoricLocation MR_createEntity];
            location.address = [loc objectForKey:@"address"];
            location.locationDescription = [loc objectForKey:@"downtown_walking_tour"];
            location.locationTitle  = [loc objectForKey:@"name"];
            location.locationType = [loc objectForKey:@"type"];
            
            double lat = [[[loc objectForKey:@"location"] objectForKey:@"latitude"] doubleValue];
            double lng = [[[loc objectForKey:@"location"] objectForKey:@"longitude"] doubleValue];
            
//            CLLocation *locationObj = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
//            location.location = locationObj;

            location.latitude = [NSNumber numberWithDouble:lat];
            location.longitude = [NSNumber numberWithDouble:lng];
            
            [self.locationsArray addObject:location];
        }

        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        
        
    }] resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.locationsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationTableViewCell *cell = (LocationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    
    HistoricLocation *historicLocation = [self.locationsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = historicLocation.locationTitle;
    cell.saveButton.tag = indexPath.row;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoricLocation *historicLocation = [self.locationsArray objectAtIndex:indexPath.row];
    self.selectedHistoricLocation = historicLocation;
    [self performSegueWithIdentifier:@"LocationDetailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"LocationDetailSegue"])
    {
        // Get reference to the destination view controller
        LocationDetailViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.historicLocation = self.selectedHistoricLocation;
        vc.delegate = self;
    }
}

#pragma mark - Custom Delegate Methods
-(void)locationDetailViewController:(LocationDetailViewController *)controller didSelectHistoricLocation:(HistoricLocation *)location {
    if ([self.delegate respondsToSelector:@selector(locationListTableViewController:didSelectHistoricLocation:)]) {
        
        [self.delegate locationListTableViewController:self didSelectHistoricLocation:location];
    }
}


#pragma mark - Button Actions

-(void)tappedSave:(UIButton *)sender {
    HistoricLocation *location = [self.locationsArray objectAtIndex:sender.tag];

    if ([self.delegate respondsToSelector:@selector(locationListTableViewController:didSelectHistoricLocation:)]) {
        
        [self.delegate locationListTableViewController:self didSelectHistoricLocation:location];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
