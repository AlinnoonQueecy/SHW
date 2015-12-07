//
//  HSNavBarBtn.m
//  HousekeepingServer
//
//  Created by Jacob on 15/9/21.
//  Copyright (c) 2015年 com.jacob. All rights reserved.
//

#import "HSNavBarBtn.h"
#define HSNavBarBtnImageWidth 20
#define HSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation HSNavBarBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:HSColor(135, 135, 135) forState:UIControlStateHighlighted];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY = 0;
    CGFloat imageW = self.currentImage.size.width;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleW = contentRect.size.width - self.currentImage.size.width;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

#pragma mark 创建按钮
+ (HSNavBarBtn *)navBarBtnWithTitle:(NSString *)title{
    HSNavBarBtn *button = [HSNavBarBtn buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+ (HSNavBarBtn *)navBarBtnWithBgImage:(NSString *)image{
    HSNavBarBtn *button = [HSNavBarBtn buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return button;
}

+ (HSNavBarBtn *)navBarBtnWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage{
        HSNavBarBtn *button = [HSNavBarBtn buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    return button;
}

+ (HSNavBarBtn *)navBarBtnWithTitle:(NSString *)title image:(NSString *)image highlightedImage:(NSString *)highlightedImage{
    HSNavBarBtn *button = [HSNavBarBtn buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    return button;
}

+ (HSNavBarBtn *)navBarBtnWithTitle:(NSString *)title image:(NSString *)image highlightedImage:(NSString *)highlightedImage selectedImage:(NSString *)selectedImage{
    HSNavBarBtn *button = [self navBarBtnWithTitle:title image:image highlightedImage:highlightedImage];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return button;
}

@end
