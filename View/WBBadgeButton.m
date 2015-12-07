//
//  WBBadgeButton.m
//  WeiBo
//
//  Created by Jacob on 15/9/9.
//  Copyright (c) 2015年 com.jacob. All rights reserved.
//

#import "WBBadgeButton.h"
#import "UIImage+HSResizingImage.h"


@implementation WBBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 取消用户交互
        self.userInteractionEnabled = NO;
        // 设置图片
        [self setBackgroundImage:[UIImage resizeableImage:@"main_badge_os7"] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.hidden = YES;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        
        if (badgeValue.length > 1) {
            // 文字尺寸
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[NSFontAttributeName] = self.titleLabel.font;
            CGSize badgeSize = [badgeValue sizeWithAttributes:dict];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    }else{
        self.hidden = YES;
    }
    
}
@end
