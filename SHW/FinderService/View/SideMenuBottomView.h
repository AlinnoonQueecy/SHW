//
//  SideMenuBottomView.h
//  SlideChooseMenu
//
//  Created by JacobKong on 15/11/29.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideMenuBottomViewDelegate <NSObject>

@optional
- (void)resetButtonDidClicked;
- (void)confirmButtonDidClicked;
@end
@interface SideMenuBottomView : UIView
- (instancetype)init;
@property (weak, nonatomic) id<SideMenuBottomViewDelegate> delegate;
@end
