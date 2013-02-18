//
//  DrinkingScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//


#import "DrinkPickerScreen.h"
#import <UIKit/UIKit.h>
#import "User.h"


@interface DrinkingScreen : UIViewController <DrinkPickerScreenDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *currentDrinkName;
@property double currentAlcOz;
@property User *user;


@end
