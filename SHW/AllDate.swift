//
//  SampleDate.swift
//  生活网
//
//  Created by Zhang on 15/5/17.
//  Copyright (c) 2015年 Zhang. All rights reserved.
//

import Foundation
struct HttpData {
 
    static let  http  = "http://219.216.65.182:8080"
   // static let  http  = "http://192.168.1.105:8080"
    
    static var  customerid:String = ""
    static var  loginpassword:String = ""
    static var  salary = "0"
    static let  imgArray:[String] = ["tp1","tp2","tp3","tp4"]
    static let titleArray:[String] = ["交付仪式","开幕式","启动仪式","宣传月活动"]
    static let label1term:[String] = ["月嫂","清洁","护理","看护","保姆"]
    static let  label2term:[String] = ["保洁服务","保姆服务","月嫂服务","催乳师","管家","钟点工"]
    static let Item:[String] = ["保姆","清洁","月嫂","看护","小时工","公司保洁","99洗护","高级管家","育婴高教","保姆","清洁","月嫂","看护","小时工","公司保洁","钟点"]
    static var maintwo:[String] = ["家政","搬运服务","洗染服务","礼仪庆典","美容美体","人像摄影","居家养老","维修服务","法律援助"]
    static let grayColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
     static let orangeColor = UIColor(red: 234/255, green: 103/255, blue: 7/255, alpha: 1.0)
    
   //正则表达式
   static  let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"//邮箱
   static  let phoneRegex = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"//13/15/18开头的手机号码
   static let passWordRegex =  "^[a-zA-Z0-9]{6,20}+$" //密码：6-20位的字母加数字
   static let IDcardRegex =  "^(\\d{14}|\\d{17})(\\d|[xX])$"//身份证号码验证
   static let userNameRegex = "^[A-Za-z0-9]{6,20}+$"//用户名：6-20位的字母加数字
    
}


