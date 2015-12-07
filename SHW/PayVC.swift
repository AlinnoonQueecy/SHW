//
//  PayVC.swift
//  SHW
//
//  Created by Zhang on 15/8/5.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit


class PayVC: UIViewController {
    //声明导航条
    var navigationBar : UINavigationBar?
 
    //读取本地数据
    var customerid:String =  ""
    var loginPassword:String = ""
         //获取网络数据
    var myinfo:MyInfo!
    //控件
    var servantID :UILabel?
    var dizhi  = UITextField()
    var dianhua = UITextField()
    var beizhu = UITextField()
    //声明Button
    var yuyue:UIButton?
    //接收上个界面传递的订单编号
    //var PayData:reserveInfo!
      var PayData:Finishinfo!
    var payinfo:PayInfo!
    let alipay:AlipayMethod = AlipayMethod()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        //初始化数据
        myinfo = QueryInfo(customerid) as MyInfo
        payinfo = PayInfo()
        var width = self.view.frame.width
        var height = self.view.frame.height
        var labelW = self.view.frame.width - 20
         //订单信息
        var orderY = CGFloat(0)
        var order = UIButton(frame: CGRectMake(15, orderY, width-30, 30))
        order.setTitle("支付信息", forState: UIControlState.Normal)
        order.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        order.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        order.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        order.titleLabel?.font = UIFont.systemFontOfSize(17)
        self.view.addSubview(order)
        
        var facilitatorID = UILabel(frame: CGRectMake(15, orderY+35, labelW, 25))
        facilitatorID.text = "订单编号:\(PayData!.orderNo)"
        facilitatorID.textColor = UIColor.blackColor()
        facilitatorID.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(facilitatorID)
        
        var servantName1 = UILabel(frame: CGRectMake(15, orderY+35+25, labelW, 25))
        servantName1.text = "支付金额:\(PayData.servicePrice)元"
        servantName1.textColor = UIColor.blackColor()
        servantName1.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(servantName1)
        
        //服务项目
        var itemName = UILabel(frame: CGRectMake(15, orderY+35+2*25, labelW, 25))
        itemName.text = "店铺名称:\(PayData.facilitatorName)"
        itemName.textColor = UIColor.blackColor()
        itemName.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(itemName)
        
        var customerInfoY  =  orderY+35+3*25+20
        var customerName = UILabel(frame: CGRectMake(15, customerInfoY, labelW, 25))
        customerName.text = "订单内容:\(PayData.serviceContent)"
        customerName.textColor = UIColor.blackColor()
        customerName.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(customerName)
        
        //预定按钮
        var CBY = self.view.frame.height-200
        yuyue = UIButton(frame:CGRectMake(width/2-125, CBY,250,30))
        yuyue! .setTitle("确认支付", forState:UIControlState.Normal)
        yuyue!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        yuyue!.titleLabel?.font = UIFont.systemFontOfSize(15)
        yuyue!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        yuyue!.showsTouchWhenHighlighted = true
        yuyue?.layer.cornerRadius = 5
        yuyue!.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(yuyue!)
        yuyue!.addTarget(self , action:Selector("yuding:"), forControlEvents: UIControlEvents.TouchUpInside)
        
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //支付的函数
    func yuding(yuyue:UIButton){
        
        var payid:String = PayData.orderNo as String
        var payname:String  = PayData.facilitatorName as String
        var paycontent:String = PayData.serviceContent as String
        var payprice:Float = PayData.servicePrice as Float
        println("Payinfo\(payinfo.payID)")
         println(payid)
         payinfo.payID  =  payid
         payinfo.payName = payname
         payinfo.payBody = paycontent
         payinfo.payPrice = payprice
          println("Payinfo.payID\(payinfo.payID)")
        
        AlipayMethod.pay(self.payinfo!, completion: { () -> Void in

            //self.navigationController?.popToRootViewControllerAnimated(true)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("finish") as! UIViewController
            self.presentViewController(vc, animated: false, completion: nil)

                   });
 
    }
    
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("reserve") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
    
    func getres(){
        var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation =_queryOrderByid")
        
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
        
        request.HTTPMethod = "POST"
        
        var param:String = "{\"id\":\"\(PayData.id)\" }"
        println("param")
        println(param)
        
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
        
        let json:AnyObject? = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        //        var dic = dict as! NSDictionary
        println(json)
        let serverResponse = json!.objectForKey("serverResponse") as? String
        var value: AnyObject?=json!.objectForKey("data")
        
        
        if serverResponse == "Success"{
            
            //            let alert =  UIAlertView(title: "预定成功", message: "商家会尽快与您取得联系!", delegate: self, cancelButtonTitle: "确定")
            //            alert.show()
            //
            //
            //        }else if serverResponse == "Failed"{
            //
            //            let alert =  UIAlertView(title: "预定失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
            //            alert.show()
            //
            //        }
            var status :String = value!.objectForKey("orderStatus") as! String
            if  status == "付款完成" {
                let alert =  UIAlertView(title: "", message: "请刷新列表", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
        }

    }
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onMakeNavitem() -> UINavigationItem{
        println("创建导航条step1")
        //创建一个导航项
        var navigationItem = UINavigationItem()
        //创建左边按钮
        var leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "支付详情"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    

    
}
