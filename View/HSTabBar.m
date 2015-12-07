//
//  HSTabBar.m
//  HousekeepingServer
//
//  Created by Jacob on 15/9/21.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import "HSTabBar.h"
#import "HSTabBarButton.h"

@interface HSTabBar ()
@property(weak, nonatomic) HSTabBarButton *selectedBtn;
@end

@implementation HSTabBar
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
      self.backgroundColor = [UIColor whiteColor];
  }
  return self;
}

/**
 *  增加tabbarItem
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
  // 创建按钮
  HSTabBarButton *button = [HSTabBarButton buttonWithType:UIButtonTypeCustom];
  [self addSubview:button];

  // 设置数据
  button.item = item;

  //监听按钮点击
  [button addTarget:self
                action:@selector(tabBarBtnDidSelected:)
      forControlEvents:UIControlEventTouchDown];

  if (self.subviews.count == 1) {
    [self tabBarBtnDidSelected:button];
  }
}

/**
 *  按钮点击触发事件
 */
- (void)tabBarBtnDidSelected:(HSTabBarButton *)button {
  if ([self.delegate
          respondsToSelector:@selector(tabBar:didSelectedFrom:to:)]) {
    [self.delegate tabBar:self
          didSelectedFrom:(int)self.selectedBtn.tag
                       to:(int)button.tag];
  }
  self.selectedBtn.selected = NO;
  button.selected = YES;
  self.selectedBtn = button;
}

/**
 *  设置按钮的frame
 */
- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat buttonW = self.frame.size.width / self.subviews.count;
  CGFloat buttonH = self.frame.size.height;
  CGFloat buttonY = 0;

  for (int i = 0; i < self.subviews.count; i++) {
    HSTabBarButton *button = self.subviews[i];
    CGFloat buttonX = i * buttonW;
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    button.tag = i;
  }
}

@end
