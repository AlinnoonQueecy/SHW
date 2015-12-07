//
//  OrderData.swift
//  SHW
//
//  Created by Zhang on 15/8/5.
//  Copyright (c) 2015年 star. All rights reserved.
//

import Foundation
import UIKit
func getOrderData(ID:Int) ->Finishinfo  {
    var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_queryOrderByid")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"id\":\"\(ID)\"}"
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
     var orderData:Finishinfo?
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var response1 :String = test1 as! String
    if  response1 == "Success"{
    var value: AnyObject?=json.objectForKey("data")
 
        var confirmTime:String=value!.objectForKey("confirmTime") as! String
        var customerEvaluate:String=value!.objectForKey("customerEvaluate") as! String
        var customerID:String=value!.objectForKey("customerID") as! String
        var customerName:String=value!.objectForKey("customerName") as! String
        var facilitatorID:String=value!.objectForKey("facilitatorID") as! String
        
        var facilitatorName:String=value!.objectForKey("facilitatorName") as! String
        var id:Int=value!.objectForKey("id") as! Int
        var itemIDs:String=value!.objectForKey("itemIDs") as! String
        var itemName:String=value!.objectForKey("itemName") as! String
        var orderNo:String=value!.objectForKey("orderNo") as! String
        
        var orderStatus:String=value!.objectForKey("orderStatus") as! String
        var orderTime:String=value!.objectForKey("orderTime") as! String
        var overTime:String=value!.objectForKey("overTime") as! String
        var paidAmount:Float=value!.objectForKey("paidAmount") as! Float
        var remarks:String=value!.objectForKey("remarks") as! String
        
        var servantID:String=value!.objectForKey("servantID") as! String
        var servantName:String=value!.objectForKey("servantName") as! String
        var serviceContent:String=value!.objectForKey("serviceContent") as! String
        var servicePrice:Float=value!.objectForKey("servicePrice") as! Float
        var serviceType:String=value!.objectForKey("serviceType") as! String
        
        var startTime:String=value!.objectForKey("startTime") as! String
        
        var contactPhone:String=value!.objectForKey("contactPhone") as! String
        var contactAddress:String=value!.objectForKey("contactAddress") as! String
        let obj:Finishinfo=Finishinfo(confirmTime: confirmTime,customerEvaluate: customerEvaluate, customerID: customerID, customerName: customerName, facilitatorID: facilitatorID, facilitatorName: facilitatorName, id: id, itemIDs: itemIDs, itemName: itemName, orderNo: orderNo, orderStatus: orderStatus, orderTime: orderTime, overTime: overTime, paidAmount: paidAmount, remarks: remarks, servantID: servantID, servantName: servantName, serviceContent: serviceContent, servicePrice: servicePrice, serviceType: serviceType, startTime: startTime,contactPhone:contactPhone,contactAddress:contactAddress)
        
        
        orderData = obj
    
    }
    
    return orderData!
    
}


