//
//  HomeScreen.m
//  StayInTheBlue v4
//
//  Created by Steven Coffey on 1/6/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import "HomeScreen.h"


@interface HomeScreen () <DataDelegate> 

@end

@implementation HomeScreen

@synthesize user;


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // determine which screen we're segueing to
    if([segue.identifier isEqualToString:@"toSettings"])
    {
        SettingScreen *ss = [segue destinationViewController];
        User *currentUser = user;
        ss.navigationItem.hidesBackButton = YES;
        [ss setSUser:currentUser];
        ss.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"toDrinking"])
    {
        DrinkingScreen *dScreen = [segue destinationViewController];
        User *currentUser = user;
        [dScreen setUser:currentUser];
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
    // this is the first screen to load, thus we initialize the
    // user and save data, zeroing all values
    user = [[User alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) receiveData:(User *)theData
{
    user.weight = theData.weight;
    user.sex = theData.sex;
}

- (IBAction)testLoad:(id)sender {
    
    NSLog(@"%u   %i", user.sex, user.weight);
}

- (void)dismissCabs: (CabScreen *) cabs
{
    [cabs dismissViewControllerAnimated:YES completion:nil];
    
    
}
@end
