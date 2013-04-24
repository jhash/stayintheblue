//
//  DrinkingScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//


#import "DrinkPickerScreen.h"
#import "AppDelegate.h"
#import "SettingsScreen.h"
#import "MyDrinkingScreen.h"
#import "MTStatusBarOverlay.h"
#import <UIKit/UIKit.h>
#import "User.h"




@interface DrinkingScreen : UIViewController <DrinkPickerScreenDelegate, SettingsScreenDelegate, MyDrinkingScreenDelegate>



@property (weak, nonatomic) IBOutlet UINavigationBar *currentDrinkName;
@property User *user;
@property (weak, nonatomic) IBOutlet UILabel *numDrinksLabel;
@property (weak, nonatomic) IBOutlet UILabel *BACLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonText;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *drinkLogButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *drinkPickerButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *topNavBar;
@property (weak, nonatomic) IBOutlet UIImageView *UserImage;
@property  BOOL justUndid;




@property int isFirstLoadPointer;
@property BOOL isFirstLoad;
@property NSTimer *t;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;



- (IBAction)drinkPressed:(id)sender;
- (IBAction)donePressed:(id)sender;

- (int)calcNumDrinks:(double)alcOz;
- (NSString *)calcTimeForTimer;




@end
