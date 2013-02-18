//
//  DrinkPickerScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//FUNCTIONAL SCREEN -- 2.18

#import "DrinkPickerScreen.h"

@interface DrinkPickerScreen ()

@end

@implementation DrinkPickerScreen


@synthesize drinkKeys, drinks, delegate;

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
    
    
    
    NSString *drinkList = [[NSBundle mainBundle]
                           pathForResource:@"DrinkList" ofType:@"plist"];
    
    drinks = [[NSDictionary alloc] initWithContentsOfFile:drinkList];
    
    drinkKeys = [drinks allKeys];
    
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
    return [drinks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //creates cells for drinks
    static NSString *CellIdentifier = @"drinkType";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *drinkName = [drinkKeys objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:drinkName];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //gets drinkname and corresponding alcOz
    NSString *selectedDrink = [drinkKeys objectAtIndex:indexPath.row];
    NSNumber *selectedDrinkAlcOz = [drinks valueForKey:selectedDrink];

    //call delegate function to pass back info
    [self.delegate addItemViewController:self drinkName:selectedDrink alcOz:selectedDrinkAlcOz];
    
    //dismisses self on selection
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
