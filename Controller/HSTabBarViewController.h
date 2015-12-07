//
//  HSTabBarViewController.h
//  HousekeepingService
//
//  Created by Jacob on 15/9/19.
//  Copyright (c) 2015年 com.jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSTabBar.h"
#import "HSNavigationViewController.h"
#import "UIView+SetFrame.h"
@class HSTabBar;
@interface HSTabBarViewController : UITabBarController
@property (weak, nonatomic) HSTabBar *customTabBar;
- (void)setupChildViewController;
- (void)addTabBarItemWithViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedimage isWapperedByNavigationController:(BOOL) wappered;
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
@end
