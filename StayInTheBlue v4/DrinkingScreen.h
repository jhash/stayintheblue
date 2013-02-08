//
//  DrinkingScreen.h
//  StayInTheBlue v4
//
//  Created by Steven Coffey on 1/6/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScreen.h"
#import "User.h"


@interface DrinkingScreen : UIViewController

@property User * user;
- (IBAction)TestButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *TestLabel;    

@end
