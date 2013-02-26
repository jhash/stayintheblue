 //
//  User.m
//  StayInTheBlue-ClassTest
//
//  Created by Steven Coffey on 12/29/12.
//  Copyright (c) 2012 SJ. All rights reserved.
//

#import "User.h"



@implementation User

@synthesize sex;
@synthesize weight;
@synthesize startTime;
@synthesize elapsedTime;
@synthesize numDrinks;
@synthesize alcOz;
@synthesize rageInProgress;
@synthesize isFirstLoad;
@synthesize BAC;
@synthesize maxBACHolder;
@synthesize userColor;
@synthesize overallStats;


- (NSString *) getFilePath {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathArray objectAtIndex:0] stringByAppendingPathComponent:@"saved.plist"];
}


- (void) saveData{
    NSArray *value = [[NSArray alloc] initWithObjects: [NSNumber  numberWithInt:sex], [NSNumber numberWithInt:weight], [NSNumber numberWithInt:startTime], [NSNumber numberWithDouble:alcOz], rageInProgress, [NSNumber numberWithDouble:BAC], maxBACHolder, nil];
    
    [value writeToFile:[self getFilePath] atomically:YES];
}

- (void) loadData {
    NSString *myPath = [self getFilePath];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:myPath];
    NSLog(@"%c", fileExists);

    
    //check if file exists
    if (fileExists){
        NSArray *values = [[NSArray alloc] initWithContentsOfFile:myPath];
        
        
        // if so, load values into user
        // sex
        if ([[values objectAtIndex:0] integerValue] == 0)
        {
            sex = m;
        }
        else {
            sex = f;
        }
        weight = [[values objectAtIndex:1] integerValue];
        startTime = [[values objectAtIndex:2] integerValue];
        elapsedTime = [[values objectAtIndex:3] integerValue];
        alcOz = [[values objectAtIndex:4] doubleValue];
        rageInProgress = [[values objectAtIndex:5] boolValue];
        BAC = [[values objectAtIndex:6] doubleValue];
        maxBACHolder = [[values objectAtIndex:7] doubleValue];
        NSLog(@"%@", values);
     }
    
    
}






- (void) calcBAC
{
    //update the current time
    [self calcTime];
    
    
    //update the BAC
    if (sex == m) {
        BAC = (alcOz * 5.14/weight * .73) - (.015*(elapsedTime * .0002));
    }
    if (sex == f) {
        BAC = (alcOz * 5.14/weight * .66) - (.015*(elapsedTime * .0002));
    }

    if (BAC > maxBACHolder)
    {
        maxBACHolder = BAC;
    }
    //[self saveData];

}

- (void) calcTime
{
    elapsedTime = ([NSDate timeIntervalSinceReferenceDate] - startTime);
}


- (void) updateColor
{
    //need images for color, series of if statments will update the image based on the color. 
}



- (id) init
{
    self = [super init];
    if (self) {
        startTime = [NSDate timeIntervalSinceReferenceDate];
        elapsedTime = 0;
        weight = 0;
        numDrinks = 0;
        alcOz = 0;
        rageInProgress = NO;
        isFirstLoad = YES;
        sex = m;
        BAC = 0.0;
        maxBACHolder = 0.0;
        NSNumber *zeroNum = [NSNumber numberWithInt:0];
        overallStats = [[NSMutableDictionary alloc] initWithObjectsAndKeys:zeroNum, @"blue", zeroNum,  @"maize",
                        zeroNum, @"red", nil];
    }
    //[self saveData];
    return self;
}

@end
