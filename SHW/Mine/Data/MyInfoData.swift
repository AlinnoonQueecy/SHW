//
//  MyInfoData.swift
//  SHW
//
//  Created by Zhang on 15/7/29.
//  Copyright (c) 2015年 star. All rights reserved.
//
import Foundation

import UIKit

class MyInfo:NSObject {
    var id:Int
    var customerID:String
    var customerName:String
    var customerGender:String
    var customerBirthday:String
    var idCardNo:String
    
    var phoneNo:String
    var mobilePhone:String
    var emailAddress:String
    var customerProvince:String
    var customerCity:String
    
    var customerCounty:String
    var contactAddress:String
    var qqNumber:String
    var loginPassword:String
    var headPicture: String
    
    init( id:Int,customerID:String,customerName:String,customerGender:String,customerBirthday:String,idCardNo:String,phoneNo:String,mobilePhone:String,emailAddress:String,customerProvince:String,customerCity:String,customerCounty: String,contactAddress:String,qqNumber: String,loginPassword:String,headPicture: String){
        
        self.id = id
        self.customerID = customerID
        self.customerName = customerName
        self.customerGender = customerGender
        self.customerBirthday = customerBirthday
         self.idCardNo = idCardNo
        
        self.phoneNo = phoneNo
        self.mobilePhone = mobilePhone
        self.emailAddress = emailAddress
        self.customerProvince = customerProvince
        self.customerCity = customerCity
        
        self.customerCounty = customerCounty
        self.contactAddress = contactAddress
        self.qqNumber = qqNumber
        self.loginPassword = loginPassword
        self.headPicture = headPicture
        super.init()
    }
    
}

//得到个人信息
func QueryInfo(customerid:String) ->MyInfo  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileCustomerInfoAction?operation=_queryByID")
    
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    var param:String = "{\"customerID\":\"\(customerid)\"}"
    println("customerID:\(customerid)")
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
        println("jsonstring是:\(jsonString)")
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
 
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var MyInfoData:MyInfo!
    var response1:String = test1 as! String
 
    if  response1 == "Success" {
 
       var value: AnyObject?  =  json.objectForKey("data")
  

 
        var  id:Int =  value!.objectForKey("id") as! Int
      
        var customerID:String=value!.objectForKey("customerID") as! String
   
        var customerName:String=value!.objectForKey("customerName") as! String
        var customerGender:String=value!.objectForKey("customerGender") as! String
        var customerBirthday:String=value!.objectForKey("customerBirthday") as! String
        var idCardNo:String=value!.objectForKey("idCardNo") as! String
        
        var phoneNo:String=value!.objectForKey("phoneNo") as! String
        var mobilePhone:String=value!.objectForKey("mobilePhone") as! String
        var emailAddress:String=value!.objectForKey("emailAddress") as! String
        var customerProvince:String=value!.objectForKey("customerProvince") as! String
        var customerCity:String=value!.objectForKey("customerCity") as! String
        
        
        var customerCounty:String=value!.objectForKey("customerCounty") as! String
        var contactAddress:String=value!.objectForKey("contactAddress") as! String
        var qqNumber:String = value!.objectForKey("qqNumber") as! String
        var loginPassword:String = value!.objectForKey("loginPassword") as! String
        var headPicture:String = value!.objectForKey("headPicture") as! String
   
        let obj:MyInfo = MyInfo(id:id,customerID:customerID,customerName:customerName,customerGender:customerGender,customerBirthday:customerBirthday,idCardNo:idCardNo,phoneNo:phoneNo,mobilePhone:mobilePhone,emailAddress:emailAddress,customerProvince:customerProvince,customerCity:customerCity,customerCounty:customerCounty,contactAddress:contactAddress,qqNumber:qqNumber,loginPassword:loginPassword,headPicture:headPicture)
        
        MyInfoData = obj
        println("我的信息\(MyInfoData)")
    }
    return MyInfoData
    
    
}
