//
//  Vidioplayer.m
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/6.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "Vidioplayer.h"

@implementation Vidioplayer

+ (Vidioplayer *)sharemanagerPlayer{
    static Vidioplayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[Vidioplayer alloc] init];
    });
    return player;
}

- (void)playVidioWithUrl:(NSString *)vidioUrl attachView:(UIView *)attachView{
  
    [self stopPlayEnd];
    
//    NSURL *Url = [NSURL URLWithString:vidioUrl];//链接的形式
    NSURL *Url = [NSURL fileURLWithPath:vidioUrl];//本地文件的形式
    
    AVAsset *asset= [AVAsset assetWithURL:Url];
    
    _vidioItem = [AVPlayerItem playerItemWithAsset:asset];
    //KVO
    //对状态的监听
    [_vidioItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //对缓冲的监听
    [_vidioItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    CMTime cmtime = _vidioItem.duration;
    CGFloat time = CMTimeGetSeconds(cmtime);
    
    _avplayer = [AVPlayer playerWithPlayerItem:_vidioItem];
    
//    AVPlayer *avplayer = [AVPlayer playerWithURL:vidioUrl];
    [_avplayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
    }];
    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avplayer];
    _playerLayer.frame = attachView.bounds;
    _playerLayer.videoGravity = AVLayerVideoGravityResize;//使layer铺满

    [attachView.layer addSublayer:_playerLayer];
    
    //KVO
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    NSLog(@"");
}


//播放完移除出去
- (void)stopPlayEnd{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_vidioItem removeObserver:self forKeyPath:@"status" context:nil];
    [_vidioItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    
    [_playerLayer removeFromSuperlayer];
    _vidioItem = nil;
    _avplayer = nil;
    NSLog(@"");
    

}

- (void)dealloc{

}

- (void)handlePlay{
    //循环播放
    [_avplayer seekToTime:CMTimeMake(0, 1)];
    [_avplayer play];
}

//KVO-可根据状态进行重复播放等操作
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerStatusReadyToPlay) {
            [_avplayer play];
        }
        else{
            NSLog(@"加载失败");
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        //缓冲
        NSLog(@"%@",[change objectForKey:NSKeyValueChangeNewKey]);
    }
    
    
}

@end
