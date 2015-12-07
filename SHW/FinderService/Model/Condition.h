//
//  Condition.h
//  SlideChooseMenu
//
//  Created by JacobKong on 15/11/29.
//  Copyright © 2015年 com.jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Condition : NSObject
@property (assign, nonatomic)  BOOL isAvaliable;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *operations;
@end
