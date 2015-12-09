//
//  CommonOrder.swift
//  SHW
//
//  Created by Zhang on 15/8/5.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class CommonOrder: UIViewController,UITextFieldDelegate,UIAlertViewDelegate,NSURLConnectionDataDelegate,UIScrollViewDelegate ,BMKGeoCodeSearchDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    //声明导航条
    var navigationBar : UINavigationBar?
    //声明上个界面传递的数据
    var OrderData:serviceItemInfo!
    //读取本地数据
    var customerid:String =  ""
    var loginPassword:String = ""
        //获取网络数据
    var myinfo:MyInfo!
    //控件
    var servantID :UILabel?
     var customerName = UITextField()
    var dizhi  = UITextField()
    var dianhua = UITextField()
    var beizhu = UITextView()
    var scrollView = UIScrollView()
    //声明Button
    var yuyue:UIButton?
    //接收订单编号
    var orderNo:String = ""
    var width:CGFloat!
    var orderY = CGFloat()
    var customerInfoY = CGFloat()
    var CBY = CGFloat()
    
  
    
      var pickview:UIPickerView!
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
    
    var serviceCounty:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        //初始化数据
        myinfo = QueryInfo(customerid) as MyInfo
         width = self.view.frame.width
        var height = self.view.frame.height
        var labelW = self.view.frame.width - 20
        
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情")
//        onMakeNavitem()
        //1、创建手势实例，并连接方法UITapGestureRecognizer,点击手势
        var recognizer =  UITapGestureRecognizer(target:self, action:"touchScrollView:")
        println("touchScrollView")
        
        //设置手势点击数,点1下
        recognizer.numberOfTapsRequired = 1
        
        //recognizer.numberOfTouchesRequired = 1
        
        scrollView.addGestureRecognizer(recognizer)
        NSNotificationCenter.defaultCenter().addObserver(self,selector:Selector("keyboardWillShow:"),name:UIKeyboardWillShowNotification,object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self,selector:Selector("keyboardWillHide:"),name:UIKeyboardWillHideNotification,object:nil)
        
        //添加scrollview
        scrollView.delegate = self
 
        //scrollView.bounds = self.view.bounds
        scrollView.frame = CGRectMake(0, 64,width,height)
        scrollView.contentSize=CGSizeMake(width,height*5)
        //scrollView.contentInset = UIEdgeInsetsMake(-64,0,0, 0)
        //不可翻页
        scrollView.pagingEnabled = false
        //不显示横向滑竿
        scrollView.showsHorizontalScrollIndicator = false
        //不显示纵向滑竿
        scrollView.showsVerticalScrollIndicator = false
        //设置不可下拉
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        self.view.addSubview(scrollView)
        
        //订单信息
         orderY = CGFloat(0)
        var order = UIButton(frame: CGRectMake(15, orderY, width-30, 30))
        order.setTitle("订单信息", forState: UIControlState.Normal)
        order.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        order.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        order.setBackgroundImage(UIImage(named: "listBackground"), forState: UIControlState.Normal)
        order.titleLabel?.font = UIFont.systemFontOfSize(17)
        scrollView.addSubview(order)
        
        var facilitatorID = UILabel(frame: CGRectMake(15, orderY+35, labelW, 25))
        facilitatorID.text = "店铺名称:\(OrderData!.facilitatorID)"
        facilitatorID.textColor = UIColor.blackColor()
        facilitatorID.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(facilitatorID)
        
        var servantName1 = UILabel(frame: CGRectMake(15, orderY+35+25, labelW, 25))
        servantName1.text = "服务项目:\(OrderData.serviceType)"
        servantName1.textColor = UIColor.blackColor()
        servantName1.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(servantName1)
        
        //服务项目
        var itemName = UILabel(frame: CGRectMake(15, orderY+35+2*25, labelW, 25))
        itemName.text = "服务费用:面议"
        itemName.textColor = UIColor.blackColor()
        itemName.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(itemName)
        
         customerInfoY  =  orderY+35+3*25+20
        var customerN = UILabel(frame: CGRectMake(15, customerInfoY, labelW, 25))
        customerN.text = "客户姓名: "
        customerN.textColor = UIColor.blackColor()
        customerN.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(customerN)
        customerName = UITextField(frame: CGRectMake(80, customerInfoY, width-90, 30))
        customerName.borderStyle = UITextBorderStyle.RoundedRect
        customerName.clearButtonMode=UITextFieldViewMode.WhileEditing
        //编辑时出现清除按钮
        customerName.text = myinfo.customerName
        scrollView.addSubview(customerName)
        var quyu = UILabel(frame: CGRectMake(15, customerInfoY+35, 80, 25))
        quyu.text = "服务区域:"
        quyu.textColor = UIColor.blackColor()
        quyu.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(quyu)
        
        pickview = UIPickerView(frame: CGRectMake(0,300, self.view.frame.width, 300))
        //添加ToolBar（可以不要）
        
        let f = pickview.frame
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, f.width, (f.height * 0.15)))
        var buttons = [UIBarButtonItem]()
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        buttons.append(space)
        let doneButton = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Plain, target: self, action: "donePressed")
        buttons.append(doneButton)
        toolbar.setItems(buttons, animated: false)
        
        pickview = UIPickerView()
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
        
        serviceCounty = UITextField(frame: CGRectMake(80, customerInfoY+35, width-90, 30))
        serviceCounty.borderStyle = UITextBorderStyle.RoundedRect
        serviceCounty.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        serviceCounty.minimumFontSize=12
        serviceCounty.clearButtonMode=UITextFieldViewMode.WhileEditing
        //编辑时出现清除按钮
        
        serviceCounty.inputView = pickview
        selectprovince = myinfo.customerProvince
        selectcity = myinfo.customerCity
        selectcounty = myinfo.customerCounty
        serviceCounty.text = "\(selectprovince)省 \(selectcity)市 \(selectcounty)"
        serviceCounty.inputAccessoryView = toolbar
        scrollView.addSubview(serviceCounty)
        
        var address = UILabel(frame: CGRectMake(15, customerInfoY+35*2, 80, 25))
        address.text = "详细地址:"
        address.textColor = UIColor.blackColor()
        address.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(address)
        
        dizhi = UITextField(frame: CGRectMake(80, customerInfoY+35*2, width-90, 30))
        dizhi.borderStyle = UITextBorderStyle.RoundedRect
        dizhi.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        dizhi.minimumFontSize=12
        
        dizhi.clearButtonMode=UITextFieldViewMode.WhileEditing
        //编辑时出现清除按钮
        dizhi.text = myinfo.contactAddress
        scrollView.addSubview(dizhi)
        
        
        var serviceType = UILabel(frame: CGRectMake(15, customerInfoY+35*3, 80, 25))
        serviceType.text = "联系电话:"
        serviceType.textColor = UIColor.blackColor()
        serviceType.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(serviceType)
        dianhua = UITextField(frame: CGRectMake(80, customerInfoY+35*3, width-90, 30))
        dianhua.text = myinfo.mobilePhone
        dianhua.borderStyle = UITextBorderStyle.RoundedRect
        dianhua.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        dianhua.minimumFontSize=12
        
        dianhua.clearButtonMode=UITextFieldViewMode.WhileEditing
        //编辑时出现清除按钮
        scrollView.addSubview(dianhua)
        
        //价格
        var remark = UILabel(frame: CGRectMake(15, customerInfoY+35*4,50, 60))
        remark.text = "备注:"
        remark.textColor = UIColor.blackColor()
        remark.font = UIFont.systemFontOfSize(15)
        scrollView.addSubview(remark)
        
        beizhu = UITextView(frame: CGRectMake(80, customerInfoY+35*4,width-90, 80))
        //添加滚动区域
        beizhu.contentInset = UIEdgeInsetsMake(-6,0 , 0, 0)
        //字体
        beizhu.font = UIFont.systemFontOfSize(15)
        beizhu.textColor = UIColor.blackColor()
        
        //边框粗细
        beizhu.layer.borderWidth = 0.1
        //边框颜色
        beizhu.layer.borderColor = UIColor.grayColor().CGColor
        //圆角
        beizhu.layer.cornerRadius = 5
        //是否可以滚动
        beizhu.scrollEnabled = true
        //自适应高度
        beizhu.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        //使文本框在界面打开时就获取焦点，并弹出输入键盘
        //        ReasonField.becomeFirstResponder()
        //使文本框失去焦点，并收回键盘
        beizhu.resignFirstResponder()
        //键盘形式
        beizhu.keyboardType = UIKeyboardType.Twitter
        scrollView.addSubview(beizhu)
        
        //预定按钮
        CBY = customerInfoY+35*5+80
        yuyue = UIButton(frame:CGRectMake(width/2-125, CBY,250,30))
        yuyue! .setTitle("确认预订", forState:UIControlState.Normal)
        yuyue!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        yuyue!.titleLabel?.font = UIFont.systemFontOfSize(15)
        yuyue!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        yuyue!.showsTouchWhenHighlighted = true
        yuyue?.layer.cornerRadius = 5
        yuyue!.backgroundColor = UIColor.orangeColor()
        scrollView.addSubview(yuyue!)
        yuyue!.addTarget(self , action:Selector("yuding:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        scrollView.contentSize = CGSizeMake(width,64+CBY+50)
        println(scrollView.bounds.height)
        
        // Do any additional setup after loading the view.
    }
    
    //toolBar 的函数
    func donePressed() {
        
        
        serviceCounty.resignFirstResponder()
        serviceCounty.text = "\(selectprovince)省 \(selectcity)市 \(selectcounty)"
    }
        //设置列数
        func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 3
        }
        //设置行数
        
        func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            if component == 0 {
                
                return root.count
            }
            
            
            if component == 1 {
                
                return cities.count
                
            }
            
            if component == 2 {
                
                return areas.count
                
            }
            
            return 0
            
            
        }
        
        //设置每行具体内容（titleForRow 和 viewForRow 二者实现其一即可）
        
        func  pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
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
            return nil
            
        }
        
        //选中行的操作
        
        func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            
            
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
        
        
        
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //预定的跳转函数
    func yuding(yuyue:UIButton){
        
        if dizhi.text == "" || serviceCounty.text == "" ||  !verifymobilePhone(dianhua.text){
            let alert =  UIAlertView(title: "", message: "请填写正确的电话和地址!", delegate: self, cancelButtonTitle: "确定")
            // alert.tag = 1
            alert.show()
        }else {
            var addressd = "\(serviceCounty.text)\(dizhi.text)"

        var url: NSURL! = NSURL(string:HttpData.http+"/FamilyServiceSystem/MobileServiceOrderAction?operation=_add")
        
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
        
        request.HTTPMethod = "POST"
        
        var param:String = "{\"customerID\":\"\(customerid)\",\"customerName\":\"\(customerName.text)\",\"facilitatorID\":\"\(OrderData.facilitatorID)\",\"facilitatorName\":\"\(OrderData.facilitatorName)\",\"servantName\":\"\",\"servantID\":\"\",\"serviceType\":\"\(OrderData.serviceType)\",\"itemName\":\"\(OrderData.itemName)\",\"itemID\":\"\",\"serviceContent\":\"\(beizhu.text)\",\"servicePrice\":\"\(OrderData.priceDescription)\",\"isPackage\":\"false\",\"contactAddress\":\"\(addressd)\",\"contactPhone\":\"\(dianhua.text)\"}"
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
        //let orderNo = json!.objectForKey("OrderNo") as? String
        
        println("orderNo:\(orderNo)")
        if serverResponse == "Success"{
            
            let alert =  UIAlertView(title: "预定成功", message: "商家会尽快与您取得联系!", delegate: self, cancelButtonTitle: "确定")
            alert.tag = 1
            alert.show()
            
            
        }else if serverResponse == "Failed"{
            
            let alert =  UIAlertView(title: "预定失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            
          }
        
        }
    }
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 1{
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        
        //self.performSegueWithIdentifier("OrderServantTo", sender: self)
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
        navigationItem.title = "订单详情"
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
 
    func touchScrollView(sender: UITapGestureRecognizer){
        println("取消键盘2")
        //        self.view.resignFirstResponder()
        scrollView.endEditing(true)
        //        self.view.endEditing(true)
    }
    func keyboardWillShow(sender:NSNotification){
        scrollView.contentSize = CGSizeMake(width,64+CBY+30+253)
        
    }
    func keyboardWillHide(sender:NSNotification){
        scrollView.contentSize = CGSizeMake(width,64+CBY+30)
        
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
