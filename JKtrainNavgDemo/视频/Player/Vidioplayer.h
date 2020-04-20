//
//  Vidioplayer.h
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/6.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Vidioplayer : NSObject
@property(nonatomic, strong) AVPlayerItem *vidioItem;
@property(nonatomic, strong) AVPlayer *avplayer;
@property(nonatomic, strong) AVPlayerLayer *playerLayer;

+ (Vidioplayer *)sharemanagerPlayer;

- (void)playVidioWithUrl:(NSString *)vidioUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
