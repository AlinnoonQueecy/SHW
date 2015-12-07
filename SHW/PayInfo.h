//
//  PayInfo.h
//  AliSDKDemo
//
//  Created by 张迪 on 15/8/16.
//  Copyright (c) 2015年 Alipay.com. All rights reserved.
//

/*
    订单信息
 */

#import <Foundation/Foundation.h>

@interface PayInfo : NSObject

//订单号(string)
@property (nonatomic,strong) NSString * payID;
//名称(string)
@property (nonatomic,strong) NSString * payName;
//描述(string)
@property (nonatomic,strong) NSString * payBody;
//价钱(float)
@property (nonatomic, assign) float payPrice;

@end
