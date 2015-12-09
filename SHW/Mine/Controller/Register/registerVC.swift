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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        width = self.view.frame.width
        height = self.view.frame.height
        self.view.backgroundColor = UIColor.whiteColor()
        registerView()
        //文本框内容改变时，触发
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    
    func registerView(){
        
      
        
        phoneNo = UITextField(frame: CGRectMake(25, 20,width-50,30))
        phoneNo.borderStyle =  UITextBorderStyle.RoundedRect
        phoneNo.placeholder = "请输入手机号"
        phoneNo.becomeFirstResponder()
        phoneNo.font = UIFont.systemFontOfSize(14)
        
        phoneNo.clearButtonMode = UITextFieldViewMode.Always
        phoneNo.clearsOnBeginEditing = true
        self.view.addSubview(phoneNo)
 
        TimerButton()
        identifyCode = UITextField(frame: CGRectMake(25, 65,width-140,30))
        identifyCode.placeholder = "请输入验证码"
        identifyCode.delegate = self
        identifyCode.borderStyle =  UITextBorderStyle.RoundedRect
        identifyCode.font = UIFont.systemFontOfSize(14)
        identifyCode.clearButtonMode = UITextFieldViewMode.Always
        identifyCode.clearsOnBeginEditing = true
        self.view.addSubview(identifyCode)

        nextButton = UIButton(frame: CGRectMake(25, 140, width-50, 30))
        nextButton.setTitle("下一步", forState: UIControlState.Normal)
        nextButton.backgroundColor = HttpData.grayColor
        nextButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        nextButton.showsTouchWhenHighlighted = true
        nextButton.addTarget(self , action: Selector("nextStep"), forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.layer.cornerRadius = 7
        nextButton.enabled = false
        self.view.addSubview(nextButton)
        setUserAgreement()
        
    }
    func TimerButton() {
        let frame = CGRectMake(width-105, 65, 80, 30)
        countButton = ILCountDownButton(count:30)
        countButton.frame = frame
        //         countButton.setBackgroundImageForRestart(UIImage(named: "choose_btn_highlighted")!)
        //        countButton.setBackgroundImageForCount(UIImage(named: "choosed_btn")!)
        countButton.backgroundColor = UIColor.orangeColor()
        
        countButton.setTitleForRestart("获取验证码")
        countButton.layer.cornerRadius = 7.0
        countButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        countButton.addTarget(self, action: "Pressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(countButton)
        
    }
    
    func setUserAgreement(){
        let label = UILabel(frame:CGRectMake(25, 100, 60, 30))
        label.textAlignment = NSTextAlignment.Left
        label.textColor = UIColor.grayColor()
        label.text = "阅读并接受"
        label.font = UIFont.systemFontOfSize(12)
        self.view.addSubview(label)
        
        let agreementButton = UIButton(frame:CGRectMake(85, 100, 150, 30))
        agreementButton.titleLabel!.textAlignment = NSTextAlignment.Left
        agreementButton.setTitle("<<生活网用户协议>>", forState: UIControlState.Normal)
        agreementButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        agreementButton.titleLabel!.font = UIFont.systemFontOfSize(12)
        agreementButton.addTarget(self, action: "UserAgreement", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(agreementButton)
    }
    func UserAgreement(){
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewControllerWithIdentifier("UserAgreementVC") as! UserAgreementVC
        let  vc = UserAgreementVC()
        self.navigationController!.pushViewController(vc, animated:true)
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
    
        
        
    }
    
    
    func  nextStep(){
        

        let  response =  vetifyRegisterCode(phoneNo.text,identifyCode.text)
        
       if response == "Failed" {
            let alert =  UIAlertView(title: "该输入正确信息", message: "", delegate: self, cancelButtonTitle: "确定")
            alert.delegate = self
            alert.show()
        }else if response == "Success" {
       
        let vc = NextStepVC()
        vc.mobilePhone = phoneNo.text
        self.navigationController!.pushViewController(vc, animated:true)
        
        }

        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
