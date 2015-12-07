//
//  ServantInfo.swift
//  SHW
//
//  Created by Zhang on 15/7/19.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation
import UIKit
class ServantInfo:NSObject {
    var id :Int
    var servantID:String
    var servantName:String
    var phoneNo :String
    var servantMobil:String
    var educationLevel:String
    
    var trainingIntro:String
    var servantProvince:String
    var servantCity:String
    var servantCounty:String
    var servantGender:String
    

    var headPicture:String
    var workYears:Float
    var servantHonors:String
    var servantIntro:String
    var isStayHome:Bool
    
    
    var holidayInMonth:Int
    var servantScore: String
    var servantStatus:String
    var serviceCount: Int
    var careerType:String
    
    var serviceItems:String
    var facilitatorName:String
    var facilitatorID:String
   var  servantSalary :String
    
    init( id:Int,servantID:String
        ,servantName:String,phoneNo :String,servantMobil:String,educationLevel:String,trainingIntro:String,servantProvince:String,servantCity:String,servantCounty:String,servantGender:String,headPicture:String,workYears: Float,servantHonors:String ,servantIntro:String ,isStayHome: Bool,holidayInMonth:Int,servantScore:String,servantStatus: String,serviceCount:Int,careerType:String,  serviceItems:String,facilitatorName:String,facilitatorID:String,servantSalary :String){
            self.id = id
            self.servantID = servantID
            self.servantName = servantName
            self.phoneNo = phoneNo
            self.servantMobil = servantMobil
            self.educationLevel = educationLevel
            
            self.trainingIntro = trainingIntro
            self.servantProvince = servantProvince
            self.servantCity = servantCity
            self.servantCounty = servantCounty
            self.servantGender = servantGender
            
            self.headPicture = headPicture
            self.workYears = workYears
            self.servantHonors = servantHonors
            self.servantIntro = servantIntro
            self.isStayHome = isStayHome
            
            self.holidayInMonth = holidayInMonth
            self.servantScore = servantScore
            self.servantStatus = servantStatus
            self.serviceCount = serviceCount
            self.careerType = careerType
            
            self.serviceItems = serviceItems
            self.facilitatorName = facilitatorName
            self.facilitatorID = facilitatorID
            self.servantSalary = servantSalary
            super.init()
    }
    
}

//查询某商家的所有服务人员
func refreshServantData(facilitatorID:String) ->NSArray  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServantInfoAction?operation=_query")
    println("查询商家的服务人员")
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
        println(error?.code)
        println(error?.description)
    }
    else
    {
        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
        println("jsonString\(jsonString)")
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
   
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var ServantData:[ServantInfo] = []
    var serverResponse:String = test1 as! String
    if  serverResponse == "Success" {
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
           ServantData += [obj]
    
        }
    }
     return ServantData
    
    
}



//查询某人员是否被收藏
func GetServantCollect (servantID:String,customerID:String)->String{
    
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServantCollectionAction?operation=_collectionQuery")
  
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    var param:String = "{\"servantID\":\"\(servantID)\",\"customerID\":\"\(customerID)\"}"
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
    println("json:\(json)")
    
     var isCollected :String = ""
     var test1: AnyObject?=json.objectForKey("serverResponse")
     var  serviceresponse:String = test1  as! String
    
     if  serviceresponse == "Success"{
        
   var collect: AnyObject?=json.objectForKey("isCollected")
        isCollected = collect as! String
        
       println("isCollected\(isCollected)")
    }
    
    
    return isCollected
}
class CommentInfo:NSObject {
    var id :Int
     var customerID :String
    var commentType:String
    var commentDate:String
    
    init( id:Int,customerID:String
        ,commentType:String,commentDate :String ){
            self.id = id
            self.customerID = customerID
            self.commentType = commentType
            self.commentDate = commentDate
            super.init()
    }
    
}
//查询客户对人员的评价
func getSconmmentData(servantID:String) ->NSArray  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_queryServantComment")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
 
    var param:String = "{\"servantID\":\"\(servantID)\"}"
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
     var CommentData:[CommentInfo] = []
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var response1 :String = test1 as! String
    if response1 == "Success" {
    var test2: AnyObject?=json.objectForKey("data")
    let jsonArray = test2 as? NSArray
    var count = jsonArray?.count
    
    for value in jsonArray!{
        var id:Int=value.objectForKey("id") as! Int
        var customerID:String=value.objectForKey("customerID") as! String
        var commentType:String=value.objectForKey("commentType") as! String
        var commentDate:String=value.objectForKey("commentDate") as! String
        
        let obj:CommentInfo = CommentInfo(id:id,customerID:customerID,commentType:commentType,commentDate:commentDate)
        
        CommentData += [obj]
        
        }
    }
    return CommentData
    
}
//判断是不是有评论
func getResponse(servantID:String) ->String  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_queryServantComment")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    var param:String = "{\"servantID\":\"\(servantID)\"}"
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
         var test1: AnyObject?=json.objectForKey("serverResponse")
 
 
    var serverResponse:String
    serverResponse = test1 as! String
 
        
        
 return  serverResponse
}
//1.2. 查询提供某一服务的所有人员
func refreshServant(secondType:String,attributeName:String,upDown:String,facilitatorCounty:String,pageNo:Int) ->NSArray  {
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorInfoAction?operation=_byServiceType")
 
    
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    var param:String = "{\"type\":\"\(secondType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\",\"facilitatorCounty\":\"\(facilitatorCounty)\",\"pageNo\":\"\(pageNo)\",\"fiterCondition\":\"\"}"
    println("param\(param)")
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
    var ServantData:[ServantInfo] = []
    if serverResponse == "Success" {
        var test2: AnyObject?=json.objectForKey("data")
        let jsonArray = test2 as? NSArray
        var count = jsonArray?.count
        
        for value in jsonArray!{
            var id:Int=value.objectForKey("id") as! Int
            var servantID:String=value.objectForKey("servantID") as! String
            var servantName:String=value.objectForKey("servantName") as! String
            var phoneNo:String=value.objectForKey("phoneNo") as! String
            var servantMobile:String=value.objectForKey("servantMobil") as! String
            var educationLevel:String=value.objectForKey("educationLevel") as! String
            
            
            
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
            
            
            let obj:ServantInfo = ServantInfo(id:id,servantID:servantID,servantName:servantName,phoneNo:phoneNo,servantMobil:servantMobile,educationLevel : educationLevel,trainingIntro : trainingIntro,servantProvince : servantProvince,
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
            
            ServantData += [obj]
            
        }
    }
    return ServantData
    
}

//1.2人员页数
func GetSPage(secondType:String,attributeName:String,upDown:String,facilitatorCounty:String,pageNo:Int) ->Int  {
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
    var Page:Int?
    if  serverResponse == "Success" {
        var pagesize: AnyObject?=json.objectForKey("pageSize")
        Page = pagesize as? Int
        
    }
    return Page!
    
}



