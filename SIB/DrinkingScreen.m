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

@interface DrinkingScreen ()
@property NSTimer *t;

@end

@implementation DrinkingScreen
@synthesize currentDrinkName;
@synthesize currentAlcOz;
@synthesize user;
@synthesize BACLabel, numDrinksLabel, buttonText,t;

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
    
    //create user object on first load
    
    static dispatch_once_t pred;
    dispatch_once(&pred,^{
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
        
        //[buttonText setTitle:@"DRINK" forState:UIControlStateNormal];
    }
    else
    {
        //clear labels
        BACLabel.text = @"";
        numDrinksLabel.text = @"";
        //change button text to start
        [buttonText setTitle:@"START" forState:UIControlStateNormal];
        
    }
    
    

   
    
    
    
    
    
    
	
    //self.currentDrinkName.topItem.title = @"Light Beer";
}

- (void) viewDidAppear:(BOOL)animated
{
    
    //attempting to launch settings screen on first launch -- DOESN'T WORK
    static dispatch_once_t pred;
    dispatch_once(&pred,^{
        [self.navigationController performSegueWithIdentifier:@"toSettings" sender:self];
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
        
        //user.alcOz += currentAlcOz;
        //user.numDrinks += 1;
        //[user calcBAC];
        //numDrinksLabel.text = [NSString stringWithFormat:@"%i", user.numDrinks]; //update labels
        //BACLabel.text = [NSString stringWithFormat:@"%.2f", user.BAC];
    }
    
    else //if the user is beginning a session, the drinkpicker will show automagically
    {
        //show the drink picker
        
        
        
        //uncomment these when above works
        
        //user.rageInProgress = YES;
        //user.alcOz += currentAlcOz; //add info from first drink
        //user.numDrinks += 1;
        //[user calcBAC];
        //numDrinksLabel.text = [NSString stringWithFormat:@"%i", user.numDrinks]; //update labels
        //BACLabel.text = [NSString stringWithFormat:@"%.2f", user.BAC];
        //buttonText.titleLabel.text = @"DRINK"; //change button text
        
        
        //create a repeating timer with 10 second interval. Use onTick method below for selector
        
    }
    
    
    
    
      
      
    
    
    
}

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
    //NSLog(@"%i", user.elapsedTime);
}
@end
