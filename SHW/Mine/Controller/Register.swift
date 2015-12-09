//
//  Register.swift
//  SHW
//
//  Created by Zhang on 15/8/5.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class Register: UIViewController,UITextFieldDelegate,UIAlertViewDelegate  {
    //获取textfield内容
    var textcontent:String = ""
    var Register = ["用户账号:", "联系电话:", "登录密码:","确认密码:"]
    var image = ["yonghuming","dianhua","mima","mima"]
    var terms:Int?
    //存储用户的输入
    var text = [String]()
    //输入框
    var customerID = UITextField()
    var phoneNo = UITextField()
    var loginPassword = UITextField()
    var Password = UITextField()
    //提示label
    var Label = UILabel()
    //声明导航条
    var navigationBar : UINavigationBar?
    //存储本地数据
    var customerid:String = ""
    var loginPwd:String = ""
    
    @IBAction func closekeyboard(sender: AnyObject) {
        self.view.endEditing(true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var pageWidth = self.view.frame.width
        var pageHeight = self.view.frame.height
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情")
//        onMakeNavitem()
        
        var terms = Register.count as Int
         //文本框内容改变时，触发
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
        
        
        //textField
        customerID = UITextField(frame: CGRectMake((CGFloat(135), CGFloat(12+64),CGFloat(pageWidth-150), CGFloat(34))))
        customerID.borderStyle = UITextBorderStyle.RoundedRect
        customerID.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        customerID.minimumFontSize=14
        customerID.becomeFirstResponder()
        customerID.placeholder = "6-20位,建议数字、字母组合"
        customerID.delegate = self //设置代理
        customerID.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        customerID.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        self.view.addSubview(customerID)
        Label = UILabel(frame: CGRectMake((CGFloat(145), CGFloat(112),CGFloat(pageWidth-150), CGFloat(15))))
        Label.font = UIFont.systemFontOfSize(13)
        Label.textColor = UIColor.redColor()
        self.view.addSubview(Label)
        phoneNo = UITextField(frame: CGRectMake((CGFloat(135), CGFloat(12+64+1*57),CGFloat(pageWidth-150), CGFloat(34))))
        phoneNo.borderStyle = UITextBorderStyle.RoundedRect
        phoneNo.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        phoneNo.minimumFontSize=14
        phoneNo.becomeFirstResponder()
        phoneNo.delegate = self //设置代理
        phoneNo.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        phoneNo.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        self.view.addSubview(phoneNo)
        
        loginPassword = UITextField(frame: CGRectMake((CGFloat(135), CGFloat(12+64+2*57),CGFloat(pageWidth-150), CGFloat(34))))
        loginPassword.borderStyle = UITextBorderStyle.RoundedRect
        loginPassword.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        loginPassword.minimumFontSize=14
        loginPassword.becomeFirstResponder()
        loginPassword.delegate = self //设置代理
        loginPassword.placeholder = "6-20位,建议数字、字母组合"
        loginPassword.secureTextEntry = true
        loginPassword.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        loginPassword.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        self.view.addSubview(loginPassword)
        
        Password = UITextField(frame: CGRectMake((CGFloat(135), CGFloat(12+64+3*57),CGFloat(pageWidth-150), CGFloat(34))))
        Password.borderStyle = UITextBorderStyle.RoundedRect
        Password.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        Password.minimumFontSize=14
        Password.becomeFirstResponder()
        Password.delegate = self //设置代理
        Password.placeholder = "请再次输入密码"
        Password.secureTextEntry = true
        Password.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        Password.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        self.view.addSubview(Password)



        // Do any additional setup after loading the view.
    }
    
    func setUserAgreement(){
        let  width = self.view.frame.width
      
        let label = UILabel(frame:CGRectMake(width/2-125, 155, 60, 30))
        label.textAlignment = NSTextAlignment.Left
        label.textColor = UIColor.grayColor()
        label.text = "阅读并接受"
        label.font = UIFont.systemFontOfSize(12)
        self.view.addSubview(label)
        
        let agreementButton = UIButton(frame:CGRectMake(width/2-75, 155, 150, 30))
        agreementButton.titleLabel!.textAlignment = NSTextAlignment.Left
        agreementButton.setTitle("<<生活网用户协议>>", forState: UIControlState.Normal)
        agreementButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        agreementButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        agreementButton.addTarget(self, action: "UserAgreement", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(agreementButton)
    }
    func UserAgreement(){
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("UserAgreementVC") as! UserAgreementVC
        
        self.navigationController!.pushViewController(vc, animated:true)
    }
    //通知事件
    func textDidChange(){
        var customerid = customerID.text
        //        var response = CheckID(customerid) as String
        //        println(response)
        var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileCustomerInfoAction?operation=_checkCustomerID")
        
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
        
        request.HTTPMethod = "POST"
        
        var param:String = "{\"customerID\":\"\(customerid)\"}"
        
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
        let serverResponse = dict!.objectForKey("serverResponse") as? String
        
        println("RserverResponse:\(serverResponse)")
        
        if serverResponse == "Failed"{
            
            Label.text = "该账号被占用！"
        }else if serverResponse == "Success"{
            Label.text = ""
        }
        
    }
    func tapped(button:UIButton){
    
//        if customerID.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 8 || customerID.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <  6{
        if !verifyPassword(customerID.text){
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入正确的用户账号"
            alert.addButtonWithTitle("确定")
            alert.show()
        }else if !verifymobilePhone(phoneNo.text){
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入正确的电话"
            alert.addButtonWithTitle("确定")
            alert.show()
        }else if !verifyPassword(loginPassword.text) {
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入正确的登录密码"
            alert.addButtonWithTitle("确定")
            alert.show()
            
            
        }else if Password.text != loginPassword.text{
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "两次密码输入不同!"
            alert.addButtonWithTitle("确定")
            alert.show()

        }else{
            
            var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileCustomerInfoAction?operation=_add")
            
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
            
            request.HTTPMethod = "POST"
        
            var param:String = "{\"customerID\":\"\(customerID.text)\",\"mobilePhone\":\"\(phoneNo.text)\",\"loginPassword\":\"\(loginPassword.text)\"}"
         
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
            var serverResponse: String?
            serverResponse = json!.objectForKey("serverResponse") as? String
            
            
            
            
            
            if serverResponse == "Success" {
                //self.performSegueWithIdentifier("", sender: self)
                let alert =  UIAlertView(title: "注册成功", message: "请登录", delegate: self, cancelButtonTitle: "确定")
                alert.delegate = self
                alert.show()
                alert.tag = 1
                customerid = customerID.text
                loginPwd = loginPassword.text
                saveNSUerDefaults ()
                
            }
            
            if serverResponse == "Failed"{
                
                let alert =  UIAlertView(title: "注册失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
            
          }
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
