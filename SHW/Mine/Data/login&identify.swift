//
//  login&identify.swift
//  SHW
//
//  Created by Zhang on 15/12/9.
//  Copyright (c) 2015年 star. All rights reserved.
//
//注意： 验证码平台目前不能用，能用后解除下面的注释
import Foundation
//普通登录
func ordinaryLogin(customerID:String,loginPassword:String) ->String  {
    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileCustomerInfoAction?operation=_login")
    
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    var param:String = "{\"customerID\":\"\(customerID)\",\"loginPassword\":\"\(loginPassword)\"}"
    println("param")
    println(param)
    
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    var serviceresponse: AnyObject?=json.objectForKey("serverResponse")
    var Response :String = serviceresponse as! String
    
    
    return Response
}

//快捷登录获取验证码
func GetQuickCode(phoneNo:String) ->String  {
    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileSendAction?operation=retrievePwd")
    
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    
//    var param:String = "{\"phoneNo\":\"\(phoneNo)\"}"
//    println("param")
//    println(param)
//    
//    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    request.HTTPBody = data;
//    var response:NSURLResponse?
//    var error:NSError?
//    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//    if (error != nil)
//    {
//        println(error?.code)
//        println(error?.description)
//    }
//    else
//    {
//        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//        println(jsonString)
//        
//    }
//    
//    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//    var serviceresponse: AnyObject?=json.objectForKey("serverResponse")
//    let Response :String = serviceresponse as! String
    
    let Response = "Success"
    return Response
}

//验证快捷登录获取验证码
func vetifyCheckCode(phoneNo:String,checkCode :String) -> MyInfo? {
    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileSendAction?operation=vetifyCheckCode")
    
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    
//    var param:String = "{\"phoneNo\":\"\(phoneNo)\",\"checkCode\":\"\(checkCode)\"}"
//    println("param")
//    println(param)
//    
//    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    request.HTTPBody = data;
//    var response:NSURLResponse?
//    var error:NSError?
//    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//    if (error != nil)
//    {
//        println(error?.code)
//        println(error?.description)
//    }
//    else
//    {
//        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//        println(jsonString)
//        
//    }
//    
//    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//    
//    var test1: AnyObject?=json.objectForKey("serverResponse")
     var MyInfoData:MyInfo?
//    var response1:String = test1 as! String
//    
//    if  response1 == "Success" {
//        
//        var value: AnyObject?  =  json.objectForKey("data")
//        var  id:Int =  value!.objectForKey("id") as! Int
//        
//        var customerID:String=value!.objectForKey("customerID") as! String
//        
//        var customerName:String=value!.objectForKey("customerName") as! String
//        var customerGender:String=value!.objectForKey("customerGender") as! String
//        var customerBirthday:String=value!.objectForKey("customerBirthday") as! String
//        var idCardNo:String=value!.objectForKey("idCardNo") as! String
//        
//        var phoneNo:String=value!.objectForKey("phoneNo") as! String
//        var mobilePhone:String=value!.objectForKey("mobilePhone") as! String
//        var emailAddress:String=value!.objectForKey("emailAddress") as! String
//        var customerProvince:String=value!.objectForKey("customerProvince") as! String
//        var customerCity:String=value!.objectForKey("customerCity") as! String
//        
//        
//        var customerCounty:String=value!.objectForKey("customerCounty") as! String
//        var contactAddress:String=value!.objectForKey("contactAddress") as! String
//        var qqNumber:String = value!.objectForKey("qqNumber") as! String
//        var loginPassword:String = value!.objectForKey("loginPassword") as! String
//        var headPicture:String = value!.objectForKey("headPicture") as! String
//        
//        let obj:MyInfo = MyInfo(id:id,customerID:customerID,customerName:customerName,customerGender:customerGender,customerBirthday:customerBirthday,idCardNo:idCardNo,phoneNo:phoneNo,mobilePhone:mobilePhone,emailAddress:emailAddress,customerProvince:customerProvince,customerCity:customerCity,customerCounty:customerCounty,contactAddress:contactAddress,qqNumber:qqNumber,loginPassword:loginPassword,headPicture:headPicture)
//
//        MyInfoData = obj
//    }else {
//        
//         MyInfoData = nil
//        
//    }
    
    
     MyInfoData  = nil
    println("MyInfoData\(MyInfoData)")
    return MyInfoData
    
    
 }




