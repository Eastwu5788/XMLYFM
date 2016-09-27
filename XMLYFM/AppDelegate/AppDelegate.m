//
//  AppDelegate.m
//  XMLYFM
//
//  Created by East_wu on 16/8/8.
//  Copyright © 2016年 East_wu. All rights reserved.
//

#import "AppDelegate.h"
#import "XMLYRootViewController.h"
#import "XMLYPlayViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - system

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[XMLYPlayViewController playViewController] saveCurrentPlayHistory];
}


#pragma mark - private



@end
