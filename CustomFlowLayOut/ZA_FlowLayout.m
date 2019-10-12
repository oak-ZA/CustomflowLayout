//
//  ZA_FlowLayout.m
//  CustomFlowLayOut
//
//  Created by 张奥 on 2019/10/12.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "ZA_FlowLayout.h"

@implementation ZA_FlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat space = (self.collectionView.bounds.size.width - self.itemSize.width)/2;
    self.sectionInset = UIEdgeInsetsMake(0, space, 0, space);
}


- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{// 设置cell尺寸 => UICollectionViewLayoutAttributes
    // 越靠近中心点,距离越小,缩放越大
    // 求cell与中心点距离
    
    // 1.获取当前显示cell的布局
    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        //2计算到中心的距离
        CGFloat dinstance = fabs((attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width * 0.5);
        //3.计算比例
        CGFloat scale = 1 -  dinstance / (self.collectionView.bounds.size.width * 0.5 ) * 0.25;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    return attrs;
}


// 什么时候调用:用户手指一松开就会调用
// 作用:确定最终偏移量
// 定位:距离中心点越近,这个cell最终展示到中心点

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
    // 最终偏移量
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    // 0.获取最终显示的区域
    CGRect targetRect = CGRectMake(targetP.x, 0, collectionW, MAXFLOAT);
    // 1.获取最终显示的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    
    // 计算获取最小间距
    CGFloat minDelta = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attr in attrs)
    {
        CGFloat distance = attr.center.x - targetP.x - self.collectionView.bounds.size.width * 0.5;
        if (fabs(distance) < fabs(minDelta)) {
            minDelta = distance ;
        }
    }
    //移动距离
    targetP.x += minDelta;
    
    if (targetP.x < 0) {
        targetP.x = 0;
    }
    
    NSLog(@"%f",targetP.x);
    return targetP;
}

// Invalidate:刷新
// 在滚动的时候是否允许刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
// 计算collectionView滚动范围

- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

@end
