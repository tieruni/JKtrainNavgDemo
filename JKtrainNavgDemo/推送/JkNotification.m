//
//  JkNotification.m
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/14.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "JkNotification.h"
#import <UserNotifications/UserNotifications.h>


@interface JkNotification()<UNUserNotificationCenterDelegate>

@end

@implementation JkNotification

+ (JkNotification *)notificationManager{
    static JkNotification *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JkNotification alloc] init];
    });
    return manager;
}

- (void)checkNotificationAuthorization{
    //铃声，声音，横幅
    UNUserNotificationCenter *Noticenter = [UNUserNotificationCenter currentNotificationCenter];
    Noticenter.delegate = self;
    
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"铃声，声音，横幅");
        if (granted) {
//            //本地oush
//            [self pushNotification];
            //远程push
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            });
        }
    }];
}

#pragma mark -- 本地推送
- (void)pushNotification{
    UNMutableNotificationContent *Noticontent = [[UNMutableNotificationContent alloc] init];
    Noticontent.badge = @(10)
    ;
    Noticontent.title = @"jsdkugoewjg";
    Noticontent.body = @"esgesry";
    UNTimeIntervalNotificationTrigger *Notitrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2.0f repeats:NO];
    UNNotificationRequest *Notirequest = [UNNotificationRequest requestWithIdentifier:@"pushNotification" content:Noticontent trigger:Notitrigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:Notirequest withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"本地推送失败");
    }];
}

#pragma mark -- delegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    completionHandler(UNNotificationPresentationOptionAlert);
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    //点击弹窗处理业务逻辑
    completionHandler();
}


@end
