//
//  ListModel.h
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/4.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel : NSObject<NSSecureCoding>
@property(nonatomic, strong) NSString *categoty;
@property(nonatomic, strong) NSString *picUrl;
@property(nonatomic, strong) NSString *uniqueKey;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) NSString *authorName;
@property(nonatomic, strong) NSString *articleUrl;

- (void)configWithDic:(NSDictionary *)listDic;

@end

NS_ASSUME_NONNULL_END
