//
//  HSTabBar.h
//  HousekeepingServer
//
//  Created by Jacob on 15/9/21.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSTabBar;
@class HSTabBarButton;
@protocol HSTabBarDelegate <NSObject>

@optional
- (void)tabBar:(HSTabBar *)tabBar didSelectedFrom:(int)from to:(int)to;

@end
@interface HSTabBar : UIView
@property (weak, nonatomic) id<HSTabBarDelegate> delegate;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
- (void)tabBarBtnDidSelected:(HSTabBarButton *)button;
@end
