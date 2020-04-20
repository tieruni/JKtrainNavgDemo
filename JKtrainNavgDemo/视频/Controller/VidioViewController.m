
//
//  VidioViewController.m
//  JKtrainNavgDemo
//
//  Created by ZhiF_Zhu on 2020/4/4.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "VidioViewController.h"
#import "JKVidioCoverCell.h"


@interface VidioViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic) UICollectionView *collectionV;

@end

@implementation VidioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)setUI{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width/16*9);
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
//    self.collectionV.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self.collectionV registerClass:[JKVidioCoverCell class] forCellWithReuseIdentifier:@"id"];
    
    [self.view addSubview:self.collectionV];
    
    
}

#pragma mark -- dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JKVidioCoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Sources" ofType:@"bundle"];
    NSString *vidioStr = [bundlePath stringByAppendingPathComponent:@"big_buck_bunny.mp4"];
    
    if ([cell isKindOfClass:[JKVidioCoverCell class]]) {
//        @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        [cell layoutWithVidioCoverUrl:@"http://127.0.0.1/test/gtwehnewsdvajsgdvwah.jpeg" vidioUrl:vidioStr];
    }
    cell.contentView.clipsToBounds = YES;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 1.0;
    return cell;
    
}


#pragma mark -- delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了item");
    
    
}



@end
