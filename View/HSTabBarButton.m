//
//  HSTabBarButton.m
//  HousekeepingServer
//
//  Created by Jacob on 15/9/21.
//  Copyright (c) 2015年 com.jacob. All rights reserved.
//

#import "HSTabBarButton.h"
#import "WBBadgeButton.h"
#import "M13BadgeView.h"
#define HSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface HSTabBarButton ()
//@property (weak, nonatomic) WBBadgeButton *badgeButton;

@property (weak, nonatomic) WBBadgeButton *badgeButton;

@end

@implementation HSTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:HSColor(234, 103, 7) forState:UIControlStateSelected];
        [self setTitleColor:HSColor(117, 117, 117) forState:UIControlStateNormal];
        
        // 添加一个提醒数字按钮
        WBBadgeButton *badgeBtn = [[WBBadgeButton alloc]init];
        badgeBtn.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeBtn];
        self.badgeButton = badgeBtn;

    }
    
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imgW = self.frame.size.width;
    CGFloat imgH = self.frame.size.height * 0.6;
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    return CGRectMake(imgX, imgY, imgW, imgH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height * 0.4;
    CGFloat titleX = 0;
    CGFloat titleY = self.imageView.frame.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setItem:(UITabBarItem *)item{
    _item = item;
    
    // KVO
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];

    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
}

- (void)dealloc{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置badgeValue
    if (![self.item.badgeValue isEqualToString:@"0"]) {
        self.badgeButton.badgeValue = self.item.badgeValue;
        
        CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
        CGFloat badgeY = 3;
        
        CGRect badgeF = self.badgeButton.frame;
        badgeF.origin.x = badgeX;
        badgeF.origin.y = badgeY;
        
        self.badgeButton.frame = badgeF;
        self.badgeButton.hidden = NO;
    }else{
        self.badgeButton.hidden = YES;
    }
    
}


@end
