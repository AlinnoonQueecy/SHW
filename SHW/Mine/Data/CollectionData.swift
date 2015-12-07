//
//  CollectionData.swift
//  SHW
//
//  Created by Zhang on 15/7/18.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation

import UIKit
//
//var selectInfo:String?
class CollectionInfo:NSObject {
    var id :Int
    var facilitatorName:String
    //var companyName :String
    var facilitatorID:String
    var officePhone:String
    
    var qqNumber:String
    var contactPhone:String
    var facilitatorProvince:String
    var facilitatorCity:String
    var facilitatorCounty:String
    
    var emailAddress:String
    var contactAddress:String
    var registerTime: String
    var facilitatorLevel:Int
    var creditScore:String
    //    var scoreImg:Int
    //    var levelImg:Int
    
    var facilitatorIntro: String
    var facilitatorLogo:String
    var facilitatorStatus:String
    var serviceCount: Int
    
    init( id:Int,facilitatorName:String,facilitatorID:String,officePhone:String,qqNumber:String,contactPhone:String,facilitatorProvince:String,facilitatorCity:String,facilitatorCounty:String,emailAddress:String,contactAddress:String,registerTime: String,facilitatorLevel:Int,creditScore:String ,
        facilitatorIntro: String,facilitatorLogo:String,facilitatorStatus:String,serviceCount: Int){
            self.id = id
            self.facilitatorName = facilitatorName
            //self.companyName = companyName
            self.facilitatorID = facilitatorID
            self.officePhone = officePhone
            
            self.qqNumber = qqNumber
            self.contactPhone = contactPhone
            self.facilitatorProvince = facilitatorProvince
            self.facilitatorCity = facilitatorCity
            self.facilitatorCounty = facilitatorCounty
            
            self.emailAddress = emailAddress
            self.contactAddress = contactAddress
            self.registerTime = registerTime
            self.facilitatorLevel = facilitatorLevel
            self.creditScore = creditScore
            
            self.facilitatorIntro = facilitatorIntro
            self.facilitatorLogo = facilitatorLogo
            self.facilitatorStatus = facilitatorStatus
            self.serviceCount = serviceCount
            
            super.init()
    }
    
}

//收藏的商家
func refreshFCollection(customerID:String,serviceType:String,attributeName:String,upDown:String) ->[facilitatorInfo]  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_query")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"customerID\":\"\(customerID)\",\"serviceType\":\"\(serviceType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\"}"
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
    //var finishinfo = finishinfo()
    //var FinishData:[finishinfo] = []
    var test1: AnyObject?=json.objectForKey("serverResponse")
       var CollectionData:[facilitatorInfo] = []
    var response1 :String = test1 as! String
    if  response1 == "Success"{
    var test2: AnyObject?=json.objectForKey("data")
   
    let jsonArray = test2 as? NSArray
     var count = jsonArray?.count
 
    for value in jsonArray!{
        var id:Int=value.objectForKey("id") as! Int
        var facilitatorName:String=value.objectForKey("facilitatorName") as! String
        var companyName:String=value.objectForKey("companyName") as! String
        var facilitatorID:String=value.objectForKey("facilitatorID") as! String
        var officePhone:String=value.objectForKey("officePhone") as! String
        
        
        
        var qqNumber:String=value.objectForKey("qqNumber") as! String
        var contactPhone:String=value.objectForKey("contactPhone") as! String
        var facilitatorProvince:String=value.objectForKey("facilitatorProvince") as! String
        var facilitatorCity:String=value.objectForKey("facilitatorCity") as! String
        var facilitatorCounty:String=value.objectForKey("facilitatorCounty") as! String
        
        
        var emailAddress:String=value.objectForKey("emailAddress") as! String
        var contactAddress:String=value.objectForKey("contactAddress") as! String
        var registerTime:String=value.objectForKey("registerTime") as! String
        var facilitatorLevel:Int=value.objectForKey("facilitatorLevel") as! Int
        var creditScore:String = value.objectForKey("creditScore") as! String
        
        
        
        var facilitatorIntro:String=value.objectForKey("facilitatorIntro") as! String
        var facilitatorLogo:String=value.objectForKey("facilitatorLogo") as! String
        var facilitatorStatus:String=value.objectForKey("facilitatorStatus") as! String
        
        var serviceCount:Int=value.objectForKey("serviceCount") as! Int
        
        let obj:facilitatorInfo = facilitatorInfo(id:id,facilitatorName:facilitatorName,facilitatorID:facilitatorID,officePhone:officePhone,qqNumber:qqNumber,contactPhone:contactPhone,facilitatorProvince:facilitatorProvince,facilitatorCity:facilitatorCity,facilitatorCounty:facilitatorCounty,emailAddress:emailAddress,contactAddress:contactAddress,registerTime: registerTime,facilitatorLevel:facilitatorLevel,creditScore:creditScore,
            facilitatorIntro: facilitatorIntro,facilitatorLogo:facilitatorLogo,facilitatorStatus:facilitatorStatus,serviceCount: serviceCount)

        
           CollectionData += [obj]
       
        }
    }
 
    return CollectionData
    
}
//收藏的人员
func refreshSCollection(customerID:String,serviceType:String) ->[ServantInfo]  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServantCollectionAction?operation=_query")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
 
    var param:String = "{\"customerID\":\"\(customerID)\",\"serviceType\":\"\(serviceType)\"}"
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
   
    var CollectionSData:[ServantInfo] = []
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var response1 :String = test1 as! String
    if  response1 == "Success"{
    var test2: AnyObject?=json.objectForKey("data")
 
    let jsonArray = test2 as? NSArray
  
    var count = jsonArray?.count
 
    for value in jsonArray!{
        var id:Int=value.objectForKey("id") as! Int
        var servantID:String=value.objectForKey("servantID") as! String
        var servantName:String=value.objectForKey("servantName") as! String
        var phoneNo:String=value.objectForKey("phoneNo") as! String
        var servantMobil:String=value.objectForKey("servantMobil") as! String
        var educationLevel:String=value.objectForKey("educationLevel") as! String
        
        println("这个ID是什么呢")
        
        var trainingIntro:String=value.objectForKey("trainingIntro") as! String
        var servantProvince:String=value.objectForKey("servantProvince") as! String
        var servantCity:String=value.objectForKey("servantCity") as! String
        var servantCounty:String=value.objectForKey("servantCounty") as! String
        var servantGender:String=value.objectForKey("servantGender") as! String
        
        
        var headPicture:String=value.objectForKey("headPicture") as! String
        var workYears:Float=value.objectForKey("workYears") as! Float
        var servantHonors:String=value.objectForKey("servantHonors") as! String
        var servantIntro:String = value.objectForKey("servantIntro") as! String
        var isStayHome:Bool = value.objectForKey("isStayHome") as! Bool
        
        
        
        var holidayInMonth:Int=value.objectForKey("holidayInMonth") as! Int
        var servantScore:String=value.objectForKey("servantScore") as! String
        var servantStatus:String=value.objectForKey("servantStatus") as! String
        
        var serviceCount:Int = value.objectForKey("serviceCount") as! Int
        var careerType:String = value.objectForKey("careerType") as! String
        
        
        var serviceItems:String = value.objectForKey("serviceItems") as! String
        var facilitatorName:String = value.objectForKey("facilitatorName") as! String
        var facilitatorID:String = value.objectForKey("facilitatorID") as! String
         var servantSalary:String = value.objectForKey("servantSalary") as! String
        
        let obj:ServantInfo = ServantInfo(id:id,servantID:servantID,servantName:servantName,phoneNo:phoneNo,servantMobil:servantMobil,educationLevel : educationLevel,trainingIntro : trainingIntro,servantProvince : servantProvince,
            servantCity : servantCity,
            servantCounty : servantCounty,
            servantGender : servantGender,
            
            headPicture : headPicture,
            workYears : workYears,
            servantHonors : servantHonors,
            servantIntro : servantIntro,
            isStayHome : isStayHome,
            
            holidayInMonth : holidayInMonth,
            servantScore : servantScore,
            servantStatus : servantStatus,
            serviceCount : serviceCount,
            careerType : careerType,
            
            serviceItems : serviceItems,
            facilitatorName : facilitatorName,
            facilitatorID : facilitatorID,
            servantSalary:servantSalary)
        
        CollectionSData += [obj]
        
        }
        
    }

    return CollectionSData
    
}

//取消人员收藏时的函数
func deleteSCollection(customerID:String,servantID:String) ->String  {
    //要改URL
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServantCollectionAction?operation=_delete")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    var param:String = "{\"customerID\":\"\(customerID)\",\"servantID\":\"\(servantID)\"}"
    
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

//添加人员收藏时的函数
func addSCollection(customerid:String,servantid:String,servantname:String) ->String  {
    //要改URL
    
    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServantCollectionAction?operation=_add")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    println("servantname\(servantname)")
    var param:String = "{\"customerID\":\"\(customerid)\",\"servantID\":\"\(servantid)\",\"servantName\":\"\(servantname)\"}"
    println(param)
    println("typeName\(servantname)")
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
//取消商家收藏时的函数
func deleteFCollection(customerID:String,facilitatorID:String,facilitatorName:String) ->String  {
    //要改URL
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_delete")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    var param:String = "{\"customerID\":\"\(customerID)\",\"facilitatorID\":\"\(facilitatorID)\",\"facilitatorName\":\"\(facilitatorName)\"}"
    
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
//添加商家收藏时的函数
func addFCollection(customerID:String,facilitatorID:String,facilitatorName:String) ->String  {
    //要改URL
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_add")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    var param:String = "{\"customerID\":\"\(customerID)\",\"facilitatorID\":\"\(facilitatorID)\",\"facilitatorName\":\"\(facilitatorName)\"}"
    
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

