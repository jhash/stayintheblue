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
@synthesize proof;
@synthesize rageInProgress;
@synthesize isFirstLoad;
@synthesize BAC;
@synthesize maxBACHolder;
@synthesize userColor;
@synthesize overallStats;




- (void) calcBAC
{
    //update the current time
    [self calcTime];
    
    //old equation
    /*/update the BAC
     if (sex == m) {
     BAC = (alcOz * 5.14/weight * .73) - (.015*(elapsedTime * .0002));
     }
     if (sex == f) {
     BAC = (alcOz * 5.14/weight * .66) - (.015*(elapsedTime * .0002));
     }
     */
    
    //update the BAC
    //sources of grahams/Oz and proof calculation
    //http://wiki.answers.com/Q/How_many_grams_of_alcohol_in_two_ounces_of_eighty_proof_whiskey
    //source of BAC calculation
    //http://www.had2know.com/society/how-to-calculate-bac.html
    
    if (sex == m) {
        
        BAC = (80.6*(alcOz*28.3495*proof/200)/(263.08627*weight)) - (.015*(elapsedTime * .0002));
    }
    if (sex == f) {
        BAC = (80.6*(alcOz*28.3495*proof/200)/(222.26254*weight)) - (.015*(elapsedTime * .0002));
    }
    
    if (BAC > maxBACHolder)
    {
        maxBACHolder = BAC;
    }
    [self updateColor];

}

- (void) calcTime
{
    elapsedTime = ([NSDate timeIntervalSinceReferenceDate] - startTime);
}


- (void) updateColor
{
    double bac = self.BAC;
    
    if (bac < .01)
    {
        userColor = [UIImage imageNamed:@"Blue_1.png"];
    }
    else if(bac >.01 && bac < .02)
    {
        userColor = [UIImage imageNamed:@"Blue_2.png"];
    }
    else if(bac > .02 && bac < .03)
    {
        userColor = [UIImage imageNamed:@"Blue_3.png"];
    }
    else if(bac > .03 && bac < .04)
    {
        userColor = [UIImage imageNamed:@"Blue_4.png"];
    }
    else if(bac > .04 && bac < .05)
    {
        userColor  = [UIImage imageNamed:@"Blue_5.png"];
    }
    else if(bac > .05 && bac < .06)
    {
        userColor = [UIImage imageNamed:@"Blue_6.png"];
    }
    else if(bac > .06 && bac < .07)
    {
        userColor = [UIImage imageNamed:@"Blue_7.png"];
    }
    else if(bac > .07 && bac < .087 )
    {
        userColor = [UIImage imageNamed:@"Maize_1.png"];
    }
    else if(bac > .087 && bac < .104)
    {
        userColor = [UIImage imageNamed:@"Maize_2.png"];
    }
    else if(bac > .104 && bac < 0.121)
    {
        userColor = [UIImage imageNamed:@"Maize_3.png"];
    }
    else if(bac > 0.121 && bac < 0.138 )
    {
        userColor = [UIImage imageNamed:@"Maize_4.png"];
    }
    else if(bac > 0.138 && bac < 0.155)
    {
        userColor = [UIImage imageNamed:@"Maize_5.png"];
    }
    else if(bac > 0.155 && bac < 0.172)
    {
        userColor = [UIImage imageNamed:@"Maize_6.png"];
    }
    else if(bac > 0.172 && bac < 0.19)
    {
        userColor = [UIImage imageNamed:@"Maize_7.png"];
    }
    else if(bac > .19 && bac < .2)
    {
        userColor = [UIImage imageNamed:@"Red_1.png"];
    }
    else if(bac > .2 && bac < .21)
    {
        userColor = [UIImage imageNamed:@"Red_2.png"];
    }
    else if(bac > .21 && bac <.22)
    {
        userColor = [UIImage imageNamed:@"Red_3.png"];
    }
    else if(bac > .22 && bac < .23)
    {
        userColor = [UIImage imageNamed:@"Red_4.png"];
    }
    else if(bac > .23 && bac <.24)
    {
        userColor = [UIImage imageNamed:@"Red_5.png"];
    }
    else if(bac> .24 && bac < .25)
    {
        userColor = [UIImage imageNamed:@"Red_6.png"];
    }
    else
    {
        userColor = [UIImage imageNamed:@"Red_7.png"];
    }
}



#pragma mark encoding and decoding

- (void) encodeWithCoder:(NSCoder *) encoder
{
    [encoder encodeInt:self.weight forKey:@"weight"];
    [encoder encodeInt:self.sex forKey:@"sex"];
    [encoder encodeInt:self.numDrinks forKey:@"numDrinks"];
    [encoder encodeInt:self.startTime forKey:@"startTime"];
    [encoder encodeInt:self.elapsedTime forKey:@"elapsedTime"];
    [encoder encodeDouble:self.BAC forKey:@"bac"];
    [encoder encodeDouble:self.maxBACHolder forKey:@"maxBACHolder"];
    [encoder encodeDouble:self.alcOz forKey:@"alcOz"];
    [encoder encodeBool:self.rageInProgress forKey:@"rageInProgress"];
    [encoder encodeObject:self.overallStats forKey:@"overallStats"];
}

- (id) initWithCoder:(NSCoder *) decoder
{
    if(self = [super init])
    {
        weight = [decoder decodeIntForKey:@"weight"];
        sex = [decoder decodeIntForKey:@"sex"];
        numDrinks = [decoder decodeIntForKey:@"numDrinks"];
        startTime = [decoder decodeIntForKey:@"startTime"];
        elapsedTime = [decoder decodeIntForKey:@"elapsedTime"];
        BAC = [decoder decodeDoubleForKey:@"bac"];
        maxBACHolder = [decoder decodeDoubleForKey:@"maxBACHolder"];
        alcOz = [decoder decodeDoubleForKey:@"alcOz"];
        rageInProgress = [decoder decodeBoolForKey:@"rageInProgress"];
        overallStats = [decoder decodeObjectForKey:@"overallStats"];
    }
    
    //fallback else block, program should never reach this code
    else
    {
        self = [self init];
    }
    return self;
}


-(id) copyWithZone:(NSZone *) zone
{
    User *copy = [[[self class] allocWithZone:zone] init];
    
    //object copy
    copy.overallStats = [self.overallStats copyWithZone:zone];
    
    
    //standard type copies
    copy.weight = self.weight;
    copy.sex = self.sex;
    copy.numDrinks = self.numDrinks;
    copy.startTime = self.startTime;
    copy.elapsedTime = self.startTime;
    copy.BAC = self.BAC;
    copy.maxBACHolder = self.maxBACHolder;
    copy.alcOz = self.alcOz;
    copy.rageInProgress = self.rageInProgress;
    
    return copy;
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
        proof = 6;
        rageInProgress = NO;
        isFirstLoad = YES;
        sex = m;
        BAC = 0.0;
        maxBACHolder = 0.0;
        NSNumber *zeroNum = [NSNumber numberWithInt:0];
        overallStats = [[NSMutableDictionary alloc] initWithObjectsAndKeys:zeroNum, @"blue", zeroNum,  @"maize", zeroNum, @"red", nil];
        userColor = [UIImage imageNamed:@"Blue_1.png"];
    }
    return self;
}

@end
