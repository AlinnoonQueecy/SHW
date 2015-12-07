//
//  zeng.swift
//  SHW
//
//  Created by Zhang on 15/11/10.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation


 
    
    //正则表达式
//    static
//    static  let phoneRegex = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"//13/15/18开头的手机号码
//
//    static let IDcardRegex =  "^(\\d{14}|\\d{17})(\\d|[xX])$"//身份证号码验证
//

 

//正则表达式的验证
func Match (input:String,matches:String) ->Bool {
    if let match = input.rangeOfString(matches, options: .RegularExpressionSearch){
        return true
    }else{
        return false
    }
    
}
/**
*  验证是否用户密码6-20位数字和字母组合
*/
func verifyPassword (input:String) ->Bool {
    
     let userNameRegex = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}"//用户名：6-20位的字母加数字
    if let match = input.rangeOfString(userNameRegex, options: .RegularExpressionSearch){
         println("match\(match)")
        return true
    }else{
        return false
    }
    
}
/**
*  验证手机号码是否格式正确
*/
func  verifymobilePhone(input:String) ->Bool  {
    /**
    * 手机号码
    * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    * 联通：130,131,132,152,155,156,185,186
    * 电信：133,1349,153,180,189
    */
   var  MOBILE = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
    10         * 中国移动：China Mobile
    11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    12         */
    var  CM =  "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
    15         * 中国联通：China Unicom
    16         * 130,131,132,152,155,156,185,186
    17         */
    var   CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
    20         * 中国电信：China Telecom
    21         * 133,1349,153,180,189
    22         */
    var  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
    25         * 大陆地区固话及小灵通
    26         * 区号：010,020,021,022,023,024,025,027,028,029
    27         * 号码：七位或八位
    28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    let matchMOBILE = input.rangeOfString(MOBILE, options: .RegularExpressionSearch)
    let matchCM = input.rangeOfString(CM, options: .RegularExpressionSearch)
    let matchCU = input.rangeOfString(CU, options: .RegularExpressionSearch)
    let matchCT = input.rangeOfString(CT, options: .RegularExpressionSearch)
    
//    if ((matchMOBILE == true)||(matchCM == true)||(matchCU == true)||(matchCT == true))
    if  (matchMOBILE != nil ) ||  (matchCU != nil ) || (matchCM != nil ) || (matchCT != nil )
    {
        println("matchMOBILE\(matchMOBILE)")
        return true ;
    }
    else
    {
        return false;
    }
}
/**
*  验证座机号码
*/
func verifyPhoneNo(input:String) ->Bool {
    
    let PhoneNo = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
    
    if let match = input.rangeOfString(PhoneNo, options: .RegularExpressionSearch){
        return true
    }else{
        return false
    }
    
}
/**
*  验证邮箱
*/
func verifyEmail(input:String) ->Bool {
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"//邮箱
 
    if let match = input.rangeOfString(emailRegex, options: .RegularExpressionSearch){
        return true
    }else{
        return false
    }
    
}
//
//class RegexHelper{
//    
// 
//      let  regex:NSRegularExpression
//    
//    init(pattern:String){
//        
//        var error:NSError?
//        regex = NSRegularExpression(pattern:pattern , options: NSRegularExpressionOptions.CaseInsensitive, error: &error)!
//       }
//    
//    func match (input:String) -> Bool{
//         //let matches = regex.matchesInString(input, options: nil, range: NSRange(location: 0,length: count(input)))
//         let matches = regex.matchesInString(input, options: nil, range:NSMakeRange(0,count(input)))
//         return matches.count > 0
//        
//        }
//
//}
//
//
//infix operator =~ {
//
//}
//func =~ (input:String,pattern:String ) ->Bool{
//   return RegexHelper(pattern:pattern).match(input)
//
//}
//func rangeOfString(aString: String!,options mask: NSStringCompareOptions) -> NSRange {
//    return NSRange()
//}


