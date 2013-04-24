//
//  DrinkLogScreen.m
//  SIB
//
//  Created by Steven Coffey on 3/31/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import "DrinkLogScreen.h"

@interface DrinkLogScreen ()

@end

@implementation DrinkLogScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.user = [User sharedUser];
    self.drinkLogKeys = [self.user.drinksHad allKeys];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.drinkLogKeys = [self.user.drinksHad allKeys];
    self.sortedDrinkLogKeys = [self.drinkLogKeys sortedArrayUsingSelector:
                               @selector(localizedCaseInsensitiveCompare:)];
    
}

                         

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.drinkLogKeys.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *drinkLogTableID = @"drinkLogTableID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:drinkLogTableID];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                      reuseIdentifier:drinkLogTableID];
    }
    
    cell.detailTextLabel.text = [self.user.drinksHad objectForKey:self.sortedDrinkLogKeys[indexPath.row]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Black" size:20];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    NSString *timeWithSeconds = self.sortedDrinkLogKeys[indexPath.row];
    NSString *timeWithoutSeconds = [timeWithSeconds substringToIndex:5];
    cell.textLabel.text = timeWithoutSeconds;
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    return cell;
}


- (IBAction)backPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
