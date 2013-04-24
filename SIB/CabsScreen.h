//
//  CabsScreen.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CabsScreen : UITableViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) NSDictionary  *cabs;
@property (strong, nonatomic) NSArray *cabKeys;
@property (strong, nonatomic) UILabel *crossStreets;
@property (strong, nonatomic) UIView *header;
@end
