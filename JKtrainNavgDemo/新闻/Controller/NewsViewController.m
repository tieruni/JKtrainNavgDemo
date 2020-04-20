//
//  NewsViewController.m
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/4.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "NewsViewController.h"
#import "WKDetailViewController.h"
#import "NewsCell.h"
#import "ListLoader.h"
#import "ListModel.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) UITableView *tableV;
@property(strong,nonatomic) NSArray *dataSource;

@property(nonatomic, strong) ListLoader *listloadder;
@end

@implementation NewsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.listloadder = [[ListLoader alloc] init];
    
    //请求数据
//    __weak typeof(self) weakSelf = self;
//    [self.listloadder loadListDataFinishBlock:^(BOOL success, NSArray<ListModel *> * _Nonnull outArr) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.dataSource = outArr;
//        [strongSelf.tableV reloadData];
//    }];
    
    [self setUI];
}

- (void)setUI{
    self.tableV = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}

#pragma mark -- dataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 20;
    return _dataSource.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
//    cell.textLabel.text = @"主标题";
//    cell.detailTextLabel.text = @"副标题";
    [cell layoutTabviewCell:_dataSource[indexPath.row]];
    return cell;
}

#pragma mark -- delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了Cell");
    
    ListModel *item = _dataSource[indexPath.row];
    WKDetailViewController *detailV = [[WKDetailViewController alloc] initWithDetailUrlString:item.articleUrl];
    [self.navigationController pushViewController:detailV animated:YES];
    
    //保存已点击状态
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniqueKey];
    
    
}

@end



