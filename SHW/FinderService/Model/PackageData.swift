//
//  PackageData.swift
//  SHW
//
//  Created by Zhang on 15/8/13.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation
//查询一口价
func getPackage(secondType:String,attributeName:String,upDown:String,facilitatorCounty:String) ->NSArray  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceItemAction?operation=_packageService")
    
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    var param:String = "{\"type\":\"\(secondType)\",\"attributeName\":\"\(attributeName)\",\"upDown\":\"\(upDown)\",\"facilitatorCounty\":\"\(facilitatorCounty)\"}"
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
         println("jsonString")
        println(jsonString)
        
    }
    
    let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
    //var finishinfo = finishinfo()
    //var FinishData:[finishinfo] = []
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var serverResponse:String = test1 as! String
    var ServiceItemData:[serviceItemInfo] = []
    if serverResponse == "Success" {
    var common: AnyObject?=json.objectForKey("data")
    let jsonArray = common as? NSArray
    var count = jsonArray?.count
   
    for value in jsonArray!{
        var id:Int=value.objectForKey("id") as! Int
        var itemName:String=value.objectForKey("itemName") as! String
        var facilitatorName:String=value.objectForKey("facilitatorName") as! String
        var facilitatorID:String=value.objectForKey("facilitatorID") as! String
        var serviceType:String=value.objectForKey("serviceType") as! String
        
        
        
        var itemIntro:String=value.objectForKey("itemIntro") as! String
        var priceDescription:String=value.objectForKey("priceDescription") as! String
        var servicePicture:String=value.objectForKey("servicePicture") as! String
        var isPackage:Bool=value.objectForKey("isPackage") as! Bool
        var itemType:String=value.objectForKey("itemType") as! String
        
        
        let obj:serviceItemInfo = serviceItemInfo(id:id,itemName:itemName,facilitatorName:facilitatorName,facilitatorID:facilitatorID,serviceType:serviceType,itemIntro:itemIntro,priceDescription:priceDescription,servicePicture:servicePicture,isPackage:isPackage,itemType:itemType
        )
        
        ServiceItemData += [obj]
        
      }
    }
    return ServiceItemData
    
}

