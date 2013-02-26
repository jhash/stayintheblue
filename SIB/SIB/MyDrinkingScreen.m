//
//  MyDrinkingScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//NOT FUNCTIONAL

#import "MyDrinkingScreen.h"
#import <QuartzCore/QuartzCore.h>

@interface MyDrinkingScreen ()

@property int X_Line, Y_Line, x, y;

@end

@implementation MyDrinkingScreen

@synthesize X_Line, Y_Line, x, y;

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


-(void) viewDidAppear:(BOOL)animated
{
    [self createNewBarWithValue:.8 andImage:self.graphImageView];
    
}


- (void)createNewBarWithValue:(float)percent andImage:(UIImageView *)newBar
{
    CABasicAnimation *scaleToValue = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleToValue.toValue = [NSNumber numberWithFloat:percent*2.5];
    scaleToValue.fromValue = [NSNumber numberWithFloat:0];
    scaleToValue.duration = 1.5f;
    scaleToValue.delegate = self;
    
    newBar.layer.anchorPoint = CGPointMake(0.5, 1);
    
    [newBar.layer addAnimation:scaleToValue forKey:@"scaleUp"];
    CGAffineTransform scaleTo = CGAffineTransformMakeScale( 1.0f, percent * 2.5);
    newBar.transform = scaleTo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
