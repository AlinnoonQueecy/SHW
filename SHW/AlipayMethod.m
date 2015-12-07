//
//  AlipayMethod.m
//  AliSDKDemo
//
//  Created by 张迪 on 15/8/16.
//  Copyright (c) 2015年 Alipay.com. All rights reserved.
//

#import "AlipayMethod.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"

@interface AlipayMethod()
@property (nonatomic, assign) BOOL isSuccess;
@end

@implementation AlipayMethod

//- (BOOL)pay:(PayInfo *)product completion:(void(^)(void))completion
+ (void)pay:(PayInfo *)product completion:(void(^)(void))completion;
{
//应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme=@"shenghuowang";
    NSString *callBackUrl=@"http://219.216.65.182:8080/FamilyServiceSystem/MobileAlipayAction";
    NSLog(@"1");
#pragma 以下是配置信息
    //parnter和seller信息配置
    NSString *partner = @"2088021052684251";
    NSString *seller = @"gujiawangluo@163.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOdyTOK+wekYop0K3gYzzoOf8ldbYKasDTugbNLDB/Tokb/3Jr+2PEnMwGVyaqpZD2mkrzajAPJ6SwhdMLXV+NfbSBFWToAomTWiX8nhYGBPtYc+q94FHh/By3Vi+04WLei6zCWzo/2Xvqx1xKKBysiuVcQkbueocfc5bIfb2se3AgMBAAECgYEApLfSRGWit/RSdxXu4dcpGMBSxx0/ch9s44zPJkirdv+2CzsolrRpv9Q68Xg2tbngoD0WffoQiIHEuNUp/5+jExJ/QuM3Vmykq2hzGYfSdbPX7F3BgJSDnV8NIHSNyuL771S6yEIHB+ANNN/MIAQ/V1BXodeStqMbR9MKtdi9WeECQQD1DpEArEP7UfMntcq8DRzB8qGlm5j5M9NMzaG9i4LZXPPgHnUYDfyu24AO46PGSmxrCJlmhDqoBInOetCYjzR/AkEA8cgkj+68w6ZBoLVWFJXEPPiQOtBTU+y/SUFnwLa4igDs2/CzUI97zgrJAi3kPgkB45uTiO0zC6336mt7Pg1wyQJBAKn8FLE2zWFDkzt0atDO96fBOke6Cv6x6FxaN1tXrshAJhrMhcTNzv0r3UR2u2AMt+/24xGtn1J083J61r88dtkCQDw791fgSyiW18y4wGw6b3wdFJmCYvAKkBEo+TcajljbKCcXDSUpydcn+rHPSwhlaBITJSs8pLXpLlU5V6e643kCQBEZ/mkH8lXeBS1XH3nXU2kixhmLBGh65/+2zEsYh++ckAMVNc5fTV/nEm3Eu9Wllc8TOT50IDo0tZj0iJai2ew=";
#pragma 以上是配置信息
    
#pragma 以下不需要修改
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = product.payID;//订单ID
    order.productName = product.payName;////商品标题
   // order.productDescription = product.payBody;////商品描述
    //order.productDescription = @"我是测试的商品描述";
    order.amount = [NSString stringWithFormat:@"%.2f",product.payPrice];////商品价格
 
   //回调URL
    order.notifyURL =  callBackUrl;
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
     NSLog(@"signedString = %@",signedString);
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
      NSLog(@"orderString = %@",orderString);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"result:%@",resultDic);
            NSString *resultStatus = resultDic[@"resultStatus"];
            if ([resultStatus isEqualToString:@"9000"]) {
                completion();
            }else{
                NSLog(@"--------error");
            }
        }];
    }
}

@end
