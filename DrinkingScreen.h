//
//  DrinkingScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//


#import "DrinkPickerScreen.h"
#import "SettingsScreen.h"
#import <UIKit/UIKit.h>
#import "User.h"


@interface DrinkingScreen : UIViewController <DrinkPickerScreenDelegate, SettingsScreenDelegate>



@property (weak, nonatomic) IBOutlet UINavigationBar *currentDrinkName;
@property double currentAlcOz;
@property User *user;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel; //testing drinkpicker passback
@property (weak, nonatomic) IBOutlet UILabel *numDrinksLabel;
@property (weak, nonatomic) IBOutlet UILabel *BACLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonText;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *drinkPickerButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *topNavBar;


- (IBAction)drinkPressed:(id)sender;
- (IBAction)donePressed:(id)sender;


@end
