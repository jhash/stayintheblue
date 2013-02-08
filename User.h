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
@property double alcOz;
@property BOOL rageInProgress;
@property double BAC;
@property NSMutableArray *bacHolder;



- (void) calcBAC;

- (void) calcTime;

- (NSString *) getFilePath;

- (void) saveData;

- (void) loadData;





@end
