//
//  NextStepVC.swift
//  
//
//  Created by Zhang on 15/12/9.
//
//

import UIKit

class NextStepVC: UIViewController,UITextFieldDelegate,NSURLConnectionDataDelegate,UINavigationControllerDelegate {
    var customerid:String = ""
    var loginPwd:String = ""
  

    var  width :CGFloat = 0.0
    var  height :CGFloat = 0.0
    var  mobilePhone:String = ""
    //提示label
    var Label = UILabel()
    var customerID = UITextField()
    var loginPassword = UITextField()
    var loginButton = UIButton()

    //声明导航条
    let  navigationBar =  UINavigationBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置账号、密码"
        width = self.view.frame.width
        height = self.view.frame.height
        self.view.backgroundColor = UIColor.whiteColor()
        //文本框内容改变时，触发
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
        // Do any additional setup after loading the view.
        
        landingView()
        
        //实例化导航条
        navigationBar.frame = CGRectMake(0, 0, self.view.frame.width, 64)
        self.view.addSubview(navigationBar)
        onMakeNavitem()
    }
    
    
    func landingView(){
        let  registerview = UIView()
        registerview.frame = CGRectMake(0, 64, width, height)
        
        self.view.addSubview(registerview)
        let data = ["账号:","密码:"]
       
        for var i = 0;i < data.count;i++ {
            //label
            let label = UILabel(frame: CGRectMake((CGFloat(25), CGFloat(40+i*45),CGFloat(50), CGFloat(30))))
            label.text = data[i]
            label.textColor  = UIColor.grayColor()
            label.font = UIFont.systemFontOfSize(14)
           registerview.addSubview(label)
            
            
            
            
        }

        Label = UILabel(frame: CGRectMake((CGFloat(75), CGFloat(20),CGFloat(150), CGFloat(15))))
        Label.font = UIFont.systemFontOfSize(12)
        Label.textColor = UIColor.orangeColor()
        registerview.addSubview(Label)

        customerID = UITextField(frame: CGRectMake(75, 40,width-100,30))
        customerID.borderStyle = UITextBorderStyle.RoundedRect
        customerID.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        customerID.minimumFontSize=11
        customerID.font = UIFont.systemFontOfSize(14)
        customerID.becomeFirstResponder()
        customerID.placeholder = "6-20位,建议数字、字母组合"
        customerID.delegate = self //设置代理
        customerID.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        customerID.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页

        registerview.addSubview(customerID)
        
        loginPassword = UITextField(frame: CGRectMake(75, 85,width-100,30))
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
        registerview.addSubview(loginPassword)
        
        loginButton = UIButton(frame: CGRectMake(25, 135, width-50, 30))
        loginButton.setTitle("立即注册", forState: UIControlState.Normal)
        loginButton.backgroundColor = HttpData.grayColor
        loginButton.enabled = false
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        loginButton.showsTouchWhenHighlighted = true
        
        loginButton.addTarget(self , action: Selector("toRegister"), forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.layer.cornerRadius = 7
        registerview.addSubview(loginButton)
        
        
        
    }
    //通知事件
    func textDidChange(){
        
         customerid = customerID.text
      
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
            
            let serverResponse =  registerFunction(customerID.text,mobilePhone,loginPassword.text)
            
            if serverResponse == "Success" {
                //self.performSegueWithIdentifier("", sender: self)
             
          //注意
//                customerid = customerID.text
//                loginPwd = loginPassword.text
                customerid =  "yang123"
                loginPwd =  "123456"
                mobilePhone = "11182882378"
                saveNSUerDefaults ()
            
//              let vc = TabBarViewController()
//              self.presentViewController(vc, animated: false, completion: nil)
//                let vc = LoginVC()
//                self.navigationController?.popToViewController(vc, animated: true)
                
//                let sb = UIStoryboard(name: "Main", bundle: nil)
//                let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
//                self.navigationController?.delegate = self
                
//                 self.presentViewController(vc, animated: false, completion: nil)
                
//                self.navigationController?.popToRootViewControllerAnimated(true)
//                self.dismissViewControllerAnimated(true, completion: nil)
                
                let vc = LoginVC()
                self.presentViewController(vc, animated: true, completion: nil)
                
                
            }else if serverResponse == "Failed"{
                
                let alert =  UIAlertView(title: "注册失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
            
        }
        
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
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        navigationItem.title = "设置账号、密码"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        navigationBar.pushNavigationItem(navigationItem, animated: true)
        return navigationItem
    }


 
}
