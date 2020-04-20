//
//  TodayViewController.m
//  JKExtenxion
//
//  Created by ZhiF_Zhu on 2020/4/14.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>


@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        [btn setTitle:@"点击" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(weuwagaiwleg) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
    
    //数据共享
    NSUserDefaults *userdef = [[NSUserDefaults alloc] initWithSuiteName:@"com.xxx.xxx"];
//    [userdef setObject:@"从0开始" forKey:@"title"];
    [userdef objectForKey:@"title"];
    
}

-(void)weuwagaiwleg{
    NSLog(@"跳转");
    [self.extensionContext openURL:[NSURL URLWithString:@""] completionHandler:^(BOOL success) {
        NSLog(@"跳转成功");
    }];
}


- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
