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


@property (weak, nonatomic) IBOutlet UILabel *numDrinksLabel;

@property (weak, nonatomic) IBOutlet UILabel *maxBacLabel;
@property (weak, nonatomic) IBOutlet UILabel *peakText;
@property (weak, nonatomic) IBOutlet UIImageView *finishImage;

- (IBAction)donePressed:(id)sender;
@end
