//
//  AppDelegate.h
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PPRevealSideViewController.h"




@class DrinkingScreen;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DrinkingScreen *ds;
@property (strong, nonatomic) PPRevealSideViewController * revealBottomViewController;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;



@end
