//
//  finishiorder.swift
//  SHW
//
//  Created by Zhang on 15/7/7.
//  Copyright (c) 2015年 star. All rights reserved.
//
//
import Foundation
import UIKit
//var FinishiData:[Finishinfo] = []

class Finishinfo:NSObject {
    var confirmTime:String
    var customerEvaluate:String
    var customerID:String
    var customerName:String
    var facilitatorID:String
    
    var facilitatorName:String
    var id:Int
    var itemIDs:String
    var itemName:String
    var orderNo:String
    
    var orderStatus:String
    var orderTime:String
    var overTime:String
    var paidAmount:Float
    var remarks:String
    
    var servantID:String
    var servantName:String
    var serviceContent:String
    var servicePrice:Float
    var serviceType:String
   
    var startTime:String
     var contactPhone:String
    var contactAddress:String
    init(confirmTime:String,customerEvaluate:String,customerID:String,customerName:String,facilitatorID:String,
        facilitatorName:String,id:Int,itemIDs:String,itemName:String,orderNo:String,orderStatus:String,orderTime:String,overTime:String,paidAmount:Float,remarks:String,servantID:String,servantName:String,serviceContent:String,servicePrice:Float ,serviceType:String,startTime:String,contactPhone:String,contactAddress:String){
        self.confirmTime = confirmTime
        self.customerEvaluate = customerEvaluate
        self.customerID = customerID
        self.customerName = customerName
        self.facilitatorID = facilitatorID
            
        self.facilitatorName = facilitatorName
        self.id = id
        self.itemIDs = itemIDs
        self.itemName = itemName
        self.orderNo = orderNo
            
        self.orderStatus = orderStatus
        self.orderTime = orderTime
        self.overTime = overTime
        self.paidAmount = paidAmount
        self.remarks = remarks
            
        self.servantID = servantID
        self.servantName = servantName
        self.serviceContent = serviceContent
        self.servicePrice = servicePrice
        self.serviceType = serviceType
            
        self.startTime = startTime
        self.contactPhone = contactPhone
        self.contactAddress = contactAddress
        super.init()
    }
    
}


//func refreshFinish(customerID:String) ->NSArray  {
//    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_query")
//    
//    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
//    
//    request.HTTPMethod = "POST"
//    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
//    var param:String = "{\"customerID\":\"\(customerID)\"}"
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
//    
//    var FinishiData:[Finishinfo] = []
//    var test1: AnyObject?=json.objectForKey("serverResponse")
//    var  response1 :String = test1 as! String
//    if  response1 == "Success"{
//    var test2: AnyObject?=json.objectForKey("data")
//    let jsonArray = test2 as? NSArray
//    var count = jsonArray?.count
//   
//    for value in jsonArray!{
//        var confirmTime:String=value.objectForKey("confirmTime") as! String
//        var customerEvaluate:String=value.objectForKey("customerEvaluate") as! String
//        var customerID:String=value.objectForKey("customerID") as! String
//        var customerName:String=value.objectForKey("customerName") as! String
//        var facilitatorID:String=value.objectForKey("facilitatorID") as! String
//        
//        var facilitatorName:String=value.objectForKey("facilitatorName") as! String
//        var id:Int=value.objectForKey("id") as! Int
//        var itemIDs:String=value.objectForKey("itemIDs") as! String
//        var itemName:String=value.objectForKey("itemName") as! String
//        var orderNo:String=value.objectForKey("orderNo") as! String
//        
//        var orderStatus:String=value.objectForKey("orderStatus") as! String
//        var orderTime:String=value.objectForKey("orderTime") as! String
//        var overTime:String=value.objectForKey("overTime") as! String
//        var paidAmount:Float=value.objectForKey("paidAmount") as! Float
//        var remarks:String=value.objectForKey("remarks") as! String
//        
//        var servantID:String=value.objectForKey("servantID") as! String
//        var servantName:String=value.objectForKey("servantName") as! String
//        var serviceContent:String=value.objectForKey("serviceContent") as! String
//        var servicePrice:Float=value.objectForKey("servicePrice") as! Float
//        var serviceType:String=value.objectForKey("serviceType") as! String
//        
//        var startTime:String=value.objectForKey("startTime") as! String
//        var contactPhone:String=value.objectForKey("contactPhone") as! String
//        var contactAddress:String=value.objectForKey("contactAddress") as! String
//        let obj:Finishinfo=Finishinfo(confirmTime: confirmTime,customerEvaluate: customerEvaluate, customerID: customerID, customerName: customerName, facilitatorID: facilitatorID, facilitatorName: facilitatorName, id: id, itemIDs: itemIDs, itemName: itemName, orderNo: orderNo, orderStatus: orderStatus, orderTime: orderTime, overTime: overTime, paidAmount: paidAmount, remarks: remarks, servantID: servantID, servantName: servantName, serviceContent: serviceContent, servicePrice: servicePrice, serviceType: serviceType, startTime: startTime,contactPhone:contactPhone,contactAddress:contactAddress)
//        //println(obj.facilitatorID+" "+obj.facilitatorName);
////        var FinishiData:[Finishinfo] = []
//        FinishiData += [obj]
//       // obj.confirmTime = a;
////        var b: AnyObject?=value.objectForKey("customerEvaluate")
////        finishinfo.customerEvaluate = b
////        var c: AnyObject?=value.objectForKey("customerName")
////        finishinfo.customerName = c
//        }
//    }
//    return FinishiData
//    
//}



//查询不同状态的订单
func refreshOrderData(customerID:String,orderStatus:String,page:Int) ->NSArray  {
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_queryOrder")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"customerID\":\"\(customerID)\",\"orderStatus\":\"\(orderStatus)\",\"pageNo\":\"\(page)\"}"
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
    
    
    var FinishiData:[Finishinfo] = []
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var  response1 :String = test1 as! String
    if  response1 == "Success"{
        var test2: AnyObject?=json.objectForKey("data")
        let jsonArray = test2 as? NSArray
        var count = jsonArray?.count
        
        for value in jsonArray!{
            var confirmTime:String=value.objectForKey("confirmTime") as! String
            var customerEvaluate:String=value.objectForKey("customerEvaluate") as! String
            var customerID:String=value.objectForKey("customerID") as! String
            var customerName:String=value.objectForKey("customerName") as! String
            var facilitatorID:String=value.objectForKey("facilitatorID") as! String
            
            var facilitatorName:String=value.objectForKey("facilitatorName") as! String
            var id:Int=value.objectForKey("id") as! Int
            var itemIDs:String=value.objectForKey("itemIDs") as! String
            var itemName:String=value.objectForKey("itemName") as! String
            var orderNo:String=value.objectForKey("orderNo") as! String
            
            var orderStatus:String=value.objectForKey("orderStatus") as! String
            var orderTime:String=value.objectForKey("orderTime") as! String
            var overTime:String=value.objectForKey("overTime") as! String
            var paidAmount:Float=value.objectForKey("paidAmount") as! Float
            var remarks:String=value.objectForKey("remarks") as! String
            
            var servantID:String=value.objectForKey("servantID") as! String
            var servantName:String=value.objectForKey("servantName") as! String
            var serviceContent:String=value.objectForKey("serviceContent") as! String
            var servicePrice:Float=value.objectForKey("servicePrice") as! Float
            var serviceType:String=value.objectForKey("serviceType") as! String
            
            var startTime:String=value.objectForKey("startTime") as! String
            
            var contactPhone:String=value.objectForKey("contactPhone") as! String
            var contactAddress:String=value.objectForKey("contactAddress") as! String
            let obj:Finishinfo=Finishinfo(confirmTime: confirmTime,customerEvaluate: customerEvaluate, customerID: customerID, customerName: customerName, facilitatorID: facilitatorID, facilitatorName: facilitatorName, id: id, itemIDs: itemIDs, itemName: itemName, orderNo: orderNo, orderStatus: orderStatus, orderTime: orderTime, overTime: overTime, paidAmount: paidAmount, remarks: remarks, servantID: servantID, servantName: servantName, serviceContent: serviceContent, servicePrice: servicePrice, serviceType: serviceType, startTime: startTime,contactPhone:contactPhone,contactAddress:contactAddress)
            //println(obj.facilitatorID+" "+obj.facilitatorName);
            //        var FinishiData:[Finishinfo] = []
            FinishiData += [obj]
            // obj.confirmTime = a;
            //        var b: AnyObject?=value.objectForKey("customerEvaluate")
            //        finishinfo.customerEvaluate = b
            //        var c: AnyObject?=value.objectForKey("customerName")
            //        finishinfo.customerName = c
        }
    }
    return FinishiData
    
}

//查询订单页数
func GetOrderPage(customerID:String,orderStatus:String,page:Int) ->Int  {
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_queryOrder")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
 
    var param:String = "{\"customerID\":\"\(customerID)\",\"orderStatus\":\"\(orderStatus)\",\"pageNo\":\"\(page)\"}"
     println("param\(param)")
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
    var serverResponse:String = test1 as! String
    var Page:Int!
    if  serverResponse == "Success" {
        var pagesize: AnyObject?=json.objectForKey("pageSize")
        Page = pagesize as? Int
        
    }
    
    return Page!
    
    
}

//查询所有的退款订单
func refreshRefundOrder(customerID:String,orderStatus:String) ->NSArray  {
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_queryRefundOrder")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"customerID\":\"\(customerID)\",\"orderStatus\":\"\(orderStatus)\"}"
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
    
    
    var FinishiData:[Finishinfo] = []
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var  response1 :String = test1 as! String
    if  response1 == "Success"{
        var test2: AnyObject?=json.objectForKey("data")
        let jsonArray = test2 as? NSArray
        var count = jsonArray?.count
        
        for value in jsonArray!{
            var confirmTime:String=value.objectForKey("confirmTime") as! String
            var customerEvaluate:String=value.objectForKey("customerEvaluate") as! String
            var customerID:String=value.objectForKey("customerID") as! String
            var customerName:String=value.objectForKey("customerName") as! String
            var facilitatorID:String=value.objectForKey("facilitatorID") as! String
            
            var facilitatorName:String=value.objectForKey("facilitatorName") as! String
            var id:Int=value.objectForKey("id") as! Int
            var itemIDs:String=value.objectForKey("itemIDs") as! String
            var itemName:String=value.objectForKey("itemName") as! String
            var orderNo:String=value.objectForKey("orderNo") as! String
            
            var orderStatus:String=value.objectForKey("orderStatus") as! String
            var orderTime:String=value.objectForKey("orderTime") as! String
            var overTime:String=value.objectForKey("overTime") as! String
            var paidAmount:Float=value.objectForKey("paidAmount") as! Float
            var remarks:String=value.objectForKey("remarks") as! String
            
            var servantID:String=value.objectForKey("servantID") as! String
            var servantName:String=value.objectForKey("servantName") as! String
            var serviceContent:String=value.objectForKey("serviceContent") as! String
            var servicePrice:Float=value.objectForKey("servicePrice") as! Float
            var serviceType:String=value.objectForKey("serviceType") as! String
            
            var startTime:String=value.objectForKey("startTime") as! String
            
            var contactPhone:String=value.objectForKey("contactPhone") as! String
            var contactAddress:String=value.objectForKey("contactAddress") as! String
            let obj:Finishinfo=Finishinfo(confirmTime: confirmTime,customerEvaluate: customerEvaluate, customerID: customerID, customerName: customerName, facilitatorID: facilitatorID, facilitatorName: facilitatorName, id: id, itemIDs: itemIDs, itemName: itemName, orderNo: orderNo, orderStatus: orderStatus, orderTime: orderTime, overTime: overTime, paidAmount: paidAmount, remarks: remarks, servantID: servantID, servantName: servantName, serviceContent: serviceContent, servicePrice: servicePrice, serviceType: serviceType, startTime: startTime,contactPhone:contactPhone,contactAddress:contactAddress)

            //println(obj.facilitatorID+" "+obj.facilitatorName);
            //        var FinishiData:[Finishinfo] = []
            FinishiData += [obj]
            // obj.confirmTime = a;
            //        var b: AnyObject?=value.objectForKey("customerEvaluate")
            //        finishinfo.customerEvaluate = b
            //        var c: AnyObject?=value.objectForKey("customerName")
            //        finishinfo.customerName = c
        }
    }
    return FinishiData
    
}



//orderNo:订单编号
//customerID：客户ID
//contactPhone：联系人电话
//facilitatorID：公司名字
//reason：申请理由
//money：退款金额

//退款申请
class RefundInfo:NSObject {
    var id:Int
    var orderNo:String
    var alipayOrderID:String
    var reason:String
    var money:Float
    
    var status:String
    var applyTime:String
    var confirmTime:String
    var refundDate:String
    var customerID:String
    
    var customerPhone:String
    var facilitatorID:String
    var batchNo:String
    

    init(id:Int,orderNo:String,alipayOrderID:String,reason:String,money:Float,status:String,
       applyTime:String,confirmTime:String,refundDate:String,customerID:String,customerPhone:String,facilitatorID:String,batchNo:String ){
        
            
            self.id = id
            self.orderNo = orderNo
            self.alipayOrderID = alipayOrderID
            self.reason = reason
            self.money = money
           
            self.status = status
            self.applyTime = applyTime
            self.confirmTime = confirmTime
            self.refundDate = refundDate
            self.customerID = customerID
           
       
            self.customerPhone = customerPhone
            self.facilitatorID = facilitatorID
            self.batchNo = batchNo
             
            super.init()
    }
    
}


//申请退款
func getRefund(orderNo:String,customerID:String,contactPhone:String,facilitatorID:String,reason:String,money:String) ->RefundInfo  {
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileRefundAction?operation=_apply")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"orderNo\":\"\(orderNo)\",\"customerID\":\"\(customerID)\",\"contactPhone\":\"\(contactPhone)\",\"facilitatorID\":\"\(facilitatorID)\",\"reason\":\"\(reason)\",\"money\":\"\(money)\"}"
    println("param:\(param)")
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    println("data:\(data)")
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
    
    
    var FinishiData:RefundInfo!
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var  response1 :String = test1 as! String
    if  response1 == "Success"{
        var value: AnyObject?=json.objectForKey("data")
//        let jsonArray = test2 as? NSArray
//        var count = jsonArray?.count
        
//        for value in jsonArray!{
            var id:Int=value!.objectForKey("id") as! Int
            var orderNo:String=value!.objectForKey("orderNo") as! String
            var alipayOrderID:String=value!.objectForKey("alipayOrderID") as! String
            var reason:String=value!.objectForKey("reason") as! String
            var money:Float=value!.objectForKey("money") as! Float
           
            
            var status:String=value!.objectForKey("status") as! String
            var applyTime:String=value!.objectForKey("applyTime") as! String
            var confirmTime:String=value!.objectForKey("confirmTime") as! String
            var refundDate:String=value!.objectForKey("refundDate") as! String
            var customerID:String=value!.objectForKey("customerID") as! String
             
            var customerPhone:String=value!.objectForKey("customerPhone") as! String
            var facilitatorID:String=value!.objectForKey("facilitatorID") as! String
            var batchNo:String=value!.objectForKey("batchNo") as! String
                         
            let obj:RefundInfo=RefundInfo(id:id,orderNo:orderNo,alipayOrderID:alipayOrderID,reason:reason,money:money,status:status,applyTime:applyTime,confirmTime:confirmTime,refundDate:refundDate,customerID:customerID,customerPhone:customerPhone,facilitatorID:facilitatorID,batchNo:batchNo)
                
             
            FinishiData = obj
         
//        }
    }
    return FinishiData
    
}
//是否申请成功
func QureyRefund(orderNo:String,customerID:String,contactPhone:String,facilitatorID:String,reason:String,money:String) ->String  {
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileRefundAction?operation=_apply")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"orderNo\":\"\(orderNo)\",\"customerID\":\"\(customerID)\",\"contactPhone\":\"\(contactPhone)\",\"facilitatorID\":\"\(facilitatorID)\",\"reason\":\"\(reason)\",\"money\":\"\(money)\"}"
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
    var  response1 :String = test1 as! String
    println("response1:\(response1)")
    return response1
    
}

//查询退款订单的详情

func RefundOrderDetail(orderNo:String) ->RefundInfo  {
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileRefundAction?operation=_query")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"orderNo\":\"\(orderNo)\"}"
    println("param:\(param)")
    var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    println("data:\(data)")
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
    
    
    var FinishiData:RefundInfo!
    var test1: AnyObject?=json.objectForKey("serverResponse")
    var  response1 :String = test1 as! String
    if  response1 == "Success"{
        var value: AnyObject?=json.objectForKey("data")
        //        let jsonArray = test2 as? NSArray
        //        var count = jsonArray?.count
        
        //        for value in jsonArray!{
        var id:Int=value!.objectForKey("id") as! Int
        var orderNo:String=value!.objectForKey("orderNo") as! String
        var alipayOrderID:String=value!.objectForKey("alipayOrderID") as! String
        var reason:String=value!.objectForKey("reason") as! String
        var money:Float=value!.objectForKey("money") as! Float
        
        
        var status:String=value!.objectForKey("status") as! String
        var applyTime:String=value!.objectForKey("applyTime") as! String
        var confirmTime:String=value!.objectForKey("confirmTime") as! String
        var refundDate:String=value!.objectForKey("refundDate") as! String
        var customerID:String=value!.objectForKey("customerID") as! String
        
        var customerPhone:String=value!.objectForKey("customerPhone") as! String
        var facilitatorID:String=value!.objectForKey("facilitatorID") as! String
        var batchNo:String=value!.objectForKey("batchNo") as! String
        
        let obj:RefundInfo=RefundInfo(id:id,orderNo:orderNo,alipayOrderID:alipayOrderID,reason:reason,money:money,status:status,applyTime:applyTime,confirmTime:confirmTime,refundDate:refundDate,customerID:customerID,customerPhone:customerPhone,facilitatorID:facilitatorID,batchNo:batchNo)
        
        
        FinishiData = obj
        
        //        }
    }
    return FinishiData
    
}

//更新退款信息
func UpdateRefund(orderNo:String,reason:String,money:String) ->String  {
    
    var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileRefundAction?operation=_update")
    
    var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
    
    request.HTTPMethod = "POST"
    //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
    var param:String = "{\"orderNo\":\"\(orderNo)\",\"reason\":\"\(reason)\",\"money\":\"\(money)\"}"
    println("param\(param)")
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
    var  response1 :String = test1 as! String
    println("response1:\(response1)")
    return response1
    
}
















