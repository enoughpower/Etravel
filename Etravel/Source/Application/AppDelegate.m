//
//  AppDelegate.m
//  Etravel
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 邓程. All rights reserved.
//

#import "AppDelegate.h"
#import "HttpUrlHeader.h"
#import <MAMapKit/MAMapKit.h>
#import "LeftSortsViewController.h"
#import "TravelNotesController.h"

#import "TravelSightsController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [MAMapServices sharedServices].apiKey = mapKey;
    
    TravelNotesController *mainVC = [[TravelNotesController alloc] initWithStyle:(UITableViewStylePlain)];
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    self.window.rootViewController = self.LeftSlideVC;
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBarTintColor:[UIColor colorWithRed:189/255.0 green:215/255.0 blue:255/255.0 alpha:1]];
    [appearance setTintColor:[UIColor blackColor]];
    // 设置导航条的title文字颜色，在iOS7才这么用
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor blackColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:20], NSFontAttributeName, nil]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    

   
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
