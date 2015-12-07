//
//  HSOrangeButton.m
//  HousekeepingServer
//
//  Created by Jacob on 15/10/4.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import "HSOrangeButton.h"
#import "UIImage+HSResizingImage.h"

@implementation HSOrangeButton
+ (instancetype)orangeButtonWithTitle:(NSString *)title{
    HSOrangeButton *button = [[self alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = (HSOrangeButton *)[UIButton buttonWithType:UIButtonTypeCustom];
        [self setBackgroundImage:[UIImage resizeableImage:@"common_button_orange"]
                             forState:UIControlStateNormal];
        [self
         setBackgroundImage:[UIImage
                             resizeableImage:@"common_button_pressed_orange"]
         forState:UIControlStateHighlighted];
        
    }
    return self;
}
@end
