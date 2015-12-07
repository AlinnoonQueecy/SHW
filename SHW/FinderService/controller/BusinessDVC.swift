//
//  BusinessDVC.swift
//  SHW
//
//  Created by Zhang on 15/6/15.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class BusinessDVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIScrollViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate{

 
    
    @IBOutlet weak var FacilitatorTV: UITableView!
 
 
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
    //声明上个界面传递来的数据
    var facilitatorid :String = ""
    //声明数组，存储
    var detailItem:facilitatorInfo!
    var PackageItemInfo:[serviceItemInfo]=[]
    var isCollect:String = "no"
    //声明传递的参数
    var titleOfState:String?
    //声明BUtton
    var term1:UIButton?
    
     let introImg = UIImageView()
    //声明项目跳转的数据
    var commmondetail:[serviceItemInfo]=[]
  
    var package:serviceItemInfo!
    //声明右边按钮
    var rightButton =  UIBarButtonItem()
    
    var introScroll = UIScrollView()
   
    var imageUrlString:String?
//    var FacilitatorTV = UITableView()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
       
        //初始化数据
        readNSUerDefaults ()
        
        detailItem = refreshFDetail(facilitatorid) as facilitatorInfo
        
        PackageItemInfo = refreshPackageItem(facilitatorid) as! [serviceItemInfo]
 
       if customerid != "" && loginPassword != "" {
        isCollect = GetCollect(facilitatorid,customerid) as String

        }
        var width = self.view.frame.width
        //店铺名字
        self.title = "\(detailItem.facilitatorName)"
        
        //右边Button
        rightButton =  UIBarButtonItem(title: "收藏", style: UIBarButtonItemStyle.Plain, target: self, action: "AddCollect")
        if isCollect == "yes" {
         rightButton.title = "取消收藏"
        }else {
         rightButton.title = "收藏"
        }
        rightButton.tintColor = UIColor.whiteColor()
        self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
        
        
        introImg.frame = CGRectMake(0,0, width, 180)
        //网络地址获取图片
        //1.定义一个地址字符串常量
        imageUrlString = HttpData.http+"/FamilyServiceSystem\(detailItem.facilitatorLogo)"
        //2.通过String类型，转换NSUrl对象
        //let url :NSURL = NSURL(string: imageUrlString!)!
        introImg.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg" )
        self.view.addSubview(introImg)
        
        
        //let  color = UIColor(red: 255/255, green: 45/255, blue: 0/255, alpha: 0.65)
        let color =  UIColor(red: 255/255, green: 90/255, blue: 0/255, alpha: 0.65)
        //注册日期
        var registrationTime = UILabel(frame: CGRectMake(0, 160, width/3, 20))
        registrationTime.textColor = UIColor.whiteColor()
        registrationTime.text = "注册日期"
        registrationTime.textAlignment = NSTextAlignment.Center
        registrationTime.font = UIFont.systemFontOfSize(10)
        registrationTime.backgroundColor = color
        self.view.addSubview(registrationTime)
        var  Time = UILabel(frame: CGRectMake(0, 140, width/3, 20))
        Time.textColor = UIColor.whiteColor()
        Time.text = "\(detailItem.registerTime)"
        Time.textAlignment = NSTextAlignment.Center
        Time.font = UIFont.systemFontOfSize(10)
        Time.backgroundColor = color
        self.view.addSubview(Time)
        //服务次数
        var serviceCount = UILabel(frame: CGRectMake(width/3, 160, width/3, 20))
        serviceCount.textColor = UIColor.whiteColor()
        serviceCount.text = "服务次数"
        serviceCount.textAlignment = NSTextAlignment.Center
        serviceCount.font = UIFont.systemFontOfSize(10)
        serviceCount.backgroundColor = color
        self.view.addSubview(serviceCount)
        var  Count = UILabel(frame: CGRectMake(width/3, 140, width/3, 20))
        Count.textColor = UIColor.whiteColor()
        Count.text = "\(detailItem.serviceCount)"
        Count.textAlignment = NSTextAlignment.Center
        Count.font = UIFont.systemFontOfSize(10)
        Count.backgroundColor = color
        self.view.addSubview(Count)
        //信用评分
        var creditScore = UILabel(frame: CGRectMake((width/3)*2, 160, width/3, 20))
        creditScore.textColor = UIColor.whiteColor()
        creditScore.text = "信用评分"
        creditScore.textAlignment = NSTextAlignment.Center
        creditScore.font = UIFont.systemFontOfSize(10)
        creditScore.backgroundColor = color
        self.view.addSubview(creditScore)
        var  Score = UILabel(frame: CGRectMake((width/3)*2-0.1, 140, width/3+0.1, 20))
        Score.textColor = UIColor.whiteColor()
        Score.text = "\(detailItem.creditScore)"
        Score.textAlignment = NSTextAlignment.Center
        Score.font = UIFont.systemFontOfSize(10)
        Score.backgroundColor = color
        self.view.addSubview(Score)

        //FacilitatorTV = UITableView(frame:  CGRectMake(0, 180,self.view.frame.width,35*3))
        //tableview
        FacilitatorTV.dataSource = self
        //不能滚动
        FacilitatorTV.scrollEnabled = false
        self.view.addSubview(FacilitatorTV)
        
        let y_view = CGFloat(35*3)
        let view = UIView(frame:CGRectMake(0,180+y_view,self.view.frame.width,5))
        let grayColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        view.backgroundColor = grayColor
        self.view.addSubview(view)
        //服务项目按钮
        //获取屏幕大小（不包括状态栏高度）
        var viewBounds:CGRect = UIScreen.mainScreen().applicationFrame
        var y_button = CGFloat(self.view.frame.height - 104)
        for var i = 0;i < 3;i++ {
           let  color = UIColor(red: 234/255, green: 100/255, blue: 6/255, alpha: 1)
           term1 = UIButton(frame:CGRectMake(((width-2)/3+1)*CGFloat(i%3),y_button, ((width-2)/3),40))
           let  title = ["服务项目","一口价","服务人员"]
           term1!.setTitle(title[i] as String, forState:UIControlState.Normal)
           term1!.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
           term1!.backgroundColor = color
           term1!.titleLabel?.font = UIFont.systemFontOfSize(14)
           term1!.showsTouchWhenHighlighted = true
           term1!.tag  = i
           term1!.addTarget(self , action: Selector("toIntro:"), forControlEvents: UIControlEvents.TouchUpInside)
           self.view.addSubview(term1!)
            
        }
        
//         introScroll = UIScrollView(frame:CGRectMake(0,self.view.frame.height-104,self.view.frame.width,self.view.frame.height-190-y_view-y_button))
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
        var text = detailItem.facilitatorIntro
        var statusLabelText:NSString = detailItem.facilitatorIntro
        var font = UIFont.systemFontOfSize(12)
        var statusLabelSize = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
        //根据高度设LabelFrame
        var H = statusLabelSize.height
        var W = statusLabelSize.width
        var labelW = self.view.frame.width - 16
        var TH = H*(W/labelW+1)
        var introheight = TH
        let introText = UILabel(frame:CGRectMake(8,0,labelW,introheight ))
        introText.text = "  \(detailItem.facilitatorIntro)"
        introText.textColor = UIColor.grayColor()
        introText.font = font
        introText.numberOfLines = 0
        introScroll.addSubview(introText)
        introScroll.contentSize=CGSizeMake(width,introheight)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
        FacilitatorTV.frame = CGRectMake(0, 180,self.view.frame.width,35*3)
        
    }
//
    //服务项目的跳转函数
    func  toIntro(term1:UIButton){
        
        //push跳转
        if term1.tag == 0{
        let svc = ServiceItemVC()
        svc.detailItem = detailItem
        self.navigationController!.pushViewController(svc,animated:true)
        }else if term1.tag == 1 {
            self.performSegueWithIdentifier("toPackageListVC", sender: self)

//            let svc = ServantOfFTVC()
//            svc.facilitatorID = detailItem.facilitatorID
//            self.navigationController!.pushViewController(svc,animated:true)
        }else if term1.tag == 2 {
//            let svc = ServantListVC()
//             svc.facilitatorName = detailItem.facilitatorName
//            svc.facilitatorID = detailItem.facilitatorID
//            self.navigationController!.pushViewController(svc,animated:true)
              self.performSegueWithIdentifier("toServant", sender: self)
        }


        
    }
 
    //收藏的函数传数据函数
    func AddCollect () {
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        
        if customerid == "" ||  loginPassword == "" {
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! UIViewController
 
            self.navigationController!.pushViewController(vc, animated:true)
            
            
            
        }else {
        
       isCollect = GetCollect(facilitatorid,customerid) as String

        if isCollect == "yes" {
             var serviceresponse =  deleteFCollection(customerid,detailItem.facilitatorID,detailItem.facilitatorName)
            if serviceresponse == "Success"{
                let alert =  UIAlertView(title: "取消成功", message: "", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                rightButton.title = "收藏"

                isCollect = "no"
                
            } else if serviceresponse == "Failed"{
                
                let alert =  UIAlertView(title: "取消失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
            
            
        }else if isCollect == "no"{
 
        var serviceresponse =  addFCollection(customerid,detailItem.facilitatorID,detailItem.facilitatorName)
        if serviceresponse == "Success"{
            let alert =  UIAlertView(title: "收藏成功", message: "", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            isCollect = "yes"
            rightButton.title = "取消收藏"

        } else if serviceresponse == "Failed"{
            
            let alert =  UIAlertView(title: "收藏失败", message: "请重试", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
       }
      }
    }
   
    
    //登录和
    
    //等级图片的转换函数
    func imageForRank(rank:Int) -> UIImage? {
        switch rank {
        case 1:
            return UIImage(named: "1")
        case 2:
            return UIImage(named: "2")
        case 3:
            return UIImage(named: "3")
        case 4:
            return UIImage(named: "4")
        case 5:
            return UIImage(named: "5")
        default:
            return nil
        }
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
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FacilitatorCell", forIndexPath: indexPath) as! FacilitatorCell
        
        let data:[String] = [detailItem.contactPhone,detailItem.officePhone,detailItem.contactAddress]
        let imageName:[String]  = ["phone.png","tel.png","location.png"]
        var image  = UIImage(named:imageName[indexPath.row])
        cell.frontImage.image = image
        cell.contentlabel.text = "\(data[indexPath.row])"
        if indexPath.row == 0 {
            let backImage = UIImage(named:"call.png")
            cell.callButton.setBackgroundImage(backImage, forState: UIControlState.Normal)
            //cell.callButton.setImage(backImage, forState: UIControlState.Normal)
            cell.callButton.addTarget(self, action: "Call", forControlEvents: UIControlEvents.TouchUpInside)
       }else {
          
            cell.callButton.hidden = true
        }
 
        return cell
    }
//拨打电话
    func Call(){
    
        var phoneNoStr =  NSMutableString(format:"tel:%", detailItem.contactPhone)
        let webView = UIWebView()
       // webView.loadRequest(NSURLRequest(URL:NSURL(fileURLWithPath: phoneNoStr as String)!))
        webView.loadRequest(NSURLRequest(URL:NSURL.fileURLWithPath(phoneNoStr as String)!))
        self.view.addSubview(webView)
        
        
    }
 

 
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func  viewWillAppear(animated: Bool) {
        FacilitatorTV.delegate = self
        readNSUerDefaults()
        if customerid != "" && loginPassword != "" {
           isCollect = GetCollect(facilitatorid,customerid) as String
            
        }
        
      
        if isCollect == "yes" {
            rightButton.title = "取消收藏"
        }else {
            rightButton.title = "收藏"        }
        
    }
 
        override func viewWillDisappear(animated: Bool) {
          
            FacilitatorTV.delegate = nil
        
        }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier=="toServant"{
           
                var  object = detailItem.facilitatorID
                (segue.destinationViewController as! ServantListVC).facilitatorID  = object
                
          
            
        } else if segue.identifier=="toPackageListVC"{
            
            var  object = detailItem.facilitatorID
            (segue.destinationViewController as! PackageListVC).facilitatorID  = object
            
            
            
        }

    }
    


}
