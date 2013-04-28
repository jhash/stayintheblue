//
//  AppDelegate.m
//  SIB
//
//  Created by Steven Coffey on 2/17/13.
//  Copyright (c) 2013 SJ. All rights reserved.
//

#import "AppDelegate.h"
#import "DrinkingScreen.h"
#import "TestFlight.h"
#import "User.h"
#import "ToDoA2Screen.h"
#import "CabsScreen.h"
#import "InfoScreen.h"
#import <CoreData/CoreData.h>



@implementation AppDelegate


@synthesize ds, window;
@synthesize managedObjectContext,persistentStoreCoordinator,managedObjectModel;
@synthesize revealBottomViewController = _revealBottomViewController;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    #define TESTING 1
    #ifdef TESTING
        [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
    #endif
    
    [TestFlight takeOff:@"965a22ce-5d41-4398-b406-001d08ab9052"];
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];           
    self.ds = [storyboard instantiateViewControllerWithIdentifier:@"tabController"];

    

    _revealBottomViewController = [[PPRevealSideViewController alloc] initWithRootViewController:ds];
    
    self.window.rootViewController = _revealBottomViewController;
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{


    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If   your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}






@end
