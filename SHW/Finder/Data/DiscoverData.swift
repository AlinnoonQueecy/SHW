//
//  DiscoverData.swift
//  SHW
//
//  Created by Zhang on 15/12/4.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation



class facilitatorAdvertise:NSObject {
    var id:Int
    var facilitatorID:String
    var facilitatorName:String
    var contactName:String
    var contactNo:String
    
    var emailAddress:String
    var advertiseType:String
    var advertiseTopic:String
    var advertiseIntro:String
    var advertisePicture:String
    
   
    init( id:Int,facilitatorID:String,facilitatorName:String,contactName:String,contactNo:String,emailAddress:String,advertiseType:String,advertiseTopic:String,advertiseIntro:String,advertisePicture:String){
            self.id = id
            self.facilitatorID = facilitatorID
            self.facilitatorName = facilitatorName
            self.contactName = contactName
            self.contactNo = contactNo

            self.emailAddress =  emailAddress
            self.advertiseType = advertiseType
            self.advertiseTopic =  advertiseTopic
            self.advertiseIntro = advertiseIntro
            self.advertisePicture = advertisePicture
            super.init()
    }
    
}


//查询发现功能数据
func GetfacilitatorAdvertise(PageNo:Int) ->NSArray  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorAdvertiseAction?operation=_queryFind")
    
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
        println(jsonString)
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    var AdvertiseData:[facilitatorAdvertise] = []
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var  response1 :String = test1 as! String
    if  response1 == "Success"{
        var test2: AnyObject?=json.objectForKey("data")
        let jsonArray = test2 as? NSArray
        var count = jsonArray?.count
  
        for value in jsonArray!{
        var id:Int=value.objectForKey("id") as! Int
        var facilitatorID:String=value.objectForKey("facilitatorID") as! String
        var facilitatorName:String=value.objectForKey("facilitatorName") as! String
        var contactName:String=value.objectForKey("contactName") as! String
        var contactNo:String=value.objectForKey("contactNo") as! String


        var emailAddress:String=value.objectForKey("emailAddress") as! String
        var advertiseType:String=value.objectForKey("advertiseType") as! String
 

        var advertiseTopic:String=value.objectForKey("advertiseTopic") as! String

        var advertiseIntro:String=value.objectForKey("advertiseIntro") as! String

        var advertisePicture:String=value.objectForKey("advertisePicture") as! String


        let obj:facilitatorAdvertise=facilitatorAdvertise(id: id,facilitatorID:facilitatorID,facilitatorName:facilitatorName,contactName:contactName,contactNo:contactNo,emailAddress:emailAddress,advertiseType:advertiseType,advertiseTopic:advertiseTopic,advertiseIntro:advertiseIntro,advertisePicture:advertisePicture)

        AdvertiseData += [obj]
 
       }
    }
    return AdvertiseData

  }


//发现功能广告页
func GetFinderPage(PageNo:Int) ->Int  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileFacilitatorAdvertiseAction?operation=_queryFind")
    
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
   var param:String = "{\"pageNo\":\"\(PageNo)\"}"
    
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
