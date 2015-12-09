//
//  BaseInfoVC.swift
//  SHW
//
//  Created by Zhang on 15/7/29.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class BaseInfoVC: UIViewController,UITextFieldDelegate,NSURLConnectionDataDelegate,UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate{

    
    var textcontent:String = ""
    //读取本地数据
    var customerid:String  = ""
    var loginPassword:String = ""
    var Gender =  ["男","女"]//声明点击女还是男
    var selectGender:String!
    //筛选和排序
    var  row0   =  0
    var currentData1Index : Int = 0
    var data1 :[String] = []
    // var Register = ["用户账号:","用户姓名:","用户性别:","出生日期:","身份证号:","联系电话:","电子邮箱:","所在地:","联系地址:"]
    var Register = ["用户名:","昵称:","性别:","出生日期:","座机号码","联系电话:","电子邮箱:","QQ号码:","所在地:","联系地址:"]
    var image = ["yonghuming","yonghuming","nianling","IDCard","dianhua","dianhua","youjian","youjian","dizhi","dizhi"]
    
    //var scrollView = UIScrollView()
    
    var terms:Int?
    //存储用户的输入
    var text = [String]()
    //输入框
    
    var customerID = UILabel()
    var customerName = UITextField()
    var customerGender = UITextField()
    var customerBirthday = UITextField()
    var datePicker: UIDatePicker!
    var pickview:UIPickerView!
    var Genderpick:UIPickerView!
    
    var indexPath:NSIndexPath!
    var phoneNo = UITextField()//座机号码
    var mobilePhone = UITextField()//联系电话
    var emailAddress = UITextField()
    var qqNumber = UITextField()
    var dizhi = UITextField()
    var contactAddress = UITextField()
    //存储查询的用户信息
    var  Info:MyInfo!
    
    
    //选择的城市和地区
    var  selectprovince:String!
    var selectcity:String!
    var  selectcounty:String!
    
    var root:NSArray = []
    var provinces:NSArray = []
    var  dictionary1:NSDictionary!
    var province:String = ""
    var cities:NSArray = []
    var areas:NSArray = []
    
    var scrollView = UIScrollView()
    var pageWidth:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        pageWidth = self.view.frame.width
        var pageHeight = self.view.frame.height
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        //查询用户信息
        Info = QueryInfo(customerid) as MyInfo
        
        // ScrollView详情
        scrollView.frame = CGRectMake(0, 0, pageWidth, pageHeight)
        scrollView.contentSize=CGSizeMake(pageWidth, pageHeight*3)
        scrollView.contentInset = UIEdgeInsetsMake(0,0,-49, 0)
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.delegate = self
        scrollView.pagingEnabled = false
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        self.view.addSubview(scrollView)
        
        //1、创建手势实例，并连接方法UITapGestureRecognizer,点击手势
        var recognizer =  UITapGestureRecognizer(target:self, action:"touchScrollView:")
        println("touchScrollView")
        
        //设置手势点击数,点1下
        recognizer.numberOfTapsRequired = 1
        
        //recognizer.numberOfTouchesRequired = 1
        
        scrollView.addGestureRecognizer(recognizer)
        NSNotificationCenter.defaultCenter().addObserver(self,selector:Selector("keyboardWillShow:"),name:UIKeyboardWillShowNotification,object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self,selector:Selector("keyboardWillHide:"),name:UIKeyboardWillHideNotification,object:nil)
        
        //image,label,textfield 的设置
        var terms = Register.count as Int
        for var i = 0;i < terms;i++ {
            //image
            var  image1 = UIImageView(frame:CGRectMake(CGFloat(15), CGFloat(12+i*37), CGFloat(34), CGFloat(34)))
            image1.image = UIImage(named:image[i])
            //label
            var label1 = UILabel(frame: CGRectMake((CGFloat(52), CGFloat(12+i*37),CGFloat(90), CGFloat(34))))
            label1.text = Register[i]
            
            
            var button = UIButton(frame: CGRectMake(pageWidth/2-125, CGFloat(50+terms*37), 250, 30))
            button.setTitle("修改并保存", forState: UIControlState.Normal)
            button.backgroundColor = UIColor.orangeColor()
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.showsTouchWhenHighlighted = true
            button.addTarget(self , action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
            button.layer.cornerRadius = 5.0
            
            
            scrollView.addSubview(image1)
            
            scrollView.addSubview(label1)
            scrollView.addSubview(button)
            
            
        }
        
        
        
        
        
        let customY = 12
        //textField
        customerID.frame = CGRectMake((CGFloat(145), CGFloat(customY),CGFloat(pageWidth-150), CGFloat(34)))
        
        customerID.text = Info.customerID
        scrollView.addSubview(customerID)
        
        
        customerName = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(12+1*37),CGFloat(pageWidth-150), CGFloat(34))))
        customerName.borderStyle = UITextBorderStyle.RoundedRect
        customerName.text = Info.customerName
        customerName.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        customerName.minimumFontSize=14
        customerName.becomeFirstResponder()
        customerName.delegate = self //设置代理
        customerName.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        customerName.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        scrollView.addSubview(customerName)
        // self.view.addSubview(customerName)
        
        
        Genderpick = UIPickerView(frame: CGRectMake(0,300, self.view.frame.width, 300))
        Genderpick.delegate = self
        Genderpick.dataSource = self
        Genderpick.tag = 1
        
        let f = Genderpick.frame
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, f.width, (f.height * 0.15)))
        var buttons = [UIBarButtonItem]()
        var space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        buttons.append(space)
        let doneButton = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Plain, target: self, action: "donePressed")
        buttons.append(doneButton)
        toolbar.setItems(buttons, animated: false)
        
        customerGender = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+2*37),CGFloat(pageWidth-150), CGFloat(34))))
        customerGender.borderStyle = UITextBorderStyle.RoundedRect
        customerGender.text = Info.customerGender
        customerGender.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        customerGender.minimumFontSize=14
        customerGender.becomeFirstResponder()
        customerGender.delegate = self //设置代理
        customerGender.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        customerGender.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        customerGender.inputView = Genderpick
        customerGender.inputAccessoryView = toolbar
        scrollView.addSubview(customerGender)
    
        
        
        customerBirthday = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+3*37),CGFloat(pageWidth-150), CGFloat(34))))
        customerBirthday.borderStyle = UITextBorderStyle.RoundedRect
        customerBirthday.text = Info.customerBirthday
        customerBirthday.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        customerBirthday.minimumFontSize=14
        //        customerBirthday.becomeFirstResponder()
        customerBirthday.delegate = self //设置代理
        customerBirthday.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        customerBirthday.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        
        
        //self.view.addSubview(customerBirthday)
        
        // 初始化 datePicker
        datePicker = UIDatePicker(frame: CGRectMake(0,300, self.view.frame.width, 300))
        // 设置样式，当前设为同时显示日期
        datePicker.datePickerMode = UIDatePickerMode.Date
        // datePicker.hidden = true
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        // 设置分钟表盘的时间间隔（必须能让60整除，默认是1分钟）
        //        datePicker.minuteInterval = 5
        // 设置日期范围（超过日期范围，会回滚到最近的有效日期）
        //        var dateFormatter = NSDateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        //        var maxDate = dateFormatter.dateFromString("2015-08-01 08:00:00")
        //        var minDate = dateFormatter.dateFromString("2015-03-01 08:00:00")
        //        datePicker.maximumDate = maxDate
        //        datePicker.minimumDate = minDate
        // 设置默认时间
        datePicker.date = NSDate()
        
        // 响应事件（只要滚轮变化就会触发）
        // datePicker.addTarget(self, action:Selector("datePickerValueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        // scrollView.addSubview(datePicker)
        //添加ToolBar（可以不要）
        
        customerBirthday.inputView = datePicker
        customerBirthday.inputAccessoryView = toolbar
        scrollView.addSubview(customerBirthday)
        
        
        
        //座机电话
        phoneNo = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+4*37),CGFloat(pageWidth-150), CGFloat(34))))
        phoneNo.borderStyle = UITextBorderStyle.RoundedRect
        phoneNo.text = Info.phoneNo
        phoneNo.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        phoneNo.minimumFontSize=14
        phoneNo.becomeFirstResponder()
        phoneNo.delegate = self //设置代理
        phoneNo.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        phoneNo.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        scrollView.addSubview(phoneNo)
        //self.view.addSubview(phoneNo)
        
        //联系号码
        mobilePhone = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+5*37),CGFloat(pageWidth-150), CGFloat(34))))
        mobilePhone.borderStyle = UITextBorderStyle.RoundedRect
        mobilePhone.text = Info.mobilePhone
        mobilePhone.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        mobilePhone.minimumFontSize=14
        mobilePhone.becomeFirstResponder()
        mobilePhone.delegate = self //设置代理
        mobilePhone.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        mobilePhone.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        scrollView.addSubview(mobilePhone)
        //self.view.addSubview(idCardNo)
        
        
        
        
        
        emailAddress = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+6*37),CGFloat(pageWidth-150), CGFloat(34))))
        emailAddress.borderStyle = UITextBorderStyle.RoundedRect
        emailAddress.text = Info.emailAddress
        emailAddress.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        emailAddress.minimumFontSize=14
        emailAddress.becomeFirstResponder()
        emailAddress.delegate = self //设置代理
        emailAddress.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        emailAddress.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        scrollView.addSubview(emailAddress)
        //self.view.addSubview(emailAddress)
        //
        qqNumber = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+7*37),CGFloat(pageWidth-150), CGFloat(34))))
        qqNumber.borderStyle = UITextBorderStyle.RoundedRect
        qqNumber.text = Info.qqNumber
        qqNumber.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        qqNumber.minimumFontSize=14
        qqNumber.becomeFirstResponder()
        qqNumber.delegate = self //设置代理
        qqNumber.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        qqNumber.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        scrollView.addSubview(qqNumber)
        //        self.view.addSubview(text7)
        
        
        
        pickview = UIPickerView()
        pickview.tag = 2
        pickview.delegate = self
        pickview.dataSource = self
        let listPath  = NSBundle.mainBundle().pathForResource("area.plist", ofType: nil)
        //第一层
        
        root =  NSMutableArray(contentsOfFile:listPath!)!//root
        
        dictionary1 = root.objectAtIndex(0) as! NSDictionary//item0
        //第二层
        
        cities = dictionary1.objectForKey("cities") as! NSArray
        
        let dictionary2:NSDictionary =  cities.objectAtIndex(0) as! NSDictionary
        //第三层
        
        areas = dictionary2.objectForKey("areas") as! NSArray
        
        dizhi = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+8*37),CGFloat(pageWidth-150), CGFloat(34))))
        dizhi.borderStyle = UITextBorderStyle.RoundedRect
        selectprovince = Info.customerProvince
        selectcity = Info.customerCity
        selectcounty = Info.customerCounty
        dizhi.text = "\(selectprovince)省 \(selectcity)市 \(selectcounty)"
        dizhi.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        dizhi.minimumFontSize=14
        //dizhi.becomeFirstResponder()
        dizhi.delegate = self //设置代理
        dizhi.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        dizhi.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        dizhi.inputView = pickview
        
        dizhi.inputAccessoryView = toolbar
        scrollView.addSubview(dizhi)

        
        contactAddress = UITextField(frame: CGRectMake((CGFloat(145), CGFloat(customY+9*37),CGFloat(pageWidth-150), CGFloat(34))))
        contactAddress.borderStyle = UITextBorderStyle.RoundedRect
        contactAddress.text = Info.contactAddress
        contactAddress.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        contactAddress.minimumFontSize=14
        contactAddress.becomeFirstResponder()
        contactAddress.delegate = self //设置代理
        contactAddress.clearButtonMode=UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        contactAddress.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        scrollView.addSubview(contactAddress)
        //         self.view.addSubview(contactAddress)
        
        scrollView.contentSize = CGSizeMake(pageWidth,64+520)
        
        
    }
    //toolBar 的函数
    func donePressed() {
        customerBirthday.resignFirstResponder()
        
        // NSDate转化NSString
        let s = datePicker.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let Date = dateFormatter.stringFromDate(s)
        customerBirthday.text = "\(Date)"
        
        customerGender.resignFirstResponder()
        let n = Genderpick.selectedRowInComponent(0)
        customerGender.text = Gender[n]
        
        
        dizhi.resignFirstResponder()
        
        
        dizhi.text = "\(selectprovince)省 \(selectcity)市 \(selectcounty)"

        
        
        
        
    }
    //设置列数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1{
            return 1
        }else if pickerView.tag == 2{
            return 3
        }
        return 1
    }
    //设置行数
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 2{
            if component == 0 {
                
                return root.count
            }
            
            
            if component == 1 {
                
                return cities.count
                
            }
            
            if component == 2 {
                
                return areas.count
                
            }
        }else if pickerView.tag == 1{
            return 2
            
        }
        return 0
        
        
    }
    
    //设置每行具体内容（titleForRow 和 viewForRow 二者实现其一即可）
    
    func  pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            
            return Gender[row]
        }else{
            if component == 0 {
                //return month[row]
                //return provinces.keys.array[row]
                return root[row].objectForKey("state") as? String
            }
            
            if component == 1{
                //return week[row]
                return cities[row].objectForKey("city") as? String
                
            }
            if component == 2{
                //return week[row]
                return areas[row] as? String
                
            }
        }
        return nil
    }
    
    //选中行的操作
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag  == 2 {
            if(component == 0){
                
                dictionary1 = root.objectAtIndex(row) as! NSDictionary//item0
                //第二层
                
                
                cities = dictionary1.objectForKey("cities") as! NSArray
                
                // 重新加载二级选项并复位
                
                pickerView.reloadComponent(1)
                pickerView.selectRow(0, inComponent: 1, animated: true)
                
                let dictionary2:NSDictionary =  cities.objectAtIndex(0) as! NSDictionary
                
                areas = dictionary2.objectForKey("areas") as! NSArray
                
                // 重新加载三级选项并复位
                
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
                
            }
            
            if(component == 1){
                
                let dictionary2:NSDictionary =  cities.objectAtIndex(row) as! NSDictionary
                
                areas = dictionary2.objectForKey("areas") as! NSArray
                
                // 重新加载三级选项并复位
                
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
                
                
                
                
            }
            
            let provinceNum = pickview.selectedRowInComponent(0)
            
            let cityNum = pickview.selectedRowInComponent(1)
            let areaNum = pickview.selectedRowInComponent(2)
            
            
            let pr: AnyObject? = root[provinceNum].objectForKey("state")
            let cit:AnyObject? = cities[cityNum].objectForKey("city")
            
            
            selectprovince = pr as! String
            selectcity = cit as! String
            
            if areas != []{
                selectcounty = areas[areaNum] as! String
            }
        }
          }
    
     func tapped(button:UIButton){
    
      if customerName.text == ""{
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入姓名"
            alert.addButtonWithTitle("确定")
            alert.show()
        }else if !verifyPhoneNo(phoneNo.text) && phoneNo.text != ""{
            let alert = UIAlertView()
            alert.title = ""
            alert.message = "请输入正确的座机号码"
            alert.addButtonWithTitle("确定")
            alert.show()
            
      }else if !verifymobilePhone(mobilePhone.text) {
        let alert = UIAlertView()
        alert.title = ""
        alert.message = "请输入正确的联系电话"
        alert.addButtonWithTitle("确定")
        alert.show()
        
      }else if !verifyEmail(emailAddress.text){
        let alert = UIAlertView()
        alert.title = ""
        alert.message = "请输入正确的邮箱地址"
        alert.addButtonWithTitle("确定")
        alert.show()
      }else if  dizhi.text == ""{
        let alert = UIAlertView()
        alert.title = ""
        alert.message = "请输入所在地"
        alert.addButtonWithTitle("确定")
        alert.show()
      }else if  contactAddress.text == ""{
        let alert = UIAlertView()
        alert.title = ""
        alert.message = "请输入联系地址"
        alert.addButtonWithTitle("确定")
        alert.show()
      }else{
    
            var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileCustomerInfoAction?operation=_update")
            
            println(url)
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
            
            request.HTTPMethod = "POST"
           var param:String = "{\"customerID\":\"\(Info.customerID)\",\"customerName\":\"\(customerName.text)\",\"customerGender\":\"\(customerGender.text)\",\"customerBirthday\":\"\(customerBirthday.text)\", \"phoneNo\":\"\(phoneNo.text)\",\"mobilePhone\":\"\(mobilePhone.text)\",\"emailAddress\":\"\(emailAddress.text)\",\"customerProvince\":\"\(selectprovince)\",\"customerCity\":\"\(selectcity)\",\"customerCounty\":\"\(selectcounty)\",\"contactAddress\":\"\(contactAddress.text)\",\"qqNumber\":\"\(qqNumber.text)\",\"idCardNo\":\"\",\"realLongitude\":\"\",\"realLatitude\":\"\",\"loginPassword\":\"\(Info.loginPassword)\",\"headPicture\":\"\"}"
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
            var serverResponse: String?
            serverResponse = json!.objectForKey("serverResponse") as? String
            
            
            
            
            
            if serverResponse == "Success" {
                //self.performSegueWithIdentifier("", sender: self)
                let alert =  UIAlertView(title: "修改成功", message: "", delegate: self, cancelButtonTitle: "确定")
                alert.delegate = self
                alert.tag = 1
                alert.show()
                Info = QueryInfo(customerid) as MyInfo
                
            }
            
            if serverResponse == "Failed"{
                
                let alert =  UIAlertView(title: "修改失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
            
        }
        
    }
    
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (alertView.tag == 1) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    
 
    
 
         
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }
    

    
    
    func touchScrollView(sender: UITapGestureRecognizer){
        println("取消键盘2")
        //        self.view.resignFirstResponder()
        scrollView.endEditing(true)
        //        self.view.endEditing(true)
    }
    func keyboardWillShow(sender:NSNotification){
        scrollView.contentSize = CGSizeMake(pageWidth,520+253)
        
    }
    func keyboardWillHide(sender:NSNotification){
        scrollView.contentSize = CGSizeMake(pageWidth,520)
        
    }

    
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        scrollView.delegate = self
        
        pickview.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        scrollView.delegate = nil
        
        pickview.delegate = nil
    }

}