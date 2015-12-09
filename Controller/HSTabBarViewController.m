//
//  HSTabBarViewController.m
//  HousekeepingService
//
//  Created by Jacob on 15/9/19.
//  Copyright (c) 2015年 com.jacob. All rights reserved.
//

#import "HSTabBarViewController.h"

#import "HSTabBar.h"
#import "HSNavigationViewController.h"
#import "UIView+SetFrame.h"


@interface HSTabBarViewController ()
@property (assign, nonatomic)  BOOL isLoadedChildVc;
@end

@implementation HSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加tabbar
    [self setupTabbar];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 删除系统自带的tabberItem
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

/**
 *  设置子控制器的tabbarItem
 */
- (void)addTabBarItemWithViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedimage isWapperedByNavigationController:(BOOL) wappered{
    // 1.设置控制器的属性
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    //vc.view.backgroundColor = [UIColor whiteColor];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 2.包装导航控制器
    if (wappered) {
        HSNavigationViewController *nav = [[HSNavigationViewController alloc]initWithRootViewController:vc];
        [self addChildViewController:nav];
    }else{
        [self addChildViewController:vc];
    }
    
    // 3.添加tabber内部按钮
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
}

/**
 *  添加自定义tabbar
 */
- (void)setupTabbar{
    HSTabBar *customTabBar = [[HSTabBar alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    self.customTabBar = customTabBar;
    self.customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
}

#pragma mark - HSTabBarDelegate
- (void)tabBar:(HSTabBar *)tabBar didSelectedFrom:(int)from to:(int)to{
    self.selectedIndex = to;
}
@end
