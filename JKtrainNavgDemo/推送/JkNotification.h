//
//  JkNotification.h
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/14.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JkNotification : NSObject

+ (JkNotification *)notificationManager;

- (void)checkNotificationAuthorization;

@end

NS_ASSUME_NONNULL_END
