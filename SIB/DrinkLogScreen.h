//
//  DrinkLogScreen.h
//  SIB
//
//  Created by Steven Coffey on 3/31/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface DrinkLogScreen : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *drinkLogKeys;
@property NSArray *sortedDrinkLogKeys;
@property User *user;
@property (weak, nonatomic) IBOutlet UITableView *drinkTable;


- (IBAction)backPressed:(id)sender;
@end
