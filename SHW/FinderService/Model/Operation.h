//
//  Operation.h
//  SlideChooseMenu
//
//  Created by JacobKong on 15/11/29.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operation : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *whereStr;
@property (assign, nonatomic, getter=isSelected)  BOOL selected;
//@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic)  NSInteger section;
@property (assign, nonatomic)  NSInteger item;

@end
