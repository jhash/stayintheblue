//
//  InfoScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//PARTIALLY FUNCTIONAL SCREEN -- 2.18 - lackcing all info

#import "InfoScreen.h"
#import <QuartzCore/QuartzCore.h>

#define dbURL @"http://instanthipster.stevendcoffey.com/sibDatabaseBackend.php"

@interface InfoScreen ()

@end

@implementation InfoScreen

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
    
    
    
    
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendToServerButton:(id)sender
{
    int deviceID = 1;
    NSString *uniqname = self.uniqnameTextField.text;
    uniqname = [uniqname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat:@"%@?uniqname=%@&deviceID=%i",
                           dbURL,uniqname,deviceID];
    NSLog(@"%@", urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    __block int returnCode;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSError *e;
                       NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&e];
                       NSLog(@"%@", e);
                       NSString *returnData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                       dispatch_async(dispatch_get_main_queue(), ^{
                           returnCode = [returnData integerValue];
                       });
                       NSLog(@"%@", returnData);
                       
                       
                       
                       //---------ERROR CODE KEY---------------------DESIRED FUNCTION
                       //  0   - Success                           -- Hide entry field
                       // 101  - uniqname already in database      -- do not hide entry field, err msg
                       // 201  - sql error                         -- do not hide entry field, err msg
                       // 301  - bad uniqname                      -- do not hide entry field, err msg
                       
                       switch (returnCode)
                       {
                           case 0:
                           {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   self.uniqnameTextField.hidden = YES;
                                   self.submitButton.hidden = YES;
                                   self.didEnterUniqname = YES;
                                   self.errorLabel.text = @"Thanks for entering!";
                                   self.errorLabel.hidden = NO;
                                   [self.uniqnameTextField resignFirstResponder];
                               });
                               break;
                           }
                               
                           case 101:
                           {
                               [self showErrorLabelWithText:@"Uniqname already in database"];
                               break;
                           }
                               
                           case 201:
                           {
                               [self showErrorLabelWithText:@"Database error, please try again later"];
                               break;
                           }
                               
                           case 301:
                           {
                               [self showErrorLabelWithText:@"Invalid Uniqname"];
                               break;
                           }
                            
                       }
                   });
    
    
}



-(void)onTick: (NSTimer *)t
{

    CABasicAnimation *textFade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [textFade setToValue:[NSNumber numberWithFloat:0]];
    [textFade setFromValue:[NSNumber numberWithFloat:1]];
    [textFade setDuration:1];
    [textFade setRepeatCount:0];
    [textFade setRemovedOnCompletion:NO];
    [textFade setFillMode:kCAFillModeForwards];
    [self.errorLabel.layer addAnimation:textFade forKey:@"opacity"];
    [self.view.layer addSublayer:self.errorLabel.layer];
    
    
    [t invalidate];
    //self.errorLabel.hidden = YES;
}

-(void)showErrorLabelWithText:(NSString *) errmsg
{
  
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel.layer removeAllAnimations];
        self.errorLabel.layer.opacity = 1.0;
        
        self.errorLabel.text = errmsg;
        self.errorLabel.hidden = NO;
        [NSTimer scheduledTimerWithTimeInterval:3
                                         target:self
                                       selector:@selector(onTick:)
                                       userInfo:nil
                                        repeats:NO];
    });
}
@end
