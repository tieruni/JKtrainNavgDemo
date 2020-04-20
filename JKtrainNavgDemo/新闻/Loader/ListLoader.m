//
//  ListLoader.m
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/4.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "ListLoader.h"
#import "ListModel.h"

@implementation ListLoader

- (void)loadListDataFinishBlock:(ListloaderBlock)finishBlock{
    
    //判断本地时候已经存有数据
    NSArray <ListModel *>* listData =  [self readDataForLocaled];
    if (listData) {
        //展示已有的数据
        finishBlock(YES,listData);
    }
    
    NSString *listUrl = @"https://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";

//    NSString *listUrl = @"http://127.0.0.1/test/awy4hwfghfsdhjersygawet.jpeg";
    NSURL *url = [NSURL URLWithString:listUrl];
    
//    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"网络开小差了!");
//        }else{
//
//        }
        NSError *jsonerror;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonerror];
        
        NSArray *dataArr = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSDictionary *info in dataArr) {
            ListModel *md = [[ListModel alloc] init];
            [md configWithDic:info];
            [mutArr addObject:md];
        }
        //序列化存储
        [weakSelf archivelistDataWithArray:mutArr.copy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
             if (finishBlock) {
                       finishBlock(error == nil,mutArr.copy);
                   }
        });
        
    }];
    
    [dataTask resume];
    
    NSLog(@"%@",dataTask);
    

}

//- (void)AFNloadData{
//    [[AFHTTPSessionManager manager] GET:@"http://127.0.0.1/test/awy4hwfghfsdhjersygawet.jpeg" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败");
//    }];
//}

#pragma mark -- 私有方法
//如果为已读状态，存储到本地
- (NSArray <ListModel *>*)readDataForLocaled{
    
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachepath = [pathArr firstObject];
    NSString *listDataPath = [cachepath stringByAppendingPathComponent:@"ZFData/list"];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    NSData *readListData = [filemanager contentsAtPath:listDataPath];
    
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[ListModel class], nil] fromData:readListData error:nil];

    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray <ListModel *>*)unarchiveObj;
    }
    return nil;
}

//沙盒访问
- (void)archivelistDataWithArray:(NSArray<ListModel *>*)array{
    
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachepath = [pathArr firstObject];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    //创建文件夹
    NSString *datapath = [cachepath stringByAppendingPathComponent:@"ZFData"];
    NSError *createrror;
    [filemanager createDirectoryAtPath:datapath withIntermediateDirectories:YES attributes:nil error:&createrror];
    //创建文件
    NSString *listDataPath = [datapath stringByAppendingPathComponent:@"list"];
//    NSData *listData = [@"zf666" dataUsingEncoding:NSUTF8StringEncoding];
//    [filemanager createFileAtPath:listDataPath contents:listData attributes:nil];
    
    //序列化一下上边存储的array,之后将其写入文件中
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [filemanager createFileAtPath:listDataPath contents:listData attributes:nil];
    
    
//    //反序列化-读取文件
//    NSData *readListData = [filemanager contentsAtPath:listDataPath];
//    
//    //存储数据-磁盘
//    [[NSUserDefaults standardUserDefaults] setObject:readListData forKey:@"listData"];
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"listData"];
//    
//    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[ListModel class], nil] fromData:data error:nil];
//    
//
//    NSLog(@"");

    /*
    //查找文件
    BOOL fileExist = [filemanager fileExistsAtPath:listDataPath];
    
    //删除
    if (fileExist) {
        [filemanager removeItemAtPath:listDataPath error:nil];
    }
    
    NSFileHandle *filehandle = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
    [filehandle seekToEndOfFile];//调整到文本末尾
    [filehandle writeData:[@"fff" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //如果对实时数据要求不是特别高的话，下面两句可以不做
    [filehandle synchronizeFile];//刷新
    [filehandle closeFile];
    */
}

@end
