//
//  AppDelegate.m
//  GameHelper
//
//  Created by quentin on 2017/4/7.
//  Copyright © 2017年 Quentin. All rights reserved.
//

#import "AppDelegate.h"
#import <QBFramework_IOS/QBFrameworkLib.h>
#import "GHHomeViewController.h"
#import "GHVideoHomeViewController.h"
#import "GHTaskHomeViewController.h"
#import "GHExploreHomeViewController.h"
#import <BmobSDK/Bmob.h>

// talkingdata
#define kTalkingDataKey @"2D761A5AFA42473F826ED767BF5074EA"

// bmob
#define kBmobAppKey     @"beab7e7170a7928ef335cda6f966f9f5"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WifiAvailableNotification:) name:WifiAvailableNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WifiAvailableNotification:) name:WwanAavailableNotification object:nil];
    [[QBGlobal sharedInstance] startNetworkNotifer];


    [QBManagerConfig sharedConfig].analyticsAppKey = kTalkingDataKey;
    [QBSystem startAnalytics];
    
    // bmob
    [Bmob registerWithAppKey:kBmobAppKey];
    
    // 首页
    GHHomeViewController *viewCtrl1 = [[GHHomeViewController alloc] init];
    viewCtrl1.title = @"首页";
    UINavigationController *navCtrl1 = [[UINavigationController alloc] initWithRootViewController:viewCtrl1];
    
    // Video
    GHVideoHomeViewController *viewCtrl2 = [[GHVideoHomeViewController alloc] init];
    viewCtrl2.title = @"视频";
    UINavigationController *navCtrl2 = [[UINavigationController alloc] initWithRootViewController:viewCtrl2];
    
    // 攻略
    GHTaskHomeViewController *viewCtrl3 = [[GHTaskHomeViewController alloc] init];
    viewCtrl3.title = @"攻略";
    UINavigationController *navCtrl3 = [[UINavigationController alloc] initWithRootViewController:viewCtrl3];
    
    // 探索
    GHExploreHomeViewController *viewCtrl4 = [[GHExploreHomeViewController alloc] init];
    viewCtrl4.title = @"探索";
    UINavigationController *navCtrl4 = [[UINavigationController alloc] initWithRootViewController:viewCtrl4];
    
    UITabBarController *tabCtrl = [[UITabBarController alloc] init];
    tabCtrl.viewControllers = @[navCtrl1, navCtrl2, navCtrl3, navCtrl4];
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabCtrl;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)WifiAvailableNotification:(NSNotification *)notification
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [Bmob activateSDK];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
