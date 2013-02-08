//
//  SettingScreen.h
//  StayInTheBlue v4
//
//  Created by Steven Coffey on 1/6/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "HomeScreen.h"

@protocol DataDelegate 

- (void) receiveData: (User *) theData;

@end

@interface SettingScreen : UIViewController



@property (nonatomic) id <DataDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectedSex;
@property (weak, nonatomic) IBOutlet UITextField *userWeight;
@property (nonatomic, strong) User *SUser;


- (IBAction)sexSelected:(id)sender;
- (IBAction)weightEntered:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)SaveSettings:(id)sender;



@end
