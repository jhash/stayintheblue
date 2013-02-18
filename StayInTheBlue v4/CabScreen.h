//
//  CabScreen.h
//  StayInTheBlue v4
//
//  Created by Steven Coffey on 1/6/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CabScreen : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) NSDictionary  *cabs;
@property (strong, nonatomic) NSArray *cabKeys;


@end
