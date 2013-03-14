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
@synthesize loadImage,loadIndicator,loadText;

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
    
    
    self.colorReachedLabel.text = [self calcGeneralColor:maxBAC];

    maxBacLabel.text = [NSString stringWithFormat:@"%.2f", maxBAC];
    numDrinksLabel.text = [NSString stringWithFormat:@"%i", numDrinks];
    if(numDrinks == 1)
    {
        self.drinkOrDrinks.text = @"DRINK";
    }
    
    
    //if user stayed in the blue, say that
    if([self.colorReachedLabel.text isEqual:@"BLUE"])
    {
        self.stayedInTheLabel.text = @"AND STAYED IN THE";
        self.colorReachedLabel.textColor = [UIColor yellowColor];
        self.colorReachedLabel.backgroundColor = [UIColor blueColor];
    }
    else if ([self.colorReachedLabel.text isEqual:@"MAIZE"])
    {
        self.stayedInTheLabel.text = @"AND GOT INTO THE";
        self.colorReachedLabel.textColor = [UIColor blueColor];
        self.colorReachedLabel.backgroundColor = [UIColor yellowColor];
    }
    else
    {
        self.stayedInTheLabel.text = @"AND GOT INTO THE";
        self.colorReachedLabel.textColor = [UIColor blackColor];
        self.colorReachedLabel.backgroundColor = [UIColor redColor];
    }
    
    
    
    NSArray *loadingArray = [[NSArray alloc] initWithObjects:@"Measuring Remaining Dignity", @"Calculating Booze Coefficient", @"Instagramming Drink Pics", @"#YOLOING", nil];
    int randomNum = arc4random_uniform([loadingArray count]);
    loadText.text = [loadingArray objectAtIndex:randomNum];
    
    loadIndicator.hidden = NO;
    loadText.hidden = NO;
    [loadIndicator startAnimating];
}

-(void) viewDidAppear:(BOOL)animated
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       //sleep(5);
                       dispatch_async(dispatch_get_main_queue(), ^{
                           loadImage.hidden = YES;
                           loadText.hidden = YES;
                           loadIndicator.hidden = YES;
                           [loadIndicator stopAnimating];
                       });
                   });
}


- (NSString *) calcGeneralColor: (double) BAC
{
    if(BAC < .07)
    {
        return @"BLUE";
    }
    if(BAC > .07 && BAC < .19)
    {
        return @"MAIZE";
    }
    else
    {
        return @"RED";
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
