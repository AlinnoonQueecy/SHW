//
//  ChangePasswordVC.swift
//  SHW
//
//  Created by Zhang on 15/7/29.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController,UITextFieldDelegate {
    //声明导航条
    var navigationBar : UINavigationBar?
    //输入框
    var Originalpassword = UITextField()
    var Newpassword = UITextField()
    var Confirmpassword = UITextField()
    //传递过来的数
    var Password:String?
    var id :Int = 0
    
    var OriginalP:String = ""
    var NewP:String = ""
    var ConfirmP:String = ""
    //Label
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    //保存按钮
    var button = UIButton()
    //接收是否成功
    var serverResponse:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.whiteColor()
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情")
//        onMakeNavitem()
        // Do any additional setup after loading the view.
        var Register = ["原密码:","新密码:","确认密码:"]
        var image = [ "mima","mima","mima"]

        var terms = Register.count as Int
        for var i = 0;i < terms;i++ {
      
        var  image1 = UIImageView(frame:CGRectMake(CGFloat(15), CGFloat(20+i*60), CGFloat(34), CGFloat(34)))
            image1.image = UIImage(named:image[i])
        var label1 = UILabel(frame: CGRectMake((CGFloat(52), CGFloat(20+i*60),CGFloat(90), CGFloat(34))))
            label1.text = Register[i]
            self.view.addSubview(image1)
            self.view.addSubview(label1)
        }
        var pageWidth = self.view.frame.width
        button = UIButton(frame: CGRectMake(pageWidth/2-125, CGFloat(100+terms*60), 250, 30))
        button.setTitle("修改并保存", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.orangeColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.showsTouchWhenHighlighted = true
        button.layer.cornerRadius = 5
//        button.addTarget(self , action: Selector("tapped"), forControlEvents: UIControlEvents.TouchUpInside)  
        self.view.addSubview(button)
        
        let customY = 10
        //textField
         Originalpassword = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY),CGFloat(pageWidth-150), CGFloat(34))))
        Originalpassword.borderStyle = UITextBorderStyle.RoundedRect
      
        Originalpassword.minimumFontSize=14
        Originalpassword.becomeFirstResponder()
        Originalpassword.delegate = self //设置代理
        Originalpassword.clearButtonMode=UITextFieldViewMode.Always  //一直出现清除按钮
        Originalpassword.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        //scrollView.addSubview(customerID)
         Originalpassword.secureTextEntry = true
        self.view.addSubview(Originalpassword)
        label1 = UILabel(frame: CGRectMake((CGFloat(145), CGFloat(customY+37),CGFloat(pageWidth-150), CGFloat(20))))
        label1.font = UIFont.systemFontOfSize(13)
        label1.textColor = UIColor.redColor()
        self.view.addSubview(label1)
        Newpassword = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+1*60),CGFloat(pageWidth-150), CGFloat(34))))
        Newpassword.borderStyle = UITextBorderStyle.RoundedRect
        Newpassword.minimumFontSize=14
        Newpassword.becomeFirstResponder()
        Newpassword.delegate = self //设置代理
        Newpassword.clearButtonMode=UITextFieldViewMode.Always  //一直出现清除按钮
        Newpassword.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        //scrollView.addSubview(customerName)
        Newpassword.secureTextEntry = true

        self.view.addSubview(Newpassword)
        label2 = UILabel(frame: CGRectMake((CGFloat(145), CGFloat(customY+97),CGFloat(pageWidth-150), CGFloat(20))))
        label2.font = UIFont.systemFontOfSize(13)
        label2.textColor = UIColor.redColor()
        self.view.addSubview(label2)
        Confirmpassword = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+2*60),CGFloat(pageWidth-150), CGFloat(34))))
        Confirmpassword.borderStyle = UITextBorderStyle.RoundedRect
        Confirmpassword.minimumFontSize=14
        Confirmpassword.becomeFirstResponder()
        Confirmpassword.delegate = self //设置代理
        Confirmpassword.clearButtonMode=UITextFieldViewMode.Always  //一直出现清除按钮
        Confirmpassword.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        //scrollView.addSubview(customerName)
        Confirmpassword.secureTextEntry = true

        self.view.addSubview(Confirmpassword)
        label3 = UILabel(frame: CGRectMake((CGFloat(145), CGFloat(customY+157),CGFloat(pageWidth-150), CGFloat(20))))
        label3.font = UIFont.systemFontOfSize(13)
        label3.textColor = UIColor.redColor()
        self.view.addSubview(label3)
        //文本框编辑结束时，触发
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidEndEditing", name: UITextFieldTextDidEndEditingNotification, object: nil)
        //文本框内容改变时，触发
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
        


    }
    //保存函数
    func tapped(){
        
//        serverResponse = ChangePassword(id, OriginalP, NewP) as  String
//        println("serverResponse是"+serverResponse!)
        var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileCustomerInfoAction?operation=_modifyPWD")
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
        
        request.HTTPMethod = "POST"
        
        var param:String = "{\"id\":\"\(id)\",\"oldpwd\":\"\(OriginalP)\",\"newpwd\":\"\(NewP)\"}"
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
            println("jsonString")
            println(jsonString)
            
        }

        let dict:AnyObject? = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        var dic = dict as! NSDictionary
        let serverResponse = dic.objectForKey("serverResponse") as? String
        if serverResponse == "Success"{
            //self.performSegueWithIdentifier("LoginTo", sender: self)
            let alert =  UIAlertView(title: "修改成功", message: "", delegate: self, cancelButtonTitle: "确定")
            alert.tag = 1
            alert.show()
            saveNSUerDefaults ()
            
        }
        
        if serverResponse == "Failed"{
            
            let alert =  UIAlertView(title: "修改失败", message: "请重新输入", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
        

    }
    
    
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (alertView.tag == 1) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    //编辑结束时启动
    func textFieldDidEndEditing(Confirmpassword: UITextField) {
        println("你好啊啊啊啊啊")
        
     
    
        }
    //通知事件

        func textDidEndEditing(){
         OriginalP = Originalpassword.text
         NewP = Newpassword.text
//         ConfirmP = Confirmpassword.text
         println( OriginalP)
        println(Password)
        if OriginalP != Password {
            println(Password)
            label1.text = "原密码不正确！"
        }else {
            label1.text = ""
//            if NewP!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 6{
//                 label2.text = "请输入六位密码！"
//            }else if NewP == OriginalP{
//                label2.text = "和原密码相同！"
//        
//           }else {
//                label2.text = ""
//                if NewP != ConfirmP {
//                    label3.text = "密码不一致"
//                }else{
//                    button.addTarget(self , action: Selector("tapped"), forControlEvents: UIControlEvents.TouchUpInside)
//                    
//                }
        //    }
        }
     
      }
    func textDidChange(){
        NewP = Newpassword.text
        ConfirmP = Confirmpassword.text
        if !verifyPassword(NewP){
            label2.text = "请输入由6-20位数组、字母组成的密码！"
        }else if NewP == OriginalP{
            label2.text = "和原密码相同！"
        
        }else {
            label2.text = ""
            if NewP != ConfirmP {
                label3.text = "密码不一致"
            }else{
                label3.text = ""
                button.addTarget(self , action: Selector("tapped"), forControlEvents: UIControlEvents.TouchUpInside)
                            
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
        //userDefaults.setObject( customerid , forKey: "customerID")
        userDefaults.setObject( NewP, forKey: "loginPassword")
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
