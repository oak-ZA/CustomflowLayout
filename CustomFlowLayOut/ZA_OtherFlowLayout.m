//
//  ZA_OtherFlowLayout.m
//  CustomFlowLayOut
//
//  Created by 张奥 on 2019/11/5.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "ZA_OtherFlowLayout.h"
//最小的大小比例
#define MIN_SCALE  0.55
@implementation ZA_OtherFlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    //设置偏移方式(水平)
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置item的大小
    CGFloat space = 80;
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width - space*2 , self.collectionView.frame.size.height);
    //设置cell的间隙
    //偏移
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width)/2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    //列间隙
    self.minimumLineSpacing = -self.itemSize.width/2;
    
}
//允许item实时刷新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
//重新设置item的属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    //拿到items
    NSArray *items = [super layoutAttributesForElementsInRect:rect];
    //计算出偏移的中心点
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    static NSInteger currentItem = 0;
    for (UICollectionViewLayoutAttributes *attrs in items) {
        //item 距离需要偏移的中心点的距离
        CGFloat delta = ABS(centerX - attrs.center.x);
        //滑动过程中计算缩放比例
        CGFloat t = delta/(self.collectionView.frame.size.width/2);
        CGFloat scale =  MIN_SCALE + (1-MIN_SCALE)*(1-t);
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        
        if (delta<10&&currentItem!=attrs.indexPath.item) {
            currentItem = attrs.indexPath.item;
        }
      }
    //解决视图被盖住问题
       for (UICollectionViewLayoutAttributes *attrs in items) {
            //设置层叠状态，中间的zIndex为0，越远的越小，越靠后
            attrs.zIndex =-1*ABS(attrs.indexPath.item - currentItem);
      }
    return items;
}
//最后停止后要让item滑动到中心点
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat minDetal = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDetal) > ABS(attrs.center.x - centerX)) {
            minDetal = attrs.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + minDetal, proposedContentOffset.y);
}
@end
