 //
//  FacilitatorInfo.swift
//  SHW
//
//  Created by Zhang on 15/7/17.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation

import UIKit
// 
//var selectInfo:String?
class facilitatorInfo:NSObject {
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

//1.1. 查询提供某一服务的所有商家
 func refreshFacilitator(secondType:String,attributeName:String,upDown:String,facilitatorCounty:String,pageNo:Int) ->NSArray  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_byServiceType")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
     var param:String = "{\"type\":\"\(secondType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\",\"facilitatorCounty\":\"\(facilitatorCounty)\",\"pageNo\":\"\(pageNo)\",\"fiterCondition\":\"\"}"
    
     var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
 
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
     }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var serverResponse:String = test1 as! String 
    
    var FacilitatorData:[facilitatorInfo] = []
    if  serverResponse == "Success" {
    var test2: AnyObject?=json.objectForKey("data")
     let jsonArray = test2 as? NSArray
    var count = jsonArray?.count
   
    for value in jsonArray!{
        var id:Int=value.objectForKey("id") as! Int
        var facilitatorName:String=value.objectForKey("facilitatorName") as! String
       
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
        var serviceType:String = value.objectForKey("serviceTypeArray") as! String
        let obj:facilitatorInfo = facilitatorInfo(id:id,facilitatorName:facilitatorName,facilitatorID:facilitatorID,officePhone:officePhone,qqNumber:qqNumber,contactPhone:contactPhone,facilitatorProvince:facilitatorProvince,facilitatorCity:facilitatorCity,facilitatorCounty:facilitatorCounty,emailAddress:emailAddress,contactAddress:contactAddress,registerTime: registerTime,facilitatorLevel:facilitatorLevel,creditScore:creditScore,
            facilitatorIntro: facilitatorIntro,facilitatorLogo:facilitatorLogo,facilitatorStatus:facilitatorStatus,serviceCount: serviceCount)
        
        FacilitatorData += [obj]
 
        
       }
    }
    return FacilitatorData
    
}
 //1.2商家页数
 func GetFPage(secondType:String,attributeName:String,upDown:String,facilitatorCounty:String,pageNo:Int) ->Int  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_byServiceType")
    //var url: NSURL! = NSURL(string:"http://192.168.1.105:8080/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_byServiceType")

    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
     var param:String = "{\"type\":\"\(secondType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\",\"facilitatorCounty\":\"\(facilitatorCounty)\",\"pageNo\":\"\(pageNo)\",\"fiterCondition\":\"\"}"
    
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
        
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        println("jsonString\(jsonString)")

        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var serverResponse:String = test1 as! String
    var Page:Int?
    if  serverResponse == "Success" {
    var pagesize: AnyObject?=json.objectForKey("pageSize")
         Page = pagesize as? Int
            }
    return Page!
    
 }

//商家详情
 func refreshFDetail (facilitatorID:String)->facilitatorInfo{
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_detailQuery")
    println("查询指定facilitatorID商家")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"facilitatorID\":\"\(facilitatorID)\"}"
 
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
             }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
 
    var detailData:facilitatorInfo?
    var test1: AnyObject?=json.objectForKey("serverResponse")
    
    var serverResponse:String = test1 as! String
    
 
    if  serverResponse == "Success" {
    var basic: AnyObject?=json.objectForKey("basic")
    var id:Int=basic!.objectForKey("id") as! Int
    var facilitatorName1:String=basic!.objectForKey("facilitatorName") as! String
    //var companyName1:String=basic!.objectForKey("companyName") as! String
    var facilitatorID1:String=basic!.objectForKey("facilitatorID") as! String
    var officePhone1:String=basic!.objectForKey("officePhone") as! String
    
    
    
    var qqNumber1:String=basic!.objectForKey("qqNumber") as! String
    var contactPhone1:String=basic!.objectForKey("contactPhone") as! String
    var facilitatorProvince1:String=basic!.objectForKey("facilitatorProvince") as! String
    var facilitatorCity1:String=basic!.objectForKey("facilitatorCity") as! String
    var facilitatorCounty1:String=basic!.objectForKey("facilitatorCounty") as! String
    
    
    var emailAddress1:String=basic!.objectForKey("emailAddress") as! String
    var contactAddress1:String=basic!.objectForKey("contactAddress") as! String
    var registerTime1:String=basic!.objectForKey("registerTime") as! String
    var facilitatorLevel1:Int=basic!.objectForKey("facilitatorLevel") as! Int
    var creditScore1:String = basic!.objectForKey("creditScore") as! String
    
    
    
    var facilitatorIntro1:String=basic!.objectForKey("facilitatorIntro") as! String
    var facilitatorLogo1:String=basic!.objectForKey("facilitatorLogo") as! String
    var facilitatorStatus1:String=basic!.objectForKey("facilitatorStatus") as! String
    
    var serviceCount1:Int=basic!.objectForKey("serviceCount") as! Int
    
    let obj:facilitatorInfo = facilitatorInfo(id:id,facilitatorName:facilitatorName1,facilitatorID:facilitatorID1,officePhone:officePhone1,qqNumber:qqNumber1,contactPhone:contactPhone1,facilitatorProvince:facilitatorProvince1,facilitatorCity:facilitatorCity1,facilitatorCounty:facilitatorCounty1,emailAddress:emailAddress1,contactAddress:contactAddress1,registerTime: registerTime1,facilitatorLevel:facilitatorLevel1,creditScore:creditScore1,
        facilitatorIntro: facilitatorIntro1,facilitatorLogo:facilitatorLogo1,facilitatorStatus:facilitatorStatus1,serviceCount: serviceCount1)
    
      detailData = obj
    }
    
    return detailData!
    
}
 //是否被收藏
 func GetCollect (facilitatorID:String,customerID:String)->String{
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_detailQuery")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
     
    var param:String = "{\"facilitatorID\":\"\(facilitatorID)\",\"customerID\":\"\(customerID)\"}"
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
     }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    var collect: AnyObject?=json.objectForKey("isCollected")
     var isCollected :String = collect as! String
    
    return isCollected
  }
 
 
 
 
//添加收藏时的函数
func addCollection(n:String) ->String  {
    //要改URL
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_add")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    var param:String = "{\"typeName\":\"\(n)\"}"
     var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
     }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    
    
    var serviceresponse: AnyObject?=json.objectForKey("serverResponse")
    var Response :String = serviceresponse as! String


    return Response
}
 //取消收藏时的函数
 /*func deleteCollection(select:String) ->String  {
    //要改URL
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorCollectionAction?operation=_add")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    //var param:String = "{\"customerID\":\"\(customerid)\",\"facilitatorID\":\"\(detailItem.facilitatorID)\",\"facilitatorName\":\"\(detailItem.facilitatorName)\"}"
    
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
 }*/
 
// 
// class CountyInfo:NSObject {
//    var id :Int
//    var cityCode:String
//    var cityName:String
//    var countyName:String
//    var isCovered:String
//        init( id:Int,cityCode:String,cityName:String,countyName:String,isCovered:String){
//            self.id = id
//            self.cityCode = cityCode
//            self.cityName = cityName
//            self.countyName = countyName
//            self.isCovered = isCovered
//            super.init()
//    }
//    
// }

 func queryCounty(cityName:String) ->NSArray  {
    //要改URL
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileCountyInfoAction?operation=_querycoveredCounty")
    println(url)
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //要改参数类型
    var param:String = "{\"cityName\":\"\(cityName)\"}"
   
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    request.HTTPBody = data;
    var response:NSURLResponse?
    var error:NSError?
    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    if (error != nil)
    {
     }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    
    //var detailData:CountyInfo!
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var serverResponse:String = test1 as! String
    
    var countyData:[String] = []
    if  serverResponse == "Success" {
    var test2: AnyObject?=json.objectForKey("data")
    
    let jsonArray = test2 as? NSArray
    var count = jsonArray?.count
   
        
        
    for value in jsonArray!{
        var countyName:String=value.objectForKey("countyName") as! String
        
   
            countyData += [countyName]
            
        }
    }
    
    return countyData
    
        
 }
 

 
 