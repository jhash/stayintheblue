//
//  User.h
//  StayInTheBlue-ClassTest
//
//  Created by Steven Coffey on 12/29/12.
//  Copyright (c) 2012 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {m, f} gender;

@interface User : NSObject

@property gender sex;
@property int weight;
@property int startTime;
@property int elapsedTime;
@property int numDrinks;
@property double alcOz;
@property BOOL rageInProgress;
@property BOOL sendReminders;
@property double BAC;
@property double currentAlcOz;
@property double lastAlcOz;
@property double maxBACHolder;
@property NSMutableDictionary *overallStats;
@property NSMutableDictionary *drinksHad;
@property NSString * currentDrink;
@property NSString *lastDateDrank;





+ (User *) sharedUser;

- (void) calcBAC;

- (void) calcTime;
- (void) saveUser;
- (void) loadUser;
- (void) toString;
-(double)calcSingleDrinkUndoBAC;





@end
