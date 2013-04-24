//
//  DrinkPickerScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>



@class DrinkPickerScreen;
@protocol DrinkPickerScreenDelegate <NSObject>

- (void)addItemViewController:(DrinkPickerScreen *)controller drinkName:(NSString *)drinkName alcOz: (NSNumber*) alcOz ;

@end



@interface DrinkPickerScreen : UITableViewController

@property (nonatomic, strong) NSDictionary *drinks;
@property (nonatomic, strong) NSArray *drinkKeys;
@property (nonatomic, weak) id <DrinkPickerScreenDelegate> delegate;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property NSString *colorLevel;

@property NSString *currentDrink;
@property UIColor *blue;
@property UIColor *darkerBlue;
@property UIColor *maize;
@property UIColor *darkerMaize;
@property UIColor *red;
@property UIColor *darkerRed;

- (IBAction)donePressed:(UIBarButtonItem *)sender;
@end
