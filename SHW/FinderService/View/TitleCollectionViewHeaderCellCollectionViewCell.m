//
//  TitleCollectionViewHeaderCellCollectionViewCell.m
//  SlideChooseMenu
//
//  Created by JacobKong on 15/11/29.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import "TitleCollectionViewHeaderCellCollectionViewCell.h"

@implementation TitleCollectionViewHeaderCellCollectionViewCell
- (instancetype)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"TitleCollectionViewHeaderCell" owner:nil options:nil]lastObject];
    
    self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.8,  40);
    return self;
}

+ (UINib *)nib{
    return [UINib nibWithNibName:@"TitleCollectionViewHeaderCell" bundle:nil];
}

@end
