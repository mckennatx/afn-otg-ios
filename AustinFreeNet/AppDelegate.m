//
//  AppDelegate.m
//  AustinFreeNet
//
//  Created by Lauren McKenna on 4/13/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
	[GMSServices provideAPIKey:@"AIzaSyDhbpgwpU0CpIJw9I8v1wjzdfnQ7JlDh54"];
	[[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x3E96C7)];
	[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"Avenir Next" size:20.0]}];
	[[UINavigationBar appearance] setTranslucent:NO];
	[application setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
	return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
	return YES;
}

@end
