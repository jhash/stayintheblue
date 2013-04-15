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
@synthesize sendReminders;
@synthesize BAC;
@synthesize currentAlcOz;
@synthesize lastAlcOz;
@synthesize currentDrink;
@synthesize maxBACHolder;
@synthesize overallStats;
@synthesize drinksHad;
@synthesize lastDateDrank;



static User *sharedUser;

+(User *)sharedUser {
    
    if(!sharedUser) {
        
        sharedUser = [[User alloc] init];
    }
    
    return sharedUser;
}



- (void) calcBAC
{
    //update the current time
    [self calcTime];
    //NSLog(@"time: %i", self.elapsedTime);
    

    
    //update the BAC
    //sources of grahams/Oz and proof calculation
    //http://wiki.answers.com/Q/How_many_grams_of_alcohol_in_two_ounces_of_eighty_proof_whiskey
    //source of BAC calculation
    //http://www.had2know.com/society/how-to-calculate-bac.html
    
    if (sex == m) {
        
        BAC = (80.6*(alcOz*23.36)/(263.08627*weight)) - (.015*(elapsedTime * .0002));
    }
    if (sex == f) {
        BAC = (80.6*(alcOz*23.36)/(222.26254*weight)) - (.015*(elapsedTime * .0002));
    }
    
    if (BAC > maxBACHolder)
    {
        maxBACHolder = BAC;
    }
    if (BAC < 0)
    {
        BAC = 0;
    }
    [self saveUser];
}

-(double)calcSingleDrinkUndoBAC
{
    double retVal;
    if (sex == m) {
        
        retVal = (80.6*(lastAlcOz*23.36)/(263.08627*weight)) - (.015*(elapsedTime * .0002));
    }
    if (sex == f) {
        retVal = (80.6*(lastAlcOz*23.36)/(222.26254*weight)) - (.015*(elapsedTime * .0002));
    }
    
    return retVal;
    
}

- (void) calcTime
{
    elapsedTime = ([NSDate timeIntervalSinceReferenceDate] - startTime);
}




- (void) saveUser
{
    NSString *filepath = [self getFilePath];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeInt:self.weight forKey:@"weight"];
    [archiver encodeInt:self.sex forKey:@"sex"];
    [archiver encodeInt:self.numDrinks forKey:@"numDrinks"];
    [archiver encodeInt:self.startTime forKey:@"startTime"];
    [archiver encodeInt:self.elapsedTime forKey:@"elapsedTime"];
    [archiver encodeDouble:self.BAC forKey:@"bac"];
    [archiver encodeDouble:self.currentAlcOz forKey:@"currentAlcOz"];
    [archiver encodeDouble:self.lastAlcOz forKey:@"lastAlcOz"];
    [archiver encodeDouble:self.maxBACHolder forKey:@"maxBACHolder"];
    [archiver encodeDouble:self.alcOz forKey:@"alcOz"];
    [archiver encodeBool:self.rageInProgress forKey:@"rageInProgress"];
    [archiver encodeBool:self.sendReminders forKey:@"sendReminders"];
    [archiver encodeObject:self.overallStats forKey:@"overallStats"];
    [archiver encodeObject:self.drinksHad forKey:@"drinksHad"];
    [archiver encodeObject:self.currentDrink forKey:@"currentDrink"];
    [archiver encodeObject:self.lastDateDrank forKey:@"lastDateDrank"];
    
    [archiver finishEncoding];
    
    BOOL success = [data writeToFile:filepath atomically:YES];
    
    
    //NSLog(@"%@", success ? @"YES" : @"NO");
}


- (NSString *) getFilePath
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathArray objectAtIndex:0] stringByAppendingPathComponent:@"saved.plist"];
}

- (void) loadUser
{
    NSString *filepath = [self getFilePath];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:filepath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    
    self.weight = [unarchiver decodeIntForKey:@"weight"];
    self.sex = [unarchiver decodeIntForKey:@"sex"];
    self.numDrinks = [unarchiver decodeIntForKey:@"numDrinks"];
    self.startTime = [unarchiver decodeIntForKey:@"startTime"];
    self.elapsedTime = [unarchiver decodeIntForKey:@"elapsedTime"];
    self.BAC = [unarchiver decodeDoubleForKey:@"bac"];
    self.maxBACHolder = [unarchiver decodeDoubleForKey:@"maxBACHolder"];
    self.alcOz = [unarchiver decodeDoubleForKey:@"alcOz"];
    self.currentAlcOz = [unarchiver decodeDoubleForKey:@"currentAlcOz"];
    self.lastAlcOz = [unarchiver decodeDoubleForKey:@"lastAlcOz"];
    self.rageInProgress = [unarchiver decodeBoolForKey:@"rageInProgress"];
    self.sendReminders = [unarchiver decodeBoolForKey:@"sendReminders"];
    self.overallStats = [unarchiver decodeObjectForKey:@"overallStats"];
    self.drinksHad = [unarchiver decodeObjectForKey:@"drinksHad"];
    self.currentDrink = [unarchiver decodeObjectForKey:@"currentDrink"];
    self.lastDateDrank = [unarchiver decodeObjectForKey:@"lastDateDrank"];
    
    
    
    //NSLog(@"%@", self);
    
//    currentDrink = [unarchiver decodeObjectForKey:@"currentDrink"];
//    currentAlcOz = [unarchiver decodeDoubleForKey:@"currentAlcOz"];
    [unarchiver finishDecoding];
}





- (id) init
{
    self = [super init];
    if (self) {
        startTime = [NSDate timeIntervalSinceReferenceDate];
        elapsedTime = 0;
        weight = 0;
        numDrinks = 0;
        alcOz = 0.0;
        currentAlcOz = 0.0;
        lastAlcOz = 0.0;
        rageInProgress = NO;
        sex = m;
        BAC = 0.0;
        currentDrink = @"";
        maxBACHolder = 0.0;
        NSNumber *zeroNum = [NSNumber numberWithInt:0];
        overallStats = [[NSMutableDictionary alloc] initWithObjectsAndKeys:zeroNum, @"blue", zeroNum,  @"maize", zeroNum, @"red", nil];
        drinksHad = [[NSMutableDictionary alloc] init];
        [drinksHad removeAllObjects];
        lastDateDrank = [[NSDate alloc] init];
    }
    return self;
}




- (void) toString
{
    NSLog(@"Start time: %i", self.startTime);
    NSLog(@"Elapsed time: %i", self.elapsedTime);
    NSLog(@"Weight: %i", self.weight);
    NSLog(@"Drinks: %i", self.numDrinks);
    NSLog(@"BAC: %f", self.BAC);
    NSLog(@"Max BAC: %f", self.maxBACHolder);
    NSLog(@"Alcohol: %f oz", self.alcOz);
    NSLog(@"Current drink strength: %f oz", self.currentAlcOz);
    NSLog(@"Last Alc Oz: %f oz", self.lastAlcOz);
    NSLog(@"Session started: %u", self.rageInProgress);
    NSLog(@"Gender: %@", self.sex ? @"Male":@"Female");
    NSLog(@"Stats: %@", self.overallStats);
    NSLog(@"Current drink: %@", self.currentDrink);
}


@end
