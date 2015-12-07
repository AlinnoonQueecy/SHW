//
//  LoginVC.swift
//  SHW
//
//  Created by star on 15/6/5.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate,NSURLConnectionDataDelegate {
    @IBOutlet weak var customerID: UITextField!
    
    @IBOutlet weak var loginPassword: UITextField!
    
 
   
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var getmima: UIButton!

 
    //接收是否成功
    var serverResponse:String?
 
    var customerid:String = ""
    var loginPwd:String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
       // loginPassword.attributedPlaceholder  = attributeStr
       //loginPassword.placeholder = "hudaskjfslervhb"
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
 
     
        //输入框中一开始就有的文字
        loginPassword.placeholder = "请输入密码"
        customerID.placeholder = "请输入用户名"
        //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
//        customerID.clearButtonMode = UITextFieldViewMode.UnlessEditing
        loginPassword.clearButtonMode = UITextFieldViewMode.Always//一直出现
        //再次编辑就清空
        loginPassword.clearsOnBeginEditing = true
        //每输入一个字符就变成点 用语密码输入
        loginPassword.secureTextEntry = true
        
    }
    
    
 

    @IBAction func Login(sender: AnyObject) {
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
        println("保存本地")
        println( customerID.text )
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

    override func  viewDidLayoutSubviews() {
        var width  = self.view.frame.width
        var height = self.view.frame.height
        
        //name.frame = CGRectMake(9, 105, 60, 30)
        customerID.frame = CGRectMake(30, 105, width-50, 30)
        //mima.frame = CGRectMake(9, 168, 60, 30)
        loginPassword.frame = CGRectMake(30, 168, width-50, 30)
        register.frame = CGRectMake(9, 340, 60, 30)
        getmima.frame = CGRectMake(width-80, 340, 60, 30)
        
        
    }
   
    @IBAction func touchView(sender: AnyObject) {
       
        self.view.endEditing(true)
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