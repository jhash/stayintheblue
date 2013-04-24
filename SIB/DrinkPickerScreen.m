//
//  DrinkPickerScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//FUNCTIONAL SCREEN -- 2.18

#import "DrinkPickerScreen.h"
#import <CoreMotion/CoreMotion.h>



@interface DrinkPickerScreen ()

@end

@implementation DrinkPickerScreen


@synthesize drinkKeys, drinks, delegate;
@synthesize navBar, doneButton;
@synthesize currentDrink;
@synthesize blue,maize,red;
@synthesize darkerBlue,darkerMaize,darkerRed;

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
    
    blue = [UIColor colorWithRed:.0941 green:.1960 blue:.3411 alpha:1.0];
    darkerBlue = [UIColor colorWithRed:.0941 green:.1960 blue:.3411 alpha:.5];
    
    
    maize = [UIColor colorWithRed:.9098 green:.8901 blue:.0745 alpha:1.0];
    darkerMaize = [UIColor colorWithRed:.9098 green:.8901 blue:.0745 alpha:.5];
    
    
    red = [UIColor colorWithRed:.3176 green:.0588 blue:.0666 alpha:1.0];
    darkerRed = [UIColor colorWithRed:.3176 green:.0588 blue:.0666 alpha:.5];
}

-(void) viewWillAppear:(BOOL)animated
{
    
    
    if(![currentDrink isEqualToString:@""])
    {
        navBar.topItem.title = currentDrink;
        
    }
    else
    {
        doneButton.enabled = NO;
        navBar.topItem.title = @"Pick your drink";
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self becomeFirstResponder];
}

- (IBAction)donePressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    if([currentDrink isEqualToString:drinkName])
    {
        
        CGRect cellRect = cell.frame;
    
        
        CALayer *cellLayer = [CALayer layer];
        cellLayer.shadowOffset = CGSizeMake(0, 3);
        cellLayer.cornerRadius = 13;
        
        
        cellLayer.frame = CGRectMake(250, cellRect.origin.y +8.5  , 25, 25);
        CABasicAnimation *pulser = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        [pulser setTimingFunction:[CAMediaTimingFunction functionWithName:
                                   kCAMediaTimingFunctionEaseInEaseOut]];
        [pulser setAutoreverses:YES];
        [pulser setDuration:2];
        pulser.repeatCount = INFINITY;
        [[self.view layer] addSublayer:cellLayer];
        
        
        
        
        if([self.colorLevel isEqualToString:@"blue"])
        {
            [pulser setFromValue:(id)blue.CGColor];
            [pulser setToValue:(id)darkerBlue.CGColor];
            
            //cell.backgroundColor = blue;
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }
        else if([self.colorLevel isEqualToString:@"maize"])
        {
            [pulser setFromValue:(id)maize.CGColor];
            [pulser setToValue:(id)darkerMaize.CGColor];
            
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }
        else if([self.colorLevel isEqualToString:@"red"])
        {
            
            [pulser setFromValue:(id)red.CGColor];
            [pulser setToValue:(id)darkerRed.CGColor];
            
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }
        
        [cellLayer addAnimation:pulser forKey:@"backgroundColor"];

    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    
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

-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake && ![currentDrink isEqualToString:@""])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
