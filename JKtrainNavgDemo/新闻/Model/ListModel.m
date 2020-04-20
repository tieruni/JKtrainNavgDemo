//
//  ListModel.m
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/4.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

//序列化
- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.categoty forKey:@"category"];
    [coder encodeObject:self.picUrl forKey:@"thumbnail_pic_s"];
    [coder encodeObject:self.uniqueKey forKey:@"uniquekey"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.authorName forKey:@"author_name"];
    [coder encodeObject:self.articleUrl forKey:@"url"];
    
}

//饭序列化
- (nullable instancetype)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self) {
     self.categoty = [coder decodeObjectForKey:@"category"];
     self.picUrl = [coder decodeObjectForKey:@"thumbnail_pic_s"];
     self.uniqueKey = [coder decodeObjectForKey:@"uniquekey"];
     self.title = [coder decodeObjectForKey:@"title"];
     self.date = [coder decodeObjectForKey:@"date"];
     self.authorName = [coder decodeObjectForKey:@"author_name"];
     self.articleUrl = [coder decodeObjectForKey:@"url"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    
    return YES;
}

- (void)configWithDic:(NSDictionary *)listDic{
#warning 类型是否匹配
    self.categoty = [listDic objectForKey:@"category"];
    self.picUrl = [listDic objectForKey:@"thumbnail_pic_s"];
    self.uniqueKey = [listDic objectForKey:@"uniquekey"];
    self.title = [listDic objectForKey:@"title"];
    self.date = [listDic objectForKey:@"date"];
    self.authorName = [listDic objectForKey:@"author_name"];
    self.articleUrl = [listDic objectForKey:@"url"];
}

@end
