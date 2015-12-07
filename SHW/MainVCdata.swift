////
//  MainVCdata.swift
//  SHW
//
//  Created by Zhang on 15/7/17.
//  Copyright (c) 2015年 star. All rights reserved.
//
import Foundation
import UIKit
 

class ServiceType:NSObject {
    var id :Int
    var typeName:String
    var typeIntro:String
    var typeLogo:String
    var isPerson:String
    var parentId:Int
    var pageSize:Int

    init(id :Int,typeName:String,typeIntro:String,typeLogo:String,isPerson:String,parentId:Int,pageSize:Int){
            self.id = id
            self.typeName = typeName
            self.typeIntro = typeIntro
            self.typeLogo = typeLogo
            self.isPerson = isPerson
            self.parentId = parentId
            self.pageSize = pageSize
  
            super.init()
    }
    
}
//查询父类(A)
func refreshParentType(select:String) ->NSArray  {
    let url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServiceTypeAction?operation=_query")
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    let param:String = "{\"typeName\":\"\(select)\"}"
    println("param\(param)")
    let data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
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
    
    let test1: AnyObject?=json.objectForKey("serverResponse")
    var ServiceTypeData:[ServiceType] = []
    let serverResponse:String = test1 as! String
    if serverResponse == "Success" {
        let test2: AnyObject = json.objectForKey("data")!
        let jsonArray = test2 as? NSArray
        
        
        for value in jsonArray!{
            
            let id:Int=value.objectForKey("id") as! Int
            let typeName:String=value.objectForKey("typeName") as! String
            let typeIntro:String=value.objectForKey("typeIntro") as! String
            let typeLogo:String=value.objectForKey("typeLogo2") as! String
            let isPerson:String=value.objectForKey("isPerson")as!String
            let parentId:Int=value.objectForKey("parentId") as! Int
            let pageSize:Int=value.objectForKey("parentId") as! Int
            
            
            let obj:ServiceType=ServiceType(id:id,typeName:typeName,typeIntro:typeIntro,typeLogo:typeLogo,isPerson:isPerson,parentId:parentId,pageSize:pageSize)
            
            ServiceTypeData += [obj]
        }
        
        
    }
 
    return ServiceTypeData
    
    
}
//根据父类查询子类
func refreshServiceType(select:String) ->NSArray  {
    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServiceTypeAction?operation=_query")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
  
    var param:String = "{\"typeName\":\"\(select)\"}"
  
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
    var ServiceTypeData:[ServiceType] = []
    var serverResponse:String = test1 as! String
    if serverResponse == "Success" {
    var test2: AnyObject = json.objectForKey("data")!
    let jsonArray = test2 as? NSArray
    var count = jsonArray?.count
    
    for value in jsonArray!{
        
        var id:Int=value.objectForKey("id") as! Int
        var typeName:String=value.objectForKey("typeName") as! String
        var typeIntro:String=value.objectForKey("typeIntro") as! String
        var typeLogo:String=value.objectForKey("typeLogo") as! String
        var isPerson:String=value.objectForKey("isPerson") as! String
        var parentId:Int=value.objectForKey("parentId") as! Int
        let pageSize:Int=value.objectForKey("parentId") as! Int
        
        
        let obj:ServiceType=ServiceType(id:id,typeName:typeName,typeIntro:typeIntro,typeLogo:typeLogo,isPerson:isPerson,parentId:parentId,pageSize:pageSize)
      
        ServiceTypeData += [obj]
        println(obj)
        
        
    }
    }
    return ServiceTypeData
    
}



//根据子类名称得到其详情
//func getServiceType(select:String) ->ServiceType{
//   
//    //要改URL
//    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServiceTypeAction?operation=_queryByName")
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    
//    var param:String = "{\"typeName\":\"\(select)\"}"
//    
//    println(param)
//     var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    request.HTTPBody = data;
//    var response:NSURLResponse?
//    var error:NSError?
//    var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//    if (error != nil)
//    {
//        
//        
//    }
//    else
//    {
//        var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
//   
//        
//    }
//    
//    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
// 
//    var test1: AnyObject?=json.objectForKey("serverResponse")
//    var ServiceTypeData:ServiceType?
//    var serverResponse:String = test1 as! String
//    
//    if serverResponse == "Success" {
//        var value: AnyObject = json.objectForKey("data")!
//      
//        
//            var id:Int=value.objectForKey("id") as! Int
//            var typeName:String=value.objectForKey("typeName") as! String
//            var typeIntro:String=value.objectForKey("typeIntro") as! String
//            var typeLogo:String=value.objectForKey("typeLogo") as! String
//            var isPerson:String=value.objectForKey("isPerson") as! String
//            var parentId:Int=value.objectForKey("parentId") as! Int
//            let pageSize:Int=value.objectForKey("pageSize") as! Int
//        
//            
//            
//        let obj:ServiceType=ServiceType(id: id,typeName:typeName,typeIntro:typeIntro,typeLogo:typeLogo,isPerson:isPerson,parentId:parentId,pageSize:pageSize)
//        
//            ServiceTypeData = obj
//        
//            
//       
//    }
//    return ServiceTypeData!
//
//}
//
//





class  HomeAdvertise:NSObject{
    var id:Int
    var advertisePicture:String
    var advertiseTopic:String
    var facilitatorID:String
    init(id :Int,advertisePicture:String,advertiseTopic:String,facilitatorID:String ){
        self.id = id
        self.advertisePicture = advertisePicture
        self.advertiseTopic = advertiseTopic
    
        self.facilitatorID = facilitatorID
        
        
        super.init()
    }
    
}

func refreshAdvertise(PageNo:Int) ->NSArray{
 
    //创建NSURL
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorAdvertiseAction?operation=_query")
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    
    var param:String = "{\"pageNo\":\"\(PageNo)\"}"
    println(PageNo)
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

    
    var json: AnyObject? = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    
    var test1: AnyObject?=json?.objectForKey("serverResponse")
    var serverResponse:String = test1 as! String
    var AdvertiseData:[HomeAdvertise] = []
    if serverResponse == "Success" {
    var test2: AnyObject?=json?.objectForKey("data")
    let jsonArray = test2 as? NSArray
    var count = jsonArray?.count
     for value in jsonArray!{
        
        var id:Int=value.objectForKey("id") as! Int
        var advertisePicture:String=value.objectForKey("advertisePicture") as! String
        var advertiseTopic:String=value.objectForKey("advertiseTopic") as! String
        var facilitatorID:String=value.objectForKey("facilitatorID") as! String
 
        let obj:HomeAdvertise=HomeAdvertise(id:id,advertisePicture:advertisePicture,advertiseTopic:advertiseTopic,facilitatorID:facilitatorID)
        
           AdvertiseData += [obj]
        println()
        
       }
    }
    return AdvertiseData
    
}



func getImageData(url:String?)->NSData?{
    
    var dataA:NSData?
 
        var data:NSData?=ZYHWebImageChcheCenter.readCacheFromUrl(url!)
    
        if data != nil {
            dataA = data
             
        }else{
         
            var URL:NSURL = NSURL(string:url!)!
            var data:NSData?=NSData(contentsOfURL: URL)
            
            if data != nil {
                
                dataA = data
                //写缓存
                 ZYHWebImageChcheCenter.writeCacheToUrl(url!, data: data!)
                
            }
        }
     return dataA
    
}












