//
//  WKDetailViewController.m
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/4.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "WKDetailViewController.h"
#import <WebKit/WebKit.h>

@interface WKDetailViewController ()<WKNavigationDelegate>
@property(nonatomic, strong, readwrite) WKWebView *wkwebV;
@property(nonatomic, strong) UIProgressView *progressV;
@property(nonatomic, strong) NSString *detailUrl;
@end

@implementation WKDetailViewController

-(instancetype)initWithDetailUrlString:(NSString *)urlstr{
    self = [super init];
    if (self) {
        self.detailUrl = urlstr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    [self.view addSubview:({
        self.wkwebV = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height-88)];
        self.wkwebV.navigationDelegate = self;
        self.wkwebV;
    })];
    
    [self.view addSubview:({
        self.progressV = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, 20)];
        self.progressV.tintColor = [UIColor redColor];
        self.progressV;
    })];
    
    [self.wkwebV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];
    //添加观察者
    [self.wkwebV addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    self.progressV.progress = self.wkwebV.estimatedProgress;
}

- (void)dealloc{
    [self.wkwebV removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
