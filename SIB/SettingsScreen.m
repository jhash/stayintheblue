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
@synthesize user,weightField,genderPicker,delegate, num;
@synthesize reminderSwitch;

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
    user = [User sharedUser];
    
    // put weight and selected gender as selections so as to avoid confusion, if already set
    if(user.weight > 0)
    {
        weightField.text = [[NSString alloc] initWithFormat:@"%i", user.weight];
    }
    
    self.genderPicker.selectedSegmentIndex = user.sex;
    [self.reminderSwitch setOn: user.sendReminders];
    
    
    UIToolbar *numPadDoneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numPadDoneToolbar.barStyle = UIBarStyleBlackTranslucent;
    numPadDoneToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard:)], nil];
    [numPadDoneToolbar sizeToFit];
    weightField.inputAccessoryView = numPadDoneToolbar;
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
    BOOL didEnterWeight = YES;
    user.sendReminders = self.reminderSwitch.isOn;
    if([weightField.text isEqualToString:@""])
    {
        NSString *errorMsg = @"Please enter your weight";
        
        UIAlertView *weightError = [[UIAlertView alloc]
                                    initWithTitle:@"Error"
                                    message:errorMsg
                                    delegate:self
                                    cancelButtonTitle:@"OK"
                                    otherButtonTitles:nil, nil];
        didEnterWeight = NO;
        [weightError show];
    }
    
    
    if(weightField.isFirstResponder) //if keyboard still active on done
    {
        [weightField resignFirstResponder]; //dismiss it
    }
    
    //assign values into Settings Screen user object
    user.weight = [weightField.text integerValue];
    user.sex = [genderPicker selectedSegmentIndex];
    
    //pass them to up to drinking screen
    
    if(didEnterWeight)
    {
        [delegate passBackUserSettings:self weight:user.weight userSex:user.sex];
        [self dismissViewControllerAnimated:YES completion:nil]; //dismiss screen
        
        MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
        overlay.animation = MTStatusBarOverlayAnimationNone;
        [overlay postFinishMessage:@"Saved!" duration:4.0 animated:NO];
        
    }
    [user saveUser];
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





- (IBAction)reminderSwitch:(id)sender {
}
@end
