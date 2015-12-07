//
//  PackageItemVC.swift
//  SHW
//
//  Created by Zhang on 15/7/31.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class PackageItemVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIScrollViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate{
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
    //声明上个界面传递的数据
    var ItemData:serviceItemInfo!
    //声明数组，存储
    var facilitatorData:facilitatorInfo!
    var introImg = UIImageView()
    //声明预定按钮
    var orderButton:UIButton?
    //图片的url
    var imageUrlString:String?
    //介绍下拉
    var introScroll = UIScrollView()
     @IBOutlet weak var packageItemTV: UITableView!
   // var packageItemTV:UITableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化数据
        readNSUerDefaults ()
        
        self.view.backgroundColor = UIColor.whiteColor()

        facilitatorData = refreshFDetail(ItemData.facilitatorID) as facilitatorInfo
        var width = self.view.frame.width
        //项目名字
        self.title = "\(ItemData.serviceType)"
        
        introImg.frame = CGRectMake(0,0, width, 180)
        //网络地址获取图片
        //1.定义一个地址字符串常量
        imageUrlString = HttpData.http+"/FamilyServiceSystem/upload/service/\(ItemData.id)/\(ItemData.servicePicture)"
        introImg.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg" )
        
        self.view.addSubview(introImg)
        
       // packageItemTV.frame = CGRectMake(0, 180,self.view.frame.width,35*3)
        //tableview
        packageItemTV.dataSource = self
        //packageItemTV.registerClass(FacilitatorCell.self, forCellReuseIdentifier: "FacilitatorCell")
        //上部不能下拉
        // FacilitatorTV.bounces = false
        //不能滚动
        packageItemTV.scrollEnabled = false
        self.view.addSubview(packageItemTV)
        let y_view = CGFloat(35*3)
        let view = UIView(frame:CGRectMake(0,180+y_view,self.view.frame.width,5))
        let grayColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        view.backgroundColor = grayColor
        self.view.addSubview(view)
        //服务项目按钮
         
        var y_button = CGFloat(self.view.frame.height - 104)
        
        let  color = UIColor(red: 234/255, green: 100/255, blue: 6/255, alpha: 1)
        orderButton = UIButton(frame:CGRectMake((width/3)*2,y_button,width/3,40))
        
        orderButton!.setTitle("立即预定" as String, forState:UIControlState.Normal)
        orderButton!.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
        orderButton!.backgroundColor = color
        orderButton!.titleLabel?.font = UIFont.systemFontOfSize(16)
        orderButton!.showsTouchWhenHighlighted = true
        
        orderButton!.addTarget(self , action: Selector("Order:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(orderButton!)
        
        let  View = UIView(frame:CGRectMake(0,y_button, (width/3)*2,40))
        View.backgroundColor = grayColor
        self.view.addSubview(View)
        
        let priceTitle = UILabel(frame:CGRectMake(20,10,50,20))
        priceTitle.textColor = UIColor.grayColor()
        priceTitle.text = "价格:"
        priceTitle.font = UIFont.systemFontOfSize(14)
        priceTitle.textAlignment = NSTextAlignment.Center
        View.addSubview(priceTitle)
        
        let price = UILabel(frame:CGRectMake(70,10,100,20) )
        price.textColor = UIColor.orangeColor()
        price.text = "\(ItemData.priceDescription)元/次"
        price.font = UIFont.systemFontOfSize(19)
        price.textAlignment = NSTextAlignment.Center
        View.addSubview(price)

        
        
        
        
        
        introScroll = UIScrollView(frame:CGRectMake(0,185+y_view,self.view.frame.width,self.view.frame.height-190-y_view-104))
        introScroll.contentSize=CGSizeMake(width,self.view.frame.height*5)
        introScroll.pagingEnabled = false
        introScroll.showsHorizontalScrollIndicator = false
        introScroll.showsVerticalScrollIndicator = false
        //设置不可下拉
        introScroll.bounces = false
        introScroll.scrollsToTop = false
        self.view.addSubview(introScroll)
        
        // 商家介绍
        //计算文字的高度
        var text = ItemData.itemIntro
        var statusLabelText:NSString = ItemData.itemIntro
        var font = UIFont.systemFontOfSize(12)
        var statusLabelSize = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
        //根据高度设LabelFrame
        var H = statusLabelSize.height
        var W = statusLabelSize.width
        var labelW = self.view.frame.width - 16
        var TH = H*(W/labelW+1)
        var introheight = TH
        let introText = UILabel(frame:CGRectMake(8,0,labelW,introheight ))
        introText.text = ItemData.itemIntro
        introText.textColor = UIColor.grayColor()
        introText.font = font
        introText.numberOfLines = 0
        introScroll.addSubview(introText)
        introScroll.contentSize=CGSizeMake(width,introheight)
        
    }
    //    //立即预订的跳转函数
    func Order (orderButton:UIButton){
        
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        
        if customerid != "" && loginPassword != ""{
            self.performSegueWithIdentifier("toOrderP", sender: self)
        }else {
            //                 let alert =  UIAlertView(title: "", message: "登录后才能预定哦!", delegate: self, cancelButtonTitle: "确定")
            //alert.show()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "toOrderP" {
            println("下订单")
            //            let controller = segue.destinationViewController as! PackageOrder
            //            var  object = CommonItem
            //            println(object.serviceType)
            //            controller.OrderData = object
            
        }
    }
    
//    
    override func viewDidLayoutSubviews() {
        
        packageItemTV.frame = CGRectMake(0, 180,self.view.frame.width,35*3)
        
    }
    
    
    
    
    
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3 ;
    }
    
    
    func tableView(tableview: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCellWithIdentifier("FacilitatorCell", forIndexPath: indexPath) as! FacilitatorCell
        
       
        var data:[String] = [facilitatorData.contactPhone,facilitatorData.officePhone,facilitatorData.contactAddress]
        
       
        let imageName:[String]  = ["phone.png","tel.png","location.png"]
        var image  = UIImage(named:imageName[indexPath.row])
        cell.frontImage.image = image
        cell.contentlabel.text = "\(data[indexPath.row])"
        if indexPath.row == 0 {
            let backImage = UIImage(named:"call.png")
            cell.callButton.setBackgroundImage(backImage, forState: UIControlState.Normal)
            
            cell.callButton.addTarget(self, action: "Call", forControlEvents: UIControlEvents.TouchUpInside)
        }else {
            
            cell.callButton.hidden = true
        }
        
        return cell
    }
    //拨打电话
    func Call(){
        
        var phoneNoStr =  NSMutableString(format:"tel:%", facilitatorData.contactPhone)
        let webView = UIWebView()
        // webView.loadRequest(NSURLRequest(URL:NSURL(fileURLWithPath: phoneNoStr as String)!))
        webView.loadRequest(NSURLRequest(URL:NSURL.fileURLWithPath(phoneNoStr as String)!))
        self.view.addSubview(webView)
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func  viewWillAppear(animated: Bool) {
        packageItemTV.delegate = self
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        packageItemTV.delegate = nil
        
    }
    
    
    
    
}