//
//  RegisterData.swift
//  SHW
//
//  Created by Zhang on 15/12/9.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation
//注册获取验证码
func getCheckCode(phoneNo:String) ->String  {
    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileSendAction?operation=getCheckCode")
    
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

//验证注册验证码
func vetifyRegisterCode(phoneNo:String,checkCode :String) -> String {
    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileSendAction?operation=vetifyCheckCode")
    
    //
    //    var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    //
    //    request.HTTPMethod = "POST"
    //
    //    var param:String = "{\"phoneNo\":\"\(phoneNo)\",\"checkCode\":\"\(checkCode)\",\"flag\":\"login\"}"
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
    //let Response = "Failed"
    let Response = "Success"
    return Response
}

//注册
func registerFunction(customerID:String,mobilePhone:String,loginPassword:String) ->String  {
//    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileCustomerInfoAction?operation=_add")
//    
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    
//    var param:String = "{\"customerID\":\"\(customerID)\",\"mobilePhone\":\"\(mobilePhone)\",\"loginPassword\":\"\(loginPassword)\"}"
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
//    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
//    var serviceresponse: AnyObject?=json.objectForKey("serverResponse")
//    let  Response :String = serviceresponse as! String
   let Response = "Success"
    
    return Response
}



