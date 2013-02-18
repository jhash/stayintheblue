//
//  HomeScreen.h
//  StayInTheBlue v4
//
//  Created by Steven Coffey on 1/6/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "SettingScreen.h"
#import "CabScreen.h"
#import "DrinkingScreen.h"

@interface HomeScreen : UIViewController <UITableViewDelegate>


@property (nonatomic, strong) User *user;

- (IBAction)testLoad:(id)sender;

- (void)dismissCabs: (CabScreen *) cabs;



@end
