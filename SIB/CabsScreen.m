//
//  CabsScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//FUNCTIONAL SCREEN - 2.18

#import "CabsScreen.h"

@interface CabsScreen ()

@end

@implementation CabsScreen {
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@synthesize cabKeys, cabs, crossStreets, header;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialize Location Manager
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    //Set TableViewHeader to have user's current address
    header = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    crossStreets = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    [crossStreets setTextColor:[UIColor blackColor]];
    [crossStreets setBackgroundColor:[UIColor clearColor]];
    crossStreets.textAlignment = NSTextAlignmentCenter;
    crossStreets.text = @"Unable to find current location";
    [header addSubview:crossStreets];
    self.tableView.tableHeaderView = header;
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    //read in cabs plist
    NSString *cabList = [[NSBundle mainBundle]
                         pathForResource:@"cabList" ofType:@"plist"];
    
    //put everything in a dictionary
    cabs = [[NSDictionary alloc] initWithContentsOfFile:cabList];
    
    //get keys for row indices
    cabKeys = [cabs allKeys];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        //longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        //latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    //Save Battery - stop updating location
    [locationManager stopUpdatingLocation];
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            crossStreets.text = [NSString stringWithFormat:@"Current Location: %@, %@", placemark.subThoroughfare, placemark.thoroughfare];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [cabs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //
    static NSString *CellIdentifier = @"cabCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *companyName = [cabKeys objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:companyName];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //deselect row
    NSString *currentCompany = [cabKeys objectAtIndex:indexPath.row]; //put company name in string
    //put phone number in string
    NSString *num = [[NSString alloc] initWithFormat:@"%@",[cabs valueForKey:currentCompany]];
    
    
    //create telprompt with desired number
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:num];
    
    //make phone call
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
