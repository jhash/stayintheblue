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
#import <CoreData/CoreData.h>
#import <CoreMotion/CoreMotion.h>
#import "NightStatsScreen.h"
#define IS_FIRST_LOAD_CONST 0

@interface DrinkingScreen ()



@end

@implementation DrinkingScreen
@synthesize currentDrinkName;
@synthesize currentAlcOz;
@synthesize user;
@synthesize BACLabel, numDrinksLabel, buttonText, t;
@synthesize isFirstLoad, isFirstLoadPointer;
@synthesize currentDrink;
@synthesize managedObjectContext;


#pragma mark loading and saving
-(void) saveData
{
    NSString *filepath = [self getFilePath];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    
    [archiver encodeObject:user forKey:@"user"];
    [archiver encodeObject:currentDrink forKey:@"currentDrink"];
    [archiver encodeDouble:currentAlcOz forKey:@"currentAlcOz"];
    
    
    [archiver finishEncoding];
    
    BOOL success = [data writeToFile:filepath atomically:YES];
    
    NSLog(@"%@", success ? @"YES" : @"NO");
    
}


-(void) loadData
{
    if(isFirstLoad)
    {
        user = [[User alloc] init];
        currentDrink = @"";
        currentAlcOz = 0;
        
        [self saveData];
    }
    else
    {
        NSString *filepath = [self getFilePath];
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:filepath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        

        user = [unarchiver decodeObjectForKey:@"user"];
        NSLog(@"%@", user);
        
        currentDrink = [unarchiver decodeObjectForKey:@"currentDrink"];
        currentAlcOz = [unarchiver decodeDoubleForKey:@"currentAlcOz"];
        [unarchiver finishDecoding];
    }
}


- (NSString *) getFilePath
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathArray objectAtIndex:0] stringByAppendingPathComponent:@"saved.plist"];
} 



#pragma mark prepare for segue method
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //set delegate of drink picker to drinking screen view controller
    if([segue.identifier isEqualToString: @"toDrinkPicker"])
    {
        DrinkPickerScreen *dpc = [segue destinationViewController];
        dpc.delegate = self;
        
        dpc.currentDrink = self.currentDrink;
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
        
        
        
        UIActionSheet *saveInfoSheet = [[UIActionSheet alloc] initWithTitle:@"Do you want to save this session?"
                                                                   delegate:self
                                                          cancelButtonTitle:@"NO"
                                                     destructiveButtonTitle:@"YES"
                                                          otherButtonTitles:nil, nil];
        
        
        [saveInfoSheet showFromTabBar:self.tabBarController.tabBar];
        
        
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
    NSLog(@"%i", isFirstLoadPointer);
    
    
    if(isFirstLoadPointer != 100)
    {
        isFirstLoad = YES;
    }
    else
    {
        isFirstLoad = NO;
        isFirstLoadPointer = 100;
        [def setInteger:isFirstLoadPointer forKey:@"firstLoad"];
    }
    
    
    //loads data
    [self loadData];
    
    

    //check if the user already started a session
    if(user.rageInProgress == YES)
    {
        //change appropriate labels
        [user calcBAC];
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
    
    if(isFirstLoad)
    {
        [self performSegueWithIdentifier:@"toSettings" sender:self];
        isFirstLoad = NO;
        [self saveData];
    }
    if(user.rageInProgress)
    {
        self.currentDrinkName.topItem.title = currentDrink;
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
    self.currentDrink = drinkName;
    self.currentDrinkName.topItem.title = self.currentDrink;
    // puts the amount of alcohol in a container
    self.currentAlcOz = [alcOz doubleValue];
}




- (IBAction)drinkPressed:(id)sender
{

    //catch for no weight entered - this will be replaced with a uialert
    //on settings screen eventually
    if (user.weight == 0)
    {
        user.weight = 100;
    }
    
    
    
    //check if user has started
    if(user.rageInProgress)
    { 
        user.alcOz += currentAlcOz;
        user.numDrinks += 1;
        [user calcBAC];
        self.UserImage.image = user.userColor;
        numDrinksLabel.text = [NSString stringWithFormat:@"(%i)", user.numDrinks]; //update labels
        BACLabel.text = [NSString stringWithFormat:@"%.2f", user.BAC];
    }
    
    
    else //if the user is beginning a session, the drinkpicker will show automatically
    {
        
        
        user.rageInProgress = YES;
        self.doneButton.hidden = NO;
        self.topNavBar.rightBarButtonItem.enabled = YES;
        
        [self performSegueWithIdentifier:@"toDrinkPicker" sender:self];
        
        
        self.UserImage.image = user.userColor;
        
        user.startTime = [NSDate timeIntervalSinceReferenceDate];
        [buttonText setTitle:@"DRINK" forState:UIControlStateNormal]; //change button text
        
        
        
        //create a repeating timer with 10 second interval. Use onTick method below as selector
        t = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];     
    }
}



- (IBAction)donePressed:(id)sender
{
    //some future code
}



-(void) userClear //clears reusable data
    
{
    user.rageInProgress = NO;
    user.BAC = 0.0;
    user.alcOz = 0.0;
    user.numDrinks = 0;
    currentAlcOz = 0;
    user.maxBACHolder = 0.0;
    user.elapsedTime = 0;
    user.userColor = [UIImage imageNamed:@"Blue_1.png"];
    currentDrink = @"";
    currentAlcOz = 0;

    
    
    //clear labels
    BACLabel.text = @"0.0";
    numDrinksLabel.text = @"(0)";
    
    
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
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex != actionSheet.cancelButtonIndex)
    {
        
        NSString *color = [self calcGeneralColor:user.BAC];
        //add one to current number of times in designated color
        int num = [[user.overallStats objectForKey:color] integerValue] +1;
        [user.overallStats setObject:[NSNumber numberWithInt:num] forKey:color];
        
        
        //test printing of above block
        for (id key in user.overallStats) {
            NSLog(@"key: %@, value: %@ \n", key, [user.overallStats objectForKey:key]);
        }
        
        [self userClear];
    }
    else
    {
        [self userClear];
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
    self.UserImage.image = user.userColor;
    
    //make sure BAC doesn't go below 0
    if (user.BAC <= 0)
    {
        user.BAC = 0;
    }
    //change label
    BACLabel.text = [NSString stringWithFormat:@"%.2f", [user BAC]];
    NSLog(@"Time: %i \n BAC: %f", user.elapsedTime, user.BAC);
}




-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake && user.rageInProgress)
    {
        [self performSegueWithIdentifier:@"toDrinkPicker" sender:self];
    }
}

-(BOOL) canBecomeFirstResponder
{
    return YES;
}




@end
