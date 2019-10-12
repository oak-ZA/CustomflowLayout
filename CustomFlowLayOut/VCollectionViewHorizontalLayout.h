//
//  VCollectionViewHorizontalLayout.h
//  activityentrance
//
//  Created by huangbolun on 2018/5/29.
//  Copyright © 2018年 huiian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCollectionViewHorizontalLayout : UICollectionViewFlowLayout

// 一行中 cell的个数
@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;

@end
