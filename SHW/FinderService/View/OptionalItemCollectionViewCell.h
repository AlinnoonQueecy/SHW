//
//  OptionalItemCollectionViewCell.h
//  SlideChooseMenu
//
//  Created by JacobKong on 15/11/28.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OptionalItemCollectionViewCell;
@protocol OptionalItemCollectionViewCellDelegate <NSObject>

@optional

- (void)didClickedTheCell:(OptionalItemCollectionViewCell *)cellBtn;

@end

@interface OptionalItemCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIButton *cellBtn;
@property (weak, nonatomic) id<OptionalItemCollectionViewCellDelegate> delegate;
@end
