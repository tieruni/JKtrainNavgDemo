//
//  ListLoader.h
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/4.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ListModel;

typedef void (^ListloaderBlock)(BOOL success, NSArray<ListModel *>* _Nonnull outArr);

NS_ASSUME_NONNULL_BEGIN

@interface ListLoader : NSObject

- (void)loadListDataFinishBlock:(ListloaderBlock)finishBlock;


@end

NS_ASSUME_NONNULL_END
