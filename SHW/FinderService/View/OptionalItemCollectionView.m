//
//  OptionalItemCollectionView.m
//  SlideChooseMenu
//
//  Created by JacobKong on 15/11/28.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import "OptionalItemCollectionView.h"

@implementation OptionalItemCollectionView

- (instancetype)init {
  // 初始化layout
  UICollectionViewFlowLayout *layout =
      [[UICollectionViewFlowLayout alloc] init];

  // 设置itemSize
  CGFloat itemSizeW = 70;
  CGFloat itemSizeH = 30;
  layout.itemSize = CGSizeMake(itemSizeW, itemSizeH);

  // 四周间距
    CGFloat paddingY = 10;
    CGFloat paddingX = ([UIScreen mainScreen].bounds.size.width * 0.8 - itemSizeW * 3) / 4 ;
    layout.sectionInset = UIEdgeInsetsMake(paddingY, paddingX, paddingY, paddingX);
    // 横向按钮间距
    layout.minimumInteritemSpacing = paddingX * 0.5;
    
    //垂直行间距
    layout.minimumLineSpacing = paddingY;
    
    // 滚动方向
  [layout setScrollDirection:UICollectionViewScrollDirectionVertical];

  self = [[OptionalItemCollectionView alloc] initWithFrame:CGRectZero
                                      collectionViewLayout:layout];
    
    self.showsHorizontalScrollIndicator = NO;

  self.backgroundColor = [UIColor whiteColor];
  return self;
}
@end
