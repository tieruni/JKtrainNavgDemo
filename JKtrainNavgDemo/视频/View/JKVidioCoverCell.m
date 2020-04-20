//
//  JKVidioCoverView.m
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/5.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "JKVidioCoverCell.h"
#import "Vidioplayer.h"

@interface JKVidioCoverCell()
@property(nonatomic, strong) UIImageView *coverImgView;
@property(nonatomic, strong) UIButton *playBtn;
@property(nonatomic, strong) NSString *sourceUrl;

@end

@implementation JKVidioCoverCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:({
            _coverImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _coverImgView.userInteractionEnabled = YES;
            _coverImgView;
            
        })];
        
        [_coverImgView addSubview:({
            _playBtn = [[UIButton alloc] init];
            _playBtn.frame = CGRectMake((frame.size.width-50)*0.5, (frame.size.height-50)*0.5, 50, 50);
            _playBtn.layer.borderWidth = 1.0;
            _playBtn.layer.borderColor = [UIColor blackColor].CGColor;
            _playBtn.layer.cornerRadius = _playBtn.bounds.size.width*0.5;
            [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
            [_playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
            _playBtn;
        })];
        
    }
    return self;
}


- (void)layoutWithVidioCoverUrl:(NSString *)vidioCoverUrl vidioUrl:(NSString *)vidioUrl{
//    _coverImgView.image = [UIImage imageNamed:vidioCoverUrl];
    [_coverImgView sd_setImageWithURL:[NSURL URLWithString:vidioCoverUrl]];
    _sourceUrl = vidioUrl;
}


- (void)playAction{
    
    [[Vidioplayer sharemanagerPlayer] playVidioWithUrl:_sourceUrl attachView:_coverImgView];
}

@end
