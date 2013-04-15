//
//  NightStatsScreen.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

//NOT FUNCTIONAL

#import "NightStatsScreen.h"

@interface NightStatsScreen ()


@end

@implementation NightStatsScreen


@synthesize maxBAC,maxBacLabel,numDrinks,numDrinksLabel;

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
    
    UIColor *blueCol = [UIColor colorWithRed:(50.0/255.0)
                                       green:(85.0/255.0)
                                        blue:(150.0/255.0)
                                       alpha:1.0];
    UIColor *maizeCol = [UIColor colorWithRed:(232.0/255.0)
                                        green:(237.0/255.0)
                                         blue:(19.0/255.0)
                                        alpha:1.0];
    UIColor *redCol = [UIColor colorWithRed:(168.0/255.0)
                                      green:(40.0/255.0)
                                       blue:(34.0/255.0)
                                      alpha:1.0];
    
    
    maxBacLabel.text = [NSString stringWithFormat:@"%.2f", maxBAC];
    numDrinksLabel.text = [NSString stringWithFormat:@"%i", numDrinks];
    int levelReached = [self calcGeneralColor:maxBAC];

    //if user stayed in the blue, say that
    if(levelReached == 1 )
    {
        self.finishImage.image = [UIImage imageNamed:@"FinishBlue.png"];
        self.peakText.textColor = blueCol;
    }
    else if (levelReached == 2)
    {
        self.finishImage.image = [UIImage imageNamed:@"FinishMaize.png"];
        self.peakText.textColor = maizeCol;
    }
    else
    {
        self.finishImage.image = [UIImage imageNamed:@"FinishRed.png"];
        self.peakText.textColor = redCol;
    }
    
    
}

-(void) viewDidAppear:(BOOL)animated
{
    
 
}


- (int) calcGeneralColor: (double) BAC
{
    if(BAC < .07)
    {
        return 1;
    }
    if(BAC > .07 && BAC < .19)
    {
        return 2;
    }
    else
    {
        return 3;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
