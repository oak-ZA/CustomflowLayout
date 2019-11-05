//
//  ViewController.m
//  CustomFlowLayOut
//
//  Created by 张奥 on 2019/10/12.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "ViewController.h"
#import "ZA_FlowLayout.h"
#import "ZA_OtherFlowLayout.h"
#import "CustomCollectionViewCell.h"
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    NSArray        *_datas;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _datas = @[@"1",@"2",@"3",@"4"];
    ZA_OtherFlowLayout *layOut = [[ZA_OtherFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_Width, 270) collectionViewLayout:layOut];
    collectionView.delegate = self;
    collectionView.dataSource = self;
//    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.backgroundColor = [UIColor blueColor];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CustomCollectionViewCell class])];
    [self.view addSubview:collectionView];
}

#pragma mark -- UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datas.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CustomCollectionViewCell class]) forIndexPath:indexPath];
    cell.backImageView.image = [UIImage imageNamed:_datas[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
