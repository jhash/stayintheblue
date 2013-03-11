//
//  NightStatsScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NightStatsScreen : UIViewController
@property int numDrinks;
@property double maxBAC;
@property (weak, nonatomic) IBOutlet UIImageView *loadImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadText;


@property (weak, nonatomic) IBOutlet UILabel *numDrinksLabel;

@property (weak, nonatomic) IBOutlet UILabel *maxBacLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorReachedLabel;
@property (weak, nonatomic) IBOutlet UILabel *drinkOrDrinks;
@property (weak, nonatomic) IBOutlet UILabel *stayedInTheLabel;

- (IBAction)donePressed:(id)sender;
@end
