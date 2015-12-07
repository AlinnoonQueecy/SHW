//
//  TitleCollectionViewHeaderCellCollectionViewCell.h
//  SlideChooseMenu
//
//  Created by JacobKong on 15/11/29.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCollectionViewHeaderCellCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;
- (instancetype)init;
+ (UINib *)nib;
@end
