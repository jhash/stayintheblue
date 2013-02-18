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

@implementation CabsScreen
@synthesize cabKeys, cabs;

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
    
    
    //read in cabs plist
    NSString *cabList = [[NSBundle mainBundle]
                         pathForResource:@"cabList" ofType:@"plist"];
    
    //put everything in a dictionary
    cabs = [[NSDictionary alloc] initWithContentsOfFile:cabList];
    
    //get keys for row indices
    cabKeys = [cabs allKeys];
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
