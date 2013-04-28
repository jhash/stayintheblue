//
//  DrinkingScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//PARTIALLY FUNCTIONAL - lacking full save functionality

#import "DrinkingScreen.h"
#import "SettingsScreen.h"
#import "FPPopoverController.h"
#import "FPPopoverView.h"
#import "FPTouchView.h"
#import "DrinkLogScreen.h"
#import <CoreData/CoreData.h>
#import <CoreMotion/CoreMotion.h>
#import "NightStatsScreen.h"
#import "TestFlight.h"



#define IS_FIRST_LOAD_CONST 0

@interface DrinkingScreen ()



@end

@implementation DrinkingScreen
@synthesize currentDrinkName;
@synthesize user;
@synthesize BACLabel, numDrinksLabel, buttonText, t, timerLabel;
@synthesize isFirstLoad, isFirstLoadPointer;
@synthesize managedObjectContext;



#pragma mark prepare for segue method
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //set delegate of drink picker to drinking screen view controller
    if([segue.identifier isEqualToString: @"toDrinkPicker"])
    {
        DrinkPickerScreen *dpc = [segue destinationViewController];
        dpc.delegate = self;
        
        dpc.currentDrink = user.currentDrink;
        dpc.colorLevel = [self calcGeneralColor:user.BAC];
        
    }
    
    //same with settings screen
    if([segue.identifier isEqualToString:@"toSettings"])
    {
        SettingsScreen *ss = [segue destinationViewController];
        ss.delegate = self;
        ss.user = user;
    }
    
    
    if([segue.identifier isEqualToString:@"toNightStats"])
    {
        NightStatsScreen *nss = [segue destinationViewController];
        nss.numDrinks = user.numDrinks;
        nss.maxBAC = user.maxBACHolder;
        
        
        
    }
}


- (void) updateColor
{
    double bac = user.BAC;
    
    if (bac < .01)
    {
        self.UserImage.image = [UIImage imageNamed:@"Blue_1.png"];
    }
    else if(bac >.01 && bac < .02)
    {
        self.UserImage.image = [UIImage imageNamed:@"Blue_2.png"];
    }
    else if(bac > .02 && bac < .03)
    {
        self.UserImage.image = [UIImage imageNamed:@"Blue_3.png"];
    }
    else if(bac > .03 && bac < .04)
    {
        self.UserImage.image = [UIImage imageNamed:@"Blue_4.png"];
    }
    else if(bac > .04 && bac < .05)
    {
        self.UserImage.image  = [UIImage imageNamed:@"Blue_5.png"];
    }
    else if(bac > .05 && bac < .06)
    {
        self.UserImage.image = [UIImage imageNamed:@"Blue_6.png"];
    }
    else if(bac > .06 && bac < .07)
    {
        self.UserImage.image = [UIImage imageNamed:@"Blue_7.png"];
    }
    else if(bac > .07 && bac < .087 )
    {
        self.UserImage.image = [UIImage imageNamed:@"Maize_1.png"];
    }
    else if(bac > .087 && bac < .104)
    {
        self.UserImage.image = [UIImage imageNamed:@"Maize_2.png"];
    }
    else if(bac > .104 && bac < 0.121)
    {
        self.UserImage.image = [UIImage imageNamed:@"Maize_3.png"];
    }
    else if(bac > 0.121 && bac < 0.138 )
    {
        self.UserImage.image = [UIImage imageNamed:@"Maize_4.png"];
    }
    else if(bac > 0.138 && bac < 0.155)
    {
        self.UserImage.image = [UIImage imageNamed:@"Maize_5.png"];
    }
    else if(bac > 0.155 && bac < 0.172)
    {
        self.UserImage.image = [UIImage imageNamed:@"Maize_6.png"];
    }
    else if(bac > 0.172 && bac < 0.19)
    {
        self.UserImage.image = [UIImage imageNamed:@"Maize_7.png"];
    }
    else if(bac > .19 && bac < .2)
    {
        self.UserImage.image = [UIImage imageNamed:@"Red_1.png"];
    }
    else if(bac > .2 && bac < .21)
    {
        self.UserImage.image = [UIImage imageNamed:@"Red_2.png"];
    }
    else if(bac > .21 && bac <.22)
    {
        self.UserImage.image = [UIImage imageNamed:@"Red_3.png"];
    }
    else if(bac > .22 && bac < .23)
    {
        self.UserImage.image = [UIImage imageNamed:@"Red_4.png"];
    }
    else if(bac > .23 && bac <.24)
    {
        self.UserImage.image = [UIImage imageNamed:@"Red_5.png"];
    }
    else if(bac> .24 && bac < .25)
    {
        self.UserImage.image = [UIImage imageNamed:@"Red_6.png"];
    }
    else
    {
        self.UserImage.image = [UIImage imageNamed:@"Red_7.png"];
    }
}

- (int) calcNumDrinks:(double)alcOz
{
    int numDrinks = alcOz/.5;
    double remain = (alcOz/.5) - numDrinks;
    
    if(remain > .5)
    {
        numDrinks+=1;
    }
    
    return numDrinks;
}

- (NSString *) calcTimeForTimer
{
    int hours = user.elapsedTime/3600;
    int minutes = (user.elapsedTime/60) - (hours*60);
    int seconds = user.elapsedTime - (minutes*60);
    if(hours > 0)
    {
        seconds = user.elapsedTime - (hours*3600) - (minutes * 60);
    }
    
    NSString *minutesString = [self intToTimeFormatter:minutes];
    NSString *secondsString = [self intToTimeFormatter:seconds];
    
    return [NSString stringWithFormat:@"%i:%@:%@",hours,minutesString,secondsString];
}

- (NSString *) intToTimeFormatter:(int)timeInteger
{
    if(timeInteger < 10)
    {
        return [NSString stringWithFormat:@"0%i", timeInteger];
    }
    else
    {
        return [NSString stringWithFormat:@"%i", timeInteger];
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


#pragma  mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    isFirstLoadPointer = [def integerForKey:@"firstLoad"];
    
    UIColor *blueCol = [UIColor colorWithRed:.0941 green:.1960 blue:.3411 alpha:1.0];
    self.InfoBar.backgroundColor = blueCol;
    
    if(isFirstLoadPointer != 100)
    {
        isFirstLoad = YES;
        user = [User sharedUser];
        isFirstLoadPointer = 100;
        [def setInteger:isFirstLoadPointer forKey:@"firstLoad"];
    }
    else
    {
        isFirstLoad = NO;
        user = [User sharedUser];
        [user loadUser];
        [user toString];
    }
    

    DrinkLogScreen *logScreen = [[DrinkLogScreen alloc] init];
    [self.revealSideViewController preloadViewController:logScreen forSide:PPRevealSideDirectionBottom];
    
    
    
    
    

    //check if the user already started a session
    if(user.rageInProgress == YES)
    {
        //change appropriate labels
        [user calcBAC];
        t = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
        self.BACLabel.text = [NSString stringWithFormat:@"%.2f", user.BAC];
        self.numDrinksLabel.text = [NSString stringWithFormat:@"(%i)", user.numDrinks];
        self.timerLabel.text = [self calcTimeForTimer];
        self.timerLabel.hidden = NO;
        [buttonText setTitle:@"+1" forState:UIControlStateNormal];
    
    }
    
    
    else
    {
        //clear labels
        self.BACLabel.text = @"0.0";
        self.numDrinksLabel.text = @"(0)";
        self.timerLabel.hidden = YES;
        //change button text to start
        [buttonText setTitle:@"START" forState:UIControlStateNormal];
        self.doneButton.hidden = YES;
        self.drinkLogButton.hidden = YES;
        self.topNavBar.rightBarButtonItem.enabled = NO;
    }
    
    MTStatusBarOverlay *sbar = [MTStatusBarOverlay sharedInstance];
    DrinkLogScreen *dls = [[DrinkLogScreen alloc]init];
    [sbar setDetailView:dls.view];
    sbar.animation = MTStatusBarOverlayAnimationFallDown;
    [sbar show];
    

    
    //set delegate of My Drinking Screen to self
    MyDrinkingScreen *mds = [self.tabBarController.viewControllers objectAtIndex:1];
    mds.delegate = self;
}



- (void) viewDidAppear:(BOOL)animated
{
    //loads Settings Screen if this is the first load, puts current drink name
    //at top of screen if raging is in progress
    
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    [self updateLabels];
    
    
    if(isFirstLoad)
    {
        [self performSegueWithIdentifier:@"toSettings" sender:self];
        isFirstLoad = NO;
    }
    else
    {
        [user saveUser];
    }
    if(user.rageInProgress)
    {
        
        self.currentDrinkName.topItem.title = user.currentDrink;
        [self updateColor];
        self.BACLabel.text = [NSString stringWithFormat:@"%.2f", user.BAC];
        self.numDrinksLabel.text = [NSString stringWithFormat:@"(%i)", user.numDrinks];
        self.timerLabel.text = [self calcTimeForTimer];
        self.timerLabel.hidden = NO;
        self.drinkLogButton.hidden = NO;
        
    }

    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//method of drink picker delegate - gets info of selected drink
- (void)addItemViewController:(DrinkPickerScreen *)controller drinkName:(NSString *)drinkName alcOz: (NSNumber*) alcOz 
{
    //sets current drink name
    user.currentDrink = drinkName;
    self.currentDrinkName.topItem.title = user.currentDrink;
    // puts the amount of alcohol in a container
    user.currentAlcOz = [alcOz doubleValue];
}




- (IBAction)logButtonPressed:(id)sender
{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionBottom animated:YES];
}

- (IBAction)drinkPressed:(id)sender
{
    user = [User sharedUser];
    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
    overlay.animation = MTStatusBarOverlayAnimationNone;
    if(user.BAC > .11 && user.BAC < .13)
    {
        [overlay postErrorMessage:@"You may now be experiencing poor balance" duration:2.0 animated:YES];
    }
    
    //check if user has started
    if(user.rageInProgress)
    {
        
        user.lastAlcOz = user.currentAlcOz;
        user.alcOz += user.currentAlcOz;
        user.numDrinks += [self calcNumDrinks:user.currentAlcOz];
        [user calcBAC];
        [self updateColor];
        [self updateLabels];
        self.justUndid = NO;
        
        
        //logging drinks
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm:ss"];
        
        NSString *date = [dateFormatter stringFromDate:now];
        user.lastDateDrank = date;
        //NSLog(@"User had a %@ at %@", user.currentDrink, date);
        
        [user.drinksHad setObject:user.currentDrink forKey:date];
        
        NSArray *drinkKeys = [user.drinksHad allKeysForObject:user.currentDrink];
        NSLog(@"time: %@ drink: %@", drinkKeys[0], [user.drinksHad objectForKey:date]);

    }
    
    
    else //if the user is beginning a session, the drinkpicker will show automatically
    {
        t = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
        self.justUndid = NO;
        user.rageInProgress = YES;
        self.doneButton.hidden = NO;
        self.drinkLogButton.hidden = NO;
        self.topNavBar.rightBarButtonItem.enabled = YES;
        
        [self performSegueWithIdentifier:@"toDrinkPicker" sender:self];
        
        
        [self updateColor];
        
        user.startTime = [NSDate timeIntervalSinceReferenceDate];
        [buttonText setTitle:@"+1" forState:UIControlStateNormal]; //change button text
        //create a repeating timer with 10 second interval. Use onTick method below as selector
        t = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
        [user calcBAC];
        [self updateLabels];
    }
}



- (IBAction)donePressed:(id)sender
{
    UIActionSheet *saveInfoSheet = [[UIActionSheet alloc] initWithTitle:@"Do you want to save this session?"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                 destructiveButtonTitle:@"Yes"
                                                      otherButtonTitles:@"No", nil];
    
    //[saveInfoSheet showFromTabBar:self.tabBarController.tabBar];
    [saveInfoSheet showFromTabBar:self.tabBarController.tabBar];
    [TestFlight passCheckpoint:@"EndedSession"];
}






-(void) updateLabels
{
    self.BACLabel.text = [NSString stringWithFormat:@"%.2f", user.BAC];
    self.numDrinksLabel.text = [NSString stringWithFormat:@"(%i)", user.numDrinks];
}

-(void) userClear //clears reusable data
    
{
    //clear userdata
    user.rageInProgress = NO;
    user.BAC = 0.0;
    user.alcOz = 0.0;
    user.numDrinks = 0;
    user.currentAlcOz = 0;
    user.maxBACHolder = 0.0;
    user.elapsedTime = 0;
    self.UserImage.image = [UIImage imageNamed:@"Blue_1.png"];
    user.currentDrink = @"";
    [user.drinksHad removeAllObjects];
    [user saveUser]; //save

    
    
    //clear labels
    self.BACLabel.text = @"0.0";
    self.numDrinksLabel.text = @"(0)";
    self.timerLabel.text = @"0:00:00";
    self.timerLabel.hidden = YES;
    self.drinkLogButton.hidden = YES;
    
    
    //change button text to start
    [buttonText setTitle:@"START" forState:UIControlStateNormal];
    self.currentDrinkName.topItem.title = @"";
    self.doneButton.hidden = YES;
    self.topNavBar.rightBarButtonItem.enabled = NO;
    self.UserImage.image = [UIImage imageNamed:@"Blue_1.png"];
    [t invalidate];
}



- (NSString *) calcGeneralColor: (double) BAC
{
    //calculates general color for night stats screen
    if(BAC < .07)
    {
        return @"blue";
    }
    if(BAC > .07 && BAC < .19)
    {
        return @"maize";
    }
    else
    {
        return @"red";
    }
}



#pragma mark MyDrinkingScreen delegate method
- (void) passForwardColorDictionary: (MyDrinkingScreen *) mds
{
    //delegate method for nightly stats, passes dict values over.
    mds.blue = [[user.overallStats objectForKey:@"blue"] integerValue];
    mds.maize = [[user.overallStats objectForKey:@"maize"] integerValue];
    mds.red = [[user.overallStats objectForKey:@"red"] integerValue];
}


#pragma mark uiactionsheet delegate method
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == actionSheet.destructiveButtonIndex )
    {
        [self performSegueWithIdentifier:@"toNightStats" sender:self];
        
        NSString * color = [self calcGeneralColor:user.BAC];
        int num = [[user.overallStats objectForKey:color] integerValue] +1;
        [user.overallStats setObject:[NSNumber numberWithInt:num] forKey:color];
        
        for (id key in user.drinksHad) {
            NSLog(@"time: %@, drink: %@ \n", key, [user.drinksHad objectForKey:key]);
        }
        
        
        [self userClear];
    }
    else if(buttonIndex != actionSheet.cancelButtonIndex)
    {
        [self performSegueWithIdentifier:@"toNightStats" sender:self];
        
        [self userClear];
    }
    else
    {
        return;
    }
}



#pragma mark setting screen delegate method
- (void) passBackUserSettings:(SettingsScreen *)controller weight:(int)weight userSex:(gender)sex
{
    user.weight = weight;
    user.sex = sex;
}



#pragma mark timer fire method
- (void) onTick: (NSTimer *) t
{
    //calc BAC again
    [user calcBAC];
    [self updateColor];
    
    //make sure BAC doesn't go below 0
    if (user.BAC <= 0)
    {
        user.BAC = 0;
        user.elapsedTime = 0;
        user.alcOz = 0.0;
    }
    //change label
    [self updateLabels];
    self.timerLabel.text = [self calcTimeForTimer];
    //NSLog(@"tick");
}




-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(user.rageInProgress && user.numDrinks > 0)
    {
        UIAlertView *undoAlert = [[UIAlertView alloc] initWithTitle:@"Undo Last Drink?"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"Undo"
                                                  otherButtonTitles:@"Cancel", nil];
        undoAlert.tag = 1;
        
        if(!self.justUndid)
        {
           [undoAlert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag ==1)
    {
        if(buttonIndex == 1)
        {
            [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:YES];
        }
        else if(buttonIndex == 0)
        {
            user = [User sharedUser];
            user.numDrinks -= [self calcNumDrinks:user.lastAlcOz];
            user.alcOz -= user.lastAlcOz;
            [user calcBAC];
            [self updateLabels];
            [self updateColor];
            [user.drinksHad removeObjectForKey:user.lastDateDrank];
            self.justUndid = YES;
            
        }
    }
}

-(BOOL) canBecomeFirstResponder
{
    return YES;
}




@end
