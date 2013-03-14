//
//  SettingsScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//FUNCTIONAL SCREEN -- 2.18 (maybe missing some desired info)

#import "SettingsScreen.h"

@interface SettingsScreen ()

@end

@implementation SettingsScreen
@synthesize user,weightField,genderPicker,delegate;

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
    
    // put weight and selected gender as selections so as to avoid confusion, if already set
    if(user.weight > 0)
    {
        weightField.text = [[NSString alloc] initWithFormat:@"%i", user.weight];
    }
    
    genderPicker.selectedSegmentIndex = user.sex;
    
	// Do any additional setup after loading the view.
}


- (void) viewDidAppear:(BOOL)animated
{
    //maybe do some stuff here in the future
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DidChangeToFemale:(id)sender
{
    
    //if user changes gender while keyboard is active
    if(weightField.isFirstResponder)
    {
        [weightField resignFirstResponder]; // resign keyboard
    }
    user.sex = [genderPicker selectedSegmentIndex];
}

- (IBAction)callDismiss:(id)sender // done button
{
    
    
    if(weightField.isFirstResponder) //if keyboard still active on done
    {
        [weightField resignFirstResponder]; //dismiss it
    }
    
    //assign values into Settings Screen user object
    user.weight = [weightField.text integerValue];
    user.sex = [genderPicker selectedSegmentIndex];
    
    //pass them to up to drinking screen
    [delegate passBackUserSettings:self weight:user.weight userSex:user.sex];
    [self dismissViewControllerAnimated:YES completion:nil]; //dismiss screen
}

- (IBAction)dismissKeyboard:(id)sender
{
    [weightField resignFirstResponder]; //on downward swipe, dismiss keyboard
}

- (IBAction)didEnterWeight:(id)sender
{
    user.weight = [weightField.text integerValue];
    
    //don't let the user set a really low weight. 
    if (user.weight < 80)
    {
        user.weight = 80; //set to lowest plausible weight
    }
    [weightField resignFirstResponder];
}





@end
