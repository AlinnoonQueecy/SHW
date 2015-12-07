//
//  OptionalItemCollectionViewCell.m
//  SlideChooseMenu
//
//  Created by JacobKong on 15/11/28.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import "OptionalItemCollectionViewCell.h"
#import "UIImage+HSResizingImage.h"

@implementation OptionalItemCollectionViewCell
- (UIButton *)cellBtn{
    if (!_cellBtn) {
        _cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cellBtn setBackgroundImage:[UIImage resizeableImage:@"choosed_btn"] forState:UIControlStateNormal];
        [_cellBtn setBackgroundImage:[UIImage resizeableImage:@"choose_btn_highlighted"] forState:UIControlStateSelected];
        [_cellBtn setBackgroundImage:[UIImage resizeableImage:@"choosed_btn_highlighted"] forState:UIControlStateHighlighted];
        [_cellBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cellBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_cellBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _cellBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cellBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _cellBtn.titleLabel.numberOfLines = 0;
    }
    return _cellBtn;
}
/**
 *  初始化cell
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.cellBtn];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellBtnW = 75;
    CGFloat cellBtnH = 30;
    self.cellBtn.center = self.contentView.center;
    self.cellBtn.bounds = CGRectMake(0, 0, cellBtnW, cellBtnH);
}


@end
