//
//  SettingsScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "MTStatusBarOverlay.h"



@class  SettingsScreen;
@protocol SettingsScreenDelegate <NSObject>

- (void) passBackUserSettings:(SettingsScreen *)controller weight: (int) weight userSex: (gender) sex ;

@end


@interface SettingsScreen : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderPicker;
@property (weak, nonatomic) IBOutlet UISwitch *reminderSwitch;
@property User *user;
@property (nonatomic, weak) id <SettingsScreenDelegate> delegate;
@property NSString *num;

- (IBAction)DidChangeToFemale:(id)sender;
- (IBAction)callDismiss:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;



@end
