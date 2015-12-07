//
//  EvaluateVC.swift
//  SHW
//
//  Created by Zhang on 15/8/6.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class EvaluateVC: UIViewController,UIAlertViewDelegate {

    //声明导航条
    var navigationBar : UINavigationBar?
    //接收上个界面传递的数据
    var EvaluateData:Finishinfo!
    //BUtton
    var Button1 = UIButton()
    var Button2 = UIButton()
    var Button3 = UIButton()
    var Button4 = UIButton()
    var Button5 = UIButton()
    
    var EvaluateS = UIButton()
    var Button6 = UIButton()
    var Button7 = UIButton()
    var Button8 = UIButton()
    var tijiao = UIButton()
    //UIAlertView
    var alert1 =  UIAlertView()
    var alert2 =  UIAlertView()
    
    //存储分数的变量
    var n:String = "+5"
    var evaluation:String = "好评"
    
    var buttonC = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
 
        var width = self.view.frame.width
        var  height = self.view.frame.height
        var  EvaluateY = CGFloat(0)
        var Evaluate = UIButton(frame: CGRectMake(15, EvaluateY, width, 25))
        Evaluate.setTitle("店铺评分:", forState: UIControlState.Normal)
        Evaluate.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        Evaluate.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        Evaluate.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        Evaluate.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(Evaluate)
        
        var BuW = (width - 30)/5-4
        var BuW1 = (width - 30)/5
        var BuY = CGFloat(25)
     

        Button1 = UIButton(frame: CGRectMake(15, BuY, BuW, 25))
        Button1.setTitle("+5", forState: UIControlState.Normal)
        Button1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button1.backgroundColor = buttonC
        Button1.addTarget(self , action: Selector("tapped1:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button1)
        
        Button2 = UIButton(frame: CGRectMake(15+BuW1, BuY, BuW, 25))
        Button2.setTitle("+3", forState: UIControlState.Normal)
        Button2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button2.backgroundColor = buttonC
        Button2.addTarget(self , action: Selector("tapped2:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button2)
        
        Button3 = UIButton(frame: CGRectMake(15+2*BuW1, BuY, BuW, 25))
        Button3.setTitle("0", forState: UIControlState.Normal)
        Button3.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button3.backgroundColor = buttonC
        Button3.addTarget(self , action: Selector("tapped3:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button3)
        
        Button4 = UIButton(frame: CGRectMake(15+3*BuW1, BuY, BuW, 25))
        Button4.setTitle("-3", forState: UIControlState.Normal)
        Button4.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button4.backgroundColor = buttonC
        Button4.addTarget(self , action: Selector("tapped4:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button4)
        
        Button5 = UIButton(frame: CGRectMake(15+4*BuW1, BuY, BuW, 25))
        Button5.setTitle("-5", forState: UIControlState.Normal)
        Button5.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button5.backgroundColor = buttonC
        Button5.addTarget(self , action: Selector("tapped5:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button5)
        
        var  EvaluateSY = BuY + 35
        if EvaluateData.servantID != ""{
        EvaluateS = UIButton(frame: CGRectMake(15, EvaluateSY, width, 25))
        EvaluateS.setTitle("人员评价:", forState: UIControlState.Normal)
        EvaluateS.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        EvaluateS.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        EvaluateS.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        EvaluateS.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(EvaluateS)
        
        
        var  Bu6Y = EvaluateSY+35
        var  Bu6W = (width-30)/3 - 4
        Button6 = UIButton(frame: CGRectMake(15, Bu6Y, Bu6W, 25))
        Button6.setTitle("好评", forState: UIControlState.Normal)
        Button6.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button6.backgroundColor = buttonC
        Button6.addTarget(self , action: Selector("tapped6:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button6)
        
        Button7 = UIButton(frame: CGRectMake(15+Bu6W+4, Bu6Y, Bu6W, 25))
        Button7.setTitle("中评", forState: UIControlState.Normal)
        Button7.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button7.backgroundColor = buttonC
        Button7.addTarget(self , action: Selector("tapped7:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button7)
        
        Button8 = UIButton(frame: CGRectMake(15+2*Bu6W+8, Bu6Y, Bu6W, 25))
        Button8.setTitle("差评", forState: UIControlState.Normal)
        Button8.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        Button8.backgroundColor = buttonC
        Button8.addTarget(self , action: Selector("tapped8:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(Button8)
        }else{
            EvaluateS.hidden = true
            Button6.hidden = true
            Button7.hidden = true
            Button8.hidden = true
        }
        
        
        tijiao = UIButton(frame: CGRectMake(width/2-125,height-200, 250, 30))
        tijiao.setTitle("确认提交", forState: UIControlState.Normal)
        tijiao.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tijiao.backgroundColor = UIColor.orangeColor()
        tijiao.layer.cornerRadius = 5
        tijiao.addTarget(self , action: Selector("tapped9:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(tijiao)
        
    }
    
    
    func tapped1(Button1:UIButton){
        Button1.backgroundColor = UIColor.orangeColor()
        Button2.backgroundColor = buttonC
        Button3.backgroundColor = buttonC
        Button4.backgroundColor = buttonC
        Button5.backgroundColor = buttonC
        n = "5"
        
    }
    func tapped2(Button2:UIButton){
        Button2.backgroundColor = UIColor.orangeColor()
        Button1.backgroundColor = buttonC
        Button3.backgroundColor = buttonC
        Button4.backgroundColor = buttonC
        Button5.backgroundColor = buttonC
        n = "3"
        
    }
    func tapped3(Button3:UIButton){
        Button3.backgroundColor = UIColor.orangeColor()
        Button1.backgroundColor = buttonC
        Button2.backgroundColor = buttonC
        Button4.backgroundColor = buttonC
        Button5.backgroundColor = buttonC
        n = "0"
        
    }
    func tapped4(Button4:UIButton){
        Button4.backgroundColor = UIColor.orangeColor()
        Button1.backgroundColor = buttonC
        Button3.backgroundColor = buttonC
        Button2.backgroundColor = buttonC
        Button5.backgroundColor = buttonC
        n = "-3"
        
    }

    func tapped5(Button5:UIButton){
        Button5.backgroundColor = UIColor.orangeColor()
        Button1.backgroundColor = buttonC
        Button3.backgroundColor = buttonC
        Button4.backgroundColor = buttonC
        Button2.backgroundColor = buttonC
        n = "-5"
        
    }
    func tapped6(Button6:UIButton){
        Button6.backgroundColor = UIColor.orangeColor()
        Button7.backgroundColor = buttonC
        Button8.backgroundColor = buttonC
        evaluation = "好评"
        
    }
   
    func tapped7(Button7:UIButton){
        Button7.backgroundColor = UIColor.orangeColor()
        Button6.backgroundColor = buttonC
        Button8.backgroundColor = buttonC
        evaluation = "中评"
        
    }
    func tapped8(Button8:UIButton){
        Button8.backgroundColor = UIColor.orangeColor()
        Button7.backgroundColor = buttonC
        Button6.backgroundColor = buttonC
        evaluation = "差评"
        
    }
    
    func tapped9(Button9:UIButton){
   
       //调评价接口
        var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_comment")
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
        
        request.HTTPMethod = "POST"
         println("typeName")
//        println(EvaluateData.id)
        var param:String = "{\"id\":\"\(EvaluateData.id)\",\"creditScore\":\"\(n)\"}"
        
        if EvaluateData.servantID != "" {
            
          param = "{\"id\":\"\(EvaluateData.id)\",\"creditScore\":\"\(n)\",\"commentContent\":\"\(evaluation)\"}"
            
        }else {
            
         param = "{\"id\":\"\(EvaluateData.id)\",\"creditScore\":\"\(n)\"}"
            
        }
        println( param)
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
        
        var serviceresponse = json.objectForKey("serverResponse") as? String
        if serviceresponse == "Success"{
            alert1 =  UIAlertView(title: "提交成功", message: "", delegate: self, cancelButtonTitle: "确定")
            alert1.tag = 1
            alert1.show()
            
            
            
        } else if serviceresponse == "Failed"{
            
            alert2 =  UIAlertView(title: "提交失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
            alert2.tag = 2
            alert2.show()
            
        }

        
    }
    //UIAlert触发函数
 
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (alertView.tag == 1) {
            println("成功")
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("finish") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        }else{
            println("失败")
//        self.performSegueWithIdentifier("back", sender: self)
        self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}
