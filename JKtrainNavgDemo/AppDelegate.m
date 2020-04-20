//
//  AppDelegate.m
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/4.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "AppDelegate.h"
#import "JKTViewController.h"
#import "NewsViewController.h"
#import "VidioViewController.h"

#import "JkNotification.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UITabBarController *tabVC = [[UITabBarController alloc] init];
    
    JKTViewController *firstVC = [[JKTViewController alloc] init];
    firstVC.view.backgroundColor = [UIColor systemPinkColor];
    firstVC.tabBarItem.title = @"首页";
    firstVC.tabBarItem.image = [UIImage imageNamed:@"icon_shouye_normal"];
    firstVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_shouye_hlight"];


    NewsViewController *secandVC = [[NewsViewController alloc] init];
    secandVC.view.backgroundColor = [UIColor cyanColor];
    secandVC.tabBarItem.title = @"新闻";
    secandVC.tabBarItem.image = [UIImage imageNamed:@"icon_notifac_normal"];
    secandVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_notifac_hlight"];
    
    VidioViewController *thirdVC = [[VidioViewController alloc] init];
    thirdVC.view.backgroundColor = [UIColor magentaColor];
    thirdVC.tabBarItem.title = @"视频";
    thirdVC.tabBarItem.image = [UIImage imageNamed:@"icon_beibao_normal"];
    thirdVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_beibao_hlight"];
    
    UIViewController *fourVC = [[UIViewController alloc] init];
    fourVC.view.backgroundColor = [UIColor purpleColor];
    fourVC.tabBarItem.title = @"推荐";
    fourVC.tabBarItem.image = [UIImage imageNamed:@"icon_more_normal"];
    fourVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_more_hlight"];
    
    UIViewController *fiveVC = [[UIViewController alloc] init];
    fiveVC.view.backgroundColor = [UIColor brownColor];
    fiveVC.tabBarItem.title = @"我的";
    fiveVC.tabBarItem.image = [UIImage imageNamed:@"icon_us_normal"];
    fiveVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_us_hlight"];


    tabVC.viewControllers = @[firstVC,secandVC,thirdVC,fourVC,fiveVC];

    tabVC.delegate = self;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:tabVC];
    
    self.window.rootViewController = navi;

    [self.window makeKeyAndVisible];
    
    
    [[JkNotification notificationManager] checkNotificationAuthorization];
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"你瞅啥");
}

#pragma mark -- APNs远程推送-成功或失败
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"");
}


#pragma mark - UISceneSession lifecycle

//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
