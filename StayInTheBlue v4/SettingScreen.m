//
//  SettingScreen.m
//  StayInTheBlue v4
//
//  Created by Steven Coffey on 1/6/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import "SettingScreen.h"



@interface SettingScreen ()

@end

@implementation SettingScreen


@synthesize selectedSex, userWeight;
@synthesize SUser;



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
    SUser = [[User alloc] init];
    SUser.sex = m;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sexSelected:(id)sender
{
    switch (selectedSex.selectedSegmentIndex) {
        case 0:
            SUser.sex = m;
            break;
            
        case 1:
            SUser.sex = f;
            break;
            
        default: SUser.sex = m;
    }
    NSLog(@"%u", SUser.sex);
}

- (IBAction)weightEntered: (id)sender
{
    SUser.weight = [userWeight.text integerValue];
    
}

- (IBAction)closeKeyboard:(id)sender
{
    [userWeight resignFirstResponder];
}

- (IBAction)SaveSettings:(id)sender{
    
    [self.delegate receiveData:SUser];
    
    [self.navigationController popViewControllerAnimated:YES];
}




@end
