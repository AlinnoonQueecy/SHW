//
//  NSString+URL.m
//  NSString+URL
//
//  Created by Zhang on 15/9/17.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

#import "NSString+URL.h"



@implementation NSString (URL)

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
 
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}
@end
