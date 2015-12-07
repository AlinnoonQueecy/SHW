//
//  HSNavigationViewController.m
//  HousekeepingServer
//
//  Created by Jacob on 15/9/21.
//  Copyright (c) 2015年 com.jacob. All rights reserved.
//

#import "HSNavigationViewController.h"
#define HSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@interface HSNavigationViewController ()

@end

@implementation HSNavigationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)initialize
{
    // 设置导航栏主题
    [self setupNavBar];
    //设置导航栏的按钮样式
    [self setupNavBarItem];
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBar{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];

    // 设置导航栏字体
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:19 weight:11.0];//出问题1
//    dict[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [navBar setTitleTextAttributes:dict];
    // 设置导航栏颜色
    [navBar setBarTintColor:HSColor(234, 103, 7)];
    // 设置返回按钮颜色
    [navBar setTintColor:[UIColor whiteColor]];
    //设置navigationbar的半透明
    [navBar setTranslucent:NO];//出问题2
//   设置indicator
    [navBar setBackIndicatorImage:[UIImage imageNamed:@"navgation_back_arrow"]];
    [navBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navgation_back_arrow"]];
    
}

/**
 *  设置导航栏的按钮样式
 */
+ (void)setupNavBarItem{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor clearColor];
    textAttrs[NSShadowAttributeName] = shadow;
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    // 去掉返回按钮的文字
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:YES];
}
@end
