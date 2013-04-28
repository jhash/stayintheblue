//
//  InfoScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoScreen : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *uniqnameTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property NSTimer *errorLabelTimer;
@property BOOL didEnterUniqname;



- (IBAction)sendToServerButton:(id)sender;

@end
