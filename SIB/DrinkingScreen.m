//
//  DrinkingScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//PARTIALLY FUNCTIONAL - lacking user interactivity functionality

#import "DrinkingScreen.h"
#import "SettingsScreen.h"
#import "NightStatsScreen.h"
#define IS_FIRST_LOAD_CONST 0

@interface DrinkingScreen ()
@property NSTimer *t;
@property BOOL shouldCancelStatsSegue;


@end

@implementation DrinkingScreen
@synthesize currentDrinkName;
@synthesize currentAlcOz;
@synthesize user;
@synthesize BACLabel, numDrinksLabel, buttonText,t;
@synthesize shouldCancelStatsSegue;


- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    [self donePressed: self.doneButton];
    if ([identifier isEqual:@"toNightStats"])
    {
        if(!shouldCancelStatsSegue)
        {
            return YES;
        }
        return NO;
    }
    else
    {
        return YES;
    }
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //set delegate of drink picker to drinking screen view controller
    if([segue.identifier isEqualToString: @"toDrinkPicker"])
    {
        DrinkPickerScreen *dpc = [segue destinationViewController];
        dpc.delegate = self;
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
    
    
    //create main user object ONCE
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
    });

    
    //check if the user already started a session
    if(user.rageInProgress == YES)
    {
        //change appropriate labels
        NSString *BACtext = [[NSString alloc] initWithFormat:@"%f", user.BAC];
        NSString *numDrinksText = [[NSString alloc] initWithFormat:@"%i", user.numDrinks];
        BACLabel.text = BACtext;
        numDrinksLabel.text = numDrinksText;
    }
    
    
    else
    {
        //clear labels
        BACLabel.text = @"0.0";
        numDrinksLabel.text = @"(0)";
        //change button text to start
        [buttonText setTitle:@"START" forState:UIControlStateNormal];
        self.doneButton.hidden = YES;
        self.topNavBar.rightBarButtonItem.enabled = NO;
        
        
    }
    

	
    //self.currentDrinkName.topItem.title = @"Light Beer";
}








- (void) viewDidAppear:(BOOL)animated
{
    

    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self performSegueWithIdentifier:@"toSettings" sender:self];
    });
    
    

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
    self.currentDrinkName.topItem.title = drinkName;
    // puts the amount of alcohol in a container
    self.currentAlcOz = [alcOz doubleValue];
}

//method of settings screen delegate - gets user info from settings screen
- (void) passBackUserSettings:(SettingsScreen *)controller weight:(int)weight userSex:(gender)sex
{
    user.weight = weight;
    user.sex = sex;
    
    //testing 
    NSString *passChecker = [[NSString alloc] initWithFormat:@"%i, %u", user.weight, user.sex];
    self.tempLabel.text = passChecker;
}


- (IBAction)drinkPressed:(id)sender
{

    //catch for no weight entered - this should be fixed when settings screen shows on first load
    if (user.weight == 0)
    {
        user.weight = 100;
    }
    
    //check if user has started
    if(user.rageInProgress)
    {
        

        //uncomment these when drinkPicker showing works, see else block
        
        user.alcOz += currentAlcOz;
        user.numDrinks += 1;
        //user.elapsedTime = 2000;
        [user calcBAC];
        numDrinksLabel.text = [NSString stringWithFormat:@"(%i)", user.numDrinks]; //update labels
        BACLabel.text = [NSString stringWithFormat:@"%.2f", user.BAC];
    }
    
    else //if the user is beginning a session, the drinkpicker will show automagically
    {
        
        
        user.rageInProgress = YES;
        self.doneButton.hidden = NO;
        self.topNavBar.rightBarButtonItem.enabled = YES;
        
        [self performSegueWithIdentifier:@"toDrinkPicker" sender:self];
        
        
        
        
        user.startTime = [NSDate timeIntervalSinceReferenceDate];
        [buttonText setTitle:@"DRINK" forState:UIControlStateNormal]; //change button text
        t = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
        
        
        //create a repeating timer with 10 second interval. Use onTick method below for selector
        
    }
    
    
}




- (IBAction)donePressed:(id)sender
{
    UIActionSheet *saveInfoSheet = [[UIActionSheet alloc] initWithTitle:@"Do you want to save this session?"
                                                               delegate:self
                                                      cancelButtonTitle:@"NO"
                                                 destructiveButtonTitle:@"YES"
                                                      otherButtonTitles:@"Cancel", nil];
    
    //[saveInfoSheet showFromTabBar:self.tabBarController.tabBar];
    [saveInfoSheet showFromTabBar:self.tabBarController.tabBar];
    
    
    //[self performSegueWithIdentifier:@"toNightStats" sender:self];
    
}

-(void) userClear //clears reusable data
    
{
    user.rageInProgress = NO;
    user.BAC = 0.0;
    user.alcOz = 0.0;
    user.numDrinks = 0;
    self.currentAlcOz = 0;
    user.maxBACHolder = 0.0;
    user.elapsedTime = 0;
    //clear labels
    BACLabel.text = @"0.0";
    numDrinksLabel.text = @"(0)";
    //change button text to start
    [buttonText setTitle:@"START" forState:UIControlStateNormal];
    self.currentDrinkName.topItem.title = @"";
    self.doneButton.hidden = YES;
    self.topNavBar.rightBarButtonItem.enabled = NO;
    [t invalidate];
}

- (NSString *) calcGeneralColor: (double) BAC
{
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

#pragma mark uiactionsheet delegate method
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != actionSheet.cancelButtonIndex)
    {
        NSString * color = [self calcGeneralColor:user.BAC];
        int num = [[user.overallStats objectForKey:color] integerValue] +1;
        [user.overallStats setObject:[NSNumber numberWithInt:num] forKey:color];
        
        for (id key in user.overallStats) {
            NSLog(@"key: %@, value: %@ \n", key, [user.overallStats objectForKey:key]);
        }
        
        [self userClear];
    }
    else if (buttonIndex == actionSheet.firstOtherButtonIndex)
    {
        shouldCancelStatsSegue = YES;
    }
    else
    {
        [self userClear];
    }
}



#pragma mark timer fire method
- (void) onTick: (NSTimer *) t
{
    //calc BAC again
    [user calcBAC];
    
    //make sure BAC doesn't go below 0
    if (user.BAC < 0)
    {
        user.BAC = 0;
    }
    //change label
    BACLabel.text = [NSString stringWithFormat:@"%.2f", [user BAC]];
    NSLog(@"Time: %i \n BAC: %f", user.elapsedTime, user.BAC);
}
@end
