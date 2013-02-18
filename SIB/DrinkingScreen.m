//
//  DrinkingScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import "DrinkingScreen.h"

@interface DrinkingScreen ()

@end

@implementation DrinkingScreen
@synthesize currentDrinkName;
@synthesize currentAlcOz;
@synthesize user;

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual: @"toDrinkPicker"])
    {
        DrinkPickerScreen *dpc = [segue destinationViewController];
        dpc.delegate = self;
    }
}

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
    user.rageInProgress = NO;
    
    if (user.rageInProgress == NO)
    {
        //DrinkPickerScreen *dpc = [[DrinkPickerScreen alloc] init];
        //dpc.delegate = self;
        [[self navigationController] performSegueWithIdentifier:@"toDrinkPicker" sender:self];
    }
    
	
    //self.currentDrinkName.topItem.title = @"Light Beer";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addItemViewController:(DrinkPickerScreen *)controller drinkName:(NSString *)drinkName alcOz: (NSNumber*) alcOz 
{
    self.currentDrinkName.topItem.title = drinkName;
    self.currentAlcOz = [alcOz doubleValue];
    //self.tempAlc.text = [NSString stringWithFormat:@"%@", alcOz];
}
@end
