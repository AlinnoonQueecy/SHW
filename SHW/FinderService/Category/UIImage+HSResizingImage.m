//
//  UIImage+HSResizingImage.m
//  HousekeepingServer
//
//  Created by Jacob on 15/9/26.
//  Copyright (c) 2015年 com.jacob. All rights reserved.
//

#import "UIImage+HSResizingImage.h"

@implementation UIImage (HSResizingImage)
+ (UIImage *)resizeableImage:(NSString *)name {
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat w =normal.size.width * 0.5;
    CGFloat h =normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}
@end
