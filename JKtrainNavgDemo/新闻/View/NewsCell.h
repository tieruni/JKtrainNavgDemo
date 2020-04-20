//
//  NewsCell.h
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/4.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ListModel;

@interface NewsCell : UITableViewCell

-(void)layoutTabviewCell:(ListModel *)item;

@end

NS_ASSUME_NONNULL_END
