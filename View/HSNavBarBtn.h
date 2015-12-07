//
//  HSNavBarBtn.h
//  HousekeepingServer
//
//  Created by Jacob on 15/9/21.
//  Copyright (c) 2015年 com.jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSNavBarBtn;
@interface HSNavBarBtn : UIButton
+ (HSNavBarBtn *)navBarBtnWithTitle:(NSString *)title;
+ (HSNavBarBtn *)navBarBtnWithBgImage:(NSString *)image;
+ (HSNavBarBtn *)navBarBtnWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage;
+ (HSNavBarBtn *)navBarBtnWithTitle:(NSString *)title image:(NSString *)image highlightedImage:(NSString *)highlightedImage;
+ (HSNavBarBtn *)navBarBtnWithTitle:(NSString *)title image:(NSString *)image highlightedImage:(NSString *)highlightedImage selectedImage:(NSString *)selectedImage;

@end
