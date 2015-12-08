//
//  LoginVC.swift
//  SHW
//
//  Created by star on 15/6/5.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate,NSURLConnectionDataDelegate {
 

 
    //接收是否成功
    var serverResponse:String?
 
    var customerid:String = ""
    var loginPwd:String = ""
    
    let  Quicklanding = UIView()
    let  Landing = UIView()
    var  width :CGFloat = 0.0
    var  height :CGFloat = 0.0
    var segmentedControl = UISegmentedControl()
    var phoneNo = UITextField()
    var identifyCode = UITextField()
    var customerID = UITextField()
    var  loginPassword = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
       // loginPassword.attributedPlaceholder  = attributeStr
       //loginPassword.placeholder = "hudaskjfslervhb"
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        width = self.view.frame.width
        height = self.view.frame.height
        self.view.backgroundColor = UIColor.whiteColor()
        //分段选择设置
        var arr = NSArray(objects: "快捷登陆","账户登录")
        var sw = width/2
        //分段选择标题
       segmentedControl = UISegmentedControl(items: arr as [AnyObject])
        segmentedControl.frame =  CGRectMake(0, 0,width, 50)
        //设置颜色
        segmentedControl.tintColor = UIColor.whiteColor()
        //自定义字体颜色和大小
        let  Selecteddic  = NSDictionary(dictionaryLiteral: (NSForegroundColorAttributeName,UIColor.orangeColor()),(NSFontAttributeName,UIFont(name:"AppleGothic",size: 16)!))
        //设置在某状态下（选中状态）
        segmentedControl.setTitleTextAttributes(Selecteddic as [NSObject : AnyObject], forState: UIControlState.Selected)
        var Normaldic  = NSDictionary(dictionaryLiteral: (NSForegroundColorAttributeName,UIColor.grayColor()),(NSFontAttributeName,UIFont(name:"AppleGothic",size: 16)!))
        //设置在某状态下（未选中状态）
        segmentedControl.setTitleTextAttributes(Normaldic as [NSObject : AnyObject], forState: UIControlState.Normal)
        //设置背景图片
        segmentedControl.setBackgroundImage(UIImage(named:"u4.png"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)//选中状态
        segmentedControl.setBackgroundImage(UIImage(named:"u4.png"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)//未选中状态
        //每个的宽度按segment的宽度平分
        segmentedControl.apportionsSegmentWidthsByContent =  true
        //选中第几个segment 一般用于初始化时选中
        segmentedControl.selectedSegmentIndex = 0
        self.view.addSubview(segmentedControl)//添加到父视图
        //添加事件
        segmentedControl.addTarget(self, action: "selected", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segmentedControl)
        
        self.view.addSubview(Landing)
        self.view.addSubview(Quicklanding)
        QuicklandingView()
    

 
    }
    
    func QuicklandingView(){
        
        Quicklanding.frame = CGRectMake(0, 50, width, height)
        
        phoneNo = UITextField(frame: CGRectMake(25, 20,width-50,30))
        phoneNo.borderStyle =  UITextBorderStyle.RoundedRect
        phoneNo.placeholder = "请输入手机号"
        phoneNo.font = UIFont.systemFontOfSize(14)

        phoneNo.clearButtonMode = UITextFieldViewMode.Always
        phoneNo.clearsOnBeginEditing = true
        Quicklanding.addSubview(phoneNo)
        TimerButton()
        identifyCode = UITextField(frame: CGRectMake(25, 65,width-140,30))
        identifyCode.placeholder = "请输入验证码"
        identifyCode.borderStyle =  UITextBorderStyle.RoundedRect
        identifyCode.font = UIFont.systemFontOfSize(14)
        identifyCode.clearButtonMode = UITextFieldViewMode.Always
        identifyCode.clearsOnBeginEditing = true
        Quicklanding.addSubview(identifyCode)
        
        let loginButton = UIButton(frame: CGRectMake(width/2-125, 120, 250, 30))
        loginButton.setTitle("立即登录", forState: UIControlState.Normal)
        loginButton.backgroundColor = UIColor.orangeColor()
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        loginButton.showsTouchWhenHighlighted = true
        loginButton.addTarget(self , action: Selector("QuickLogin:"), forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.layer.cornerRadius = 5.0
        Quicklanding.addSubview(loginButton)
        
        
        
    }
    func landingView(){
        
        Landing.frame = CGRectMake(0, 50, width, height)
        
        customerID = UITextField(frame: CGRectMake(25, 20,width-50,30))
        customerID.placeholder = "请输入账号"
        customerID.borderStyle =  UITextBorderStyle.RoundedRect
        customerID.font = UIFont.systemFontOfSize(14)
        customerID.clearButtonMode = UITextFieldViewMode.Always
        customerID.clearsOnBeginEditing = true
        Landing.addSubview(customerID)
 
        loginPassword = UITextField(frame: CGRectMake(25, 65,width-50,30))
        loginPassword.placeholder = "请输入密码"
        loginPassword.borderStyle =  UITextBorderStyle.RoundedRect
        loginPassword.font = UIFont.systemFontOfSize(14)
        loginPassword.clearButtonMode = UITextFieldViewMode.Always
        loginPassword.clearsOnBeginEditing = true
        //每输入一个字符就变成点 用语密码输入
        loginPassword.secureTextEntry = true
        Landing.addSubview(loginPassword)
        
        let loginButton = UIButton(frame: CGRectMake(width/2-125, 120, 250, 30))
        loginButton.setTitle("立即登录", forState: UIControlState.Normal)
        loginButton.backgroundColor = UIColor.orangeColor()
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        loginButton.showsTouchWhenHighlighted = true
        loginButton.addTarget(self , action: Selector("QuickLogin:"), forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.layer.cornerRadius = 5.0
        Landing.addSubview(loginButton)
        
        
        
    }
    

    func TimerButton() {
        let frame = CGRectMake(width-105, 65, 80, 30)
        let countButton = ILCountDownButton(count:30)
        countButton.frame = frame
//         countButton.setBackgroundImageForRestart(UIImage(named: "bk_restart")!)
//        countButton.setBackgroundImageForCount(UIImage(named: "uncheck.png")!)
        countButton.backgroundColor = UIColor.orangeColor()
        countButton.setTitleForRestart("获取验证码")
        countButton.layer.cornerRadius = 5.0
        countButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        countButton.addTarget(self, action: "Pressed:", forControlEvents: UIControlEvents.TouchUpInside)
        Quicklanding.addSubview(countButton)
        
    }

    
    //分段选择器的函数
    func selected() {
        //读取控件
        var x = segmentedControl.selectedSegmentIndex
        switch(x){
        case 0:
             QuicklandingView()
            Quicklanding.hidden = false
            Landing.hidden = true
            
            break
        default:
            Quicklanding.hidden = true
            landingView()
            Landing.hidden = false
            break
        }
        
        
    }
    
    
    func Pressed(countButton: UIButton) {
        println("倒计时开始")
    }



    func Login() {
        customerid = customerID.text
        loginPwd = loginPassword.text
        if customerID.text == ""{
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入用户账号"
            alert.addButtonWithTitle("确定")
            alert.show()
        }else if loginPassword.text == ""{
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入登录密码"
            alert.addButtonWithTitle("确定")
            alert.show()
            
        }else {
        var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileCustomerInfoAction?operation=_login")
         
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
        
        request.HTTPMethod = "POST"
        
        var param:String = "{\"customerID\":\"\(customerID.text)\",\"loginPassword\":\"\(loginPassword.text)\"}"
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
        
        let dict:AnyObject? = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        var dic = dict as! NSDictionary
        
        let serverResponse = dic.objectForKey("serverResponse") as? String
             if serverResponse == "Success"{
             saveNSUerDefaults ()
           
             self.navigationController?.popViewControllerAnimated(true)
//             self.dismissViewControllerAnimated(true, completion: nil)
        
           }else if serverResponse == "Failed"{
            
            let alert =  UIAlertView(title: "登录失败", message: "请输入正确的用户名和密码", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
      }
    }
    //保存数据到NSUerDefaults
    func saveNSUerDefaults () {
        //将数据全部存储到NSUerDefaults中
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
  
        userDefaults.setObject( customerID.text , forKey: "customerID")
        userDefaults.setObject( loginPassword.text , forKey: "loginPassword")
      
        
        //建议同步到磁盘，但不是必须得
        userDefaults.synchronize()
    }
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPwd = userDefaultes.stringForKey("loginPassword")!
              
        }
        
    }
 
   
  
 
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
             }
    override func viewWillAppear(animated: Bool) {
        
        loginPassword.delegate  = self
        customerID.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        loginPassword.delegate  = nil
        customerID.delegate = nil
    }

    
        
}