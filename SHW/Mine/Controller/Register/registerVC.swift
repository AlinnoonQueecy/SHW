//
//  registerVC.swift
//  
//
//  Created by Zhang on 15/12/9.
//
//

import UIKit

class registerVC: UIViewController,UITextFieldDelegate,UIAlertViewDelegate {
    var phoneNo = UITextField()
    var identifyCode = UITextField()
    var  nextButton = UIButton()
     var  countButton  = ILCountDownButton()
    var  width :CGFloat = 0.0
    var  height :CGFloat = 0.0
    let  registerview = UIView()
    //声明导航条
    let   navigationBar1 =  UINavigationBar()
    let navigationBar2 =  UINavigationBar()
    //账号和密码
    //提示label
    var Label = UILabel()
    var customerID = UITextField()
    var loginPassword = UITextField()
    var loginButton = UIButton()
   let  registerviewtwo = UIView()
    
    var customerid:String = ""
    var loginPwd:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    
        width = self.view.frame.width
        height = self.view.frame.height
        self.view.backgroundColor = UIColor.whiteColor()
        registerView()

        registerview.hidden = false
        registerviewtwo.hidden = true
        landingView()
      
        //文本框内容改变时，触发
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
        //实例化导航条
//        navigationBar.frame = CGRectMake(0, 0, self.view.frame.width, 64)
       // self.view.addSubview(navigationBar)
//     registerview.addSubview(navigationBar)
//     registerviewtwo.addSubview(navigationBar)
        
    }
    
    
    func registerView(){
        
        
        registerview.frame = CGRectMake(0, 0, width, height)
        
        self.view.addSubview(registerview)
        
        
        navigationBar1.frame = CGRectMake(0, 0, self.view.frame.width, 64)
        onMakeNavitem()
        registerview.addSubview(navigationBar1)

        let y = CGFloat(64)
        let textlabel = UILabel(frame: CGRectMake((CGFloat(25), CGFloat(y+17),CGFloat(150), CGFloat(15))))
        textlabel.textColor = UIColor.orangeColor()
        textlabel.font = UIFont.systemFontOfSize(12)
        textlabel.text = "第一步:验证手机号"
        textlabel.textAlignment = NSTextAlignment.Left
    
        registerview.addSubview(textlabel)
        
        
        phoneNo = UITextField(frame: CGRectMake(25, y+35,width-50,30))
        phoneNo.borderStyle =  UITextBorderStyle.RoundedRect
        phoneNo.placeholder = "请输入手机号"
        phoneNo.becomeFirstResponder()
        phoneNo.font = UIFont.systemFontOfSize(14)
        
        phoneNo.clearButtonMode = UITextFieldViewMode.Always
        phoneNo.clearsOnBeginEditing = true
        registerview.addSubview(phoneNo)
 
        TimerButton()
        identifyCode = UITextField(frame: CGRectMake(25, y+80,width-140,30))
        identifyCode.placeholder = "请输入验证码"
        identifyCode.delegate = self
        identifyCode.borderStyle =  UITextBorderStyle.RoundedRect
        identifyCode.font = UIFont.systemFontOfSize(14)
        identifyCode.clearButtonMode = UITextFieldViewMode.Always
        identifyCode.clearsOnBeginEditing = true
        registerview.addSubview(identifyCode)
        
        
        let label = UILabel(frame:CGRectMake(25, y+120, 60, 30))
        label.textAlignment = NSTextAlignment.Left
        label.textColor = UIColor.grayColor()
        label.text = "阅读并接受"
        label.font = UIFont.systemFontOfSize(12)
        registerview.addSubview(label)
        
        let agreementButton = UIButton(frame:CGRectMake(85, y+120, 150, 30))
        agreementButton.titleLabel!.textAlignment = NSTextAlignment.Left
        agreementButton.setTitle("<<生活网用户协议>>", forState: UIControlState.Normal)
        agreementButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        agreementButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        agreementButton.addTarget(self, action: "UserAgreement", forControlEvents: UIControlEvents.TouchUpInside)
        registerview.addSubview(agreementButton)
        nextButton = UIButton(frame: CGRectMake(25, y+160, width-50, 30))
        nextButton.setTitle("下一步", forState: UIControlState.Normal)
        nextButton.backgroundColor = HttpData.grayColor
        nextButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        nextButton.showsTouchWhenHighlighted = true
        nextButton.addTarget(self , action: Selector("nextStep"), forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.layer.cornerRadius = 7
        nextButton.enabled = false
        registerview.addSubview(nextButton)
        
        
    }
    func TimerButton() {
        let y = CGFloat(64)
        let frame = CGRectMake(width-105, y+80, 80, 30)
        countButton = ILCountDownButton(count:30)
        countButton.frame = frame
      
        countButton.backgroundColor = UIColor.orangeColor()
        
        countButton.setTitleForRestart("获取验证码")
        countButton.layer.cornerRadius = 7.0
        countButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        countButton.addTarget(self, action: "Pressed", forControlEvents: UIControlEvents.TouchUpInside)
        registerview.addSubview(countButton)
        
    }
    func landingView(){
        
        
        registerviewtwo.frame = CGRectMake(0, 0, width, height)
        
        self.view.addSubview(registerviewtwo)
        
        navigationBar2.frame = CGRectMake(0, 0, self.view.frame.width, 64)
         MakeNavitem()
        registerviewtwo.addSubview(navigationBar2)
        let y = CGFloat(64)

        let textlabel = UILabel(frame: CGRectMake((CGFloat(25), CGFloat(y+17),CGFloat(150), CGFloat(15))))
        textlabel.textColor = UIColor.orangeColor()
        textlabel.font = UIFont.systemFontOfSize(12)
        textlabel.text = "第二步:设置账号与密码"
        textlabel.textAlignment = NSTextAlignment.Left
        
        registerviewtwo.addSubview(textlabel)
        
        
        
        
        Label = UILabel(frame: CGRectMake((CGFloat(75), CGFloat(y+40),CGFloat(150), CGFloat(15))))
        Label.font = UIFont.systemFontOfSize(12)
        Label.textColor = UIColor.redColor()
        registerviewtwo.addSubview(Label)
        
        
        let data = ["账号:","密码:"]
        
        for var i = 0;i < data.count;i++ {
            //label
            let label = UILabel(frame: CGRectMake((CGFloat(25), CGFloat(124+i*45),CGFloat(50), CGFloat(30))))
            label.text = data[i]
            label.textColor  = UIColor.grayColor()
            label.font = UIFont.systemFontOfSize(14)
            registerviewtwo.addSubview(label)
            
        }
        customerID = UITextField(frame: CGRectMake(75, y+60,width-100,30))
        customerID.borderStyle = UITextBorderStyle.RoundedRect
        customerID.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        customerID.minimumFontSize=11
        customerID.font = UIFont.systemFontOfSize(14)
        customerID.becomeFirstResponder()
        customerID.placeholder = "6-20位,建议数字、字母组合"
        customerID.delegate = self //设置代理
        customerID.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        customerID.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        
        registerviewtwo.addSubview(customerID)
        
        

        loginPassword = UITextField(frame: CGRectMake(75,y+105,width-100,30))
        loginPassword.borderStyle = UITextBorderStyle.RoundedRect
        loginPassword.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        loginPassword.minimumFontSize=14
        loginPassword.becomeFirstResponder()
        loginPassword.delegate = self //设置代理
        loginPassword.placeholder = "6-20位,建议数字、字母组合"
        loginPassword.font = UIFont.systemFontOfSize(14)
        loginPassword.secureTextEntry = true
        loginPassword.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        loginPassword.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        registerviewtwo.addSubview(loginPassword)
        
        loginButton = UIButton(frame: CGRectMake(25, y+150, width-50, 30))
        loginButton.setTitle("立即注册", forState: UIControlState.Normal)
        loginButton.backgroundColor = HttpData.grayColor
        loginButton.enabled = false
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        loginButton.showsTouchWhenHighlighted = true
        
        loginButton.addTarget(self , action: Selector("toRegister"), forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.layer.cornerRadius = 7
        registerviewtwo.addSubview(loginButton)
        
        
        
    }


    
 
    func UserAgreement(){
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("UserAgreementVC") as! UserAgreementVC
//        let  vc = UserAgreementVC()
//        self.navigationController!.pushViewController(vc, animated:true)
        self.presentViewController(vc, animated: true, completion: nil)
    }

    
    
    //获取验证码
    func  Pressed(){
        if  !verifymobilePhone(phoneNo.text) {
            
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入正确的电话"
            alert.addButtonWithTitle("确定")
            alert.show()
            
        }else {
            let  response = getCheckCode(phoneNo.text)
            if response == "Failed"{
                let alert =  UIAlertView(title: "该手机号已经注册过", message: "请直接登录", delegate: self, cancelButtonTitle: "确定")
                alert.delegate = self
                alert.show()
                
            }else if response == "Success" {
                countButton.restart()
                
            }
            
        }
        
        
    }
    //通知事件
    func textDidChange(){
        
        if verifymobilePhone(phoneNo.text)&&identifyCode.text != ""{
            
            nextButton.enabled = true
            nextButton.backgroundColor = UIColor.orangeColor()
            
        }
        customerid = customerID.text

        if customerid != ""{
            
            let url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileCustomerInfoAction?operation=_checkCustomerID")
            
            
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
            
            
            if serverResponse == "Failed"{
                
                Label.text = "该账号被占用！"
            }else if serverResponse == "Success"{
                Label.text = ""
                if loginPassword.text != ""&&customerID.text != ""{
                    
                    loginButton.backgroundColor = UIColor.orangeColor()
                    loginButton.enabled = true
                    
                }
                
            }

            
            
        }
    
        
        
    }
    func toRegister(){
        
        
        if !verifyPassword(customerID.text){
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入正确的用户账号"
            alert.addButtonWithTitle("确定")
            alert.show()
        }else if !verifyPassword(loginPassword.text) {
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入正确的登录密码"
            alert.addButtonWithTitle("确定")
            alert.show()
            
        }else{
            
            let serverResponse =  registerFunction(customerID.text,phoneNo.text,loginPassword.text)
            
            if serverResponse == "Success" {
              
                
                //注意
                //customerid = customerID.text
                //loginPwd = loginPassword.text
                customerid =  "yang123"
                loginPwd =  "123456"
       
                saveNSUerDefaults ()
                
            self.dismissViewControllerAnimated(true, completion: nil)
                
                
            }else if serverResponse == "Failed"{
                
                let alert =  UIAlertView(title: "注册失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
            
        }
        
    }

    
    func  nextStep(){
 

        let  response =  vetifyRegisterCode(phoneNo.text,identifyCode.text)
        
       if response == "Failed" {
            let alert =  UIAlertView(title: "该输入正确信息", message: "", delegate: self, cancelButtonTitle: "确定")
            alert.delegate = self
            alert.show()
        }else if response == "Success" {
       
//        let vc = NextStepVC()
//        vc.mobilePhone = phoneNo.text
////        self.navigationController!.pushViewController(vc, animated:true)
//        self.presentViewController(vc, animated: true, completion: nil)
        registerview.hidden = true
        println("wwwwwwwwwwwwwww")
        registerviewtwo.hidden = false
        
        
        }

        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //导航条详情
    func reply (){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func toLastStep(){
        registerview.hidden = false
        registerviewtwo.hidden = true
    }
    
    func onMakeNavitem() -> UINavigationItem{
        println("创建导航条step1")
        //创建一个导航项
        var navigationItem = UINavigationItem()
        //创建左边按钮
//        var leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        var leftButton =  UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "注册"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar1.pushNavigationItem(navigationItem, animated: true)
 
        return navigationItem
    }
    
    
    func MakeNavitem() -> UINavigationItem{
 
        //创建一个导航项
        var navigationItem = UINavigationItem()
 
        var leftButton =  UIBarButtonItem(title: "上一步", style: UIBarButtonItemStyle.Plain, target: self, action: "toLastStep")
         var rightButton =  UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "注册"
//        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        navigationItem.setRightBarButtonItem(rightButton, animated: true)
        navigationBar2.pushNavigationItem(navigationItem, animated: true)
        return navigationItem
    }
    

    //保存数据到NSUerDefaults
    func saveNSUerDefaults () {
        //将数据全部存储到NSUerDefaults中
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
        
        userDefaults.setObject( customerid , forKey: "customerID")
        userDefaults.setObject( loginPwd , forKey: "loginPassword")
        
        
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
