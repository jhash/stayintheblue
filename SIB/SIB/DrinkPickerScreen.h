//
//  DrinkPickerScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DrinkingScreen.h"



@class DrinkPickerScreen;
@protocol DrinkPickerScreenDelegate <NSObject>

- (void)addItemViewController:(DrinkPickerScreen *)controller drinkName:(NSString *)drinkName alcOz: (NSNumber*) alcOz ;

@end



@interface DrinkPickerScreen : UITableViewController

@property (nonatomic, strong) NSDictionary *drinks;
@property (nonatomic, strong) NSArray *drinkKeys;
@property (nonatomic, weak) id <DrinkPickerScreenDelegate> delegate;

@end
