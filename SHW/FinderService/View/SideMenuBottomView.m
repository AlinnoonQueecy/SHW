//
//  SideMenuBottomView.m
//  SlideChooseMenu
//
//  Created by JacobKong on 15/11/29.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import "SideMenuBottomView.h"

@interface SideMenuBottomView ()
- (IBAction)resetButtonClicked:(id)sender;

- (IBAction)confirmButtonClicked:(id)sender;

@end

@implementation SideMenuBottomView

- (instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"SideMenuBottomView" owner:self options:nil]lastObject];
    
    return self;
}
- (IBAction)resetButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(resetButtonDidClicked)]) {
        [self.delegate resetButtonDidClicked];
    }
}

- (IBAction)confirmButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(confirmButtonDidClicked)]) {
        [self.delegate confirmButtonDidClicked];
    }
}
@end
