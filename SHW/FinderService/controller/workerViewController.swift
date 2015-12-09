
//  ViewController.swift
//  人员信息
//
//  Created by appl on 15/6/15.
//  Copyright (c) 2015年 appl. All rights reserved.

import UIKit
import Foundation


class workerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIScrollViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate{
    
    
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
    //声明接收的数据
    var Servantdata:ServantInfo!
    //声明传递的参数
    var titleOfState:String?
    //声明网络获取的数据
    var isCollect:String = "no"
    var facilitatorData:facilitatorInfo!
    //头像
    let introImg = UIImageView()
    //声明右边按钮
    var  rightButton =  UIBarButtonItem()
    //介绍
    var introScroll = UIScrollView()
    //评价
    var commentTableView = UITableView()
    var commentlabel = UILabel()
    //图片url
    var imageUrlString:String?
    var segmentedControl = UISegmentedControl()
    //存储评论
    var commentdata:[CommentInfo] = []
    var  serverResponse:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        //        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        self.title = Servantdata.facilitatorName
        //初始化数据
        self.view.backgroundColor = UIColor.whiteColor()
        
        if customerid != "" && loginPassword != "" {
            isCollect = GetServantCollect(Servantdata.servantID, customerid) as String
            
        }
        
        facilitatorData = refreshFDetail(Servantdata.facilitatorID) as facilitatorInfo
        
        var width = self.view.frame.width
        
        
        //右边Button
        rightButton =  UIBarButtonItem(title: "收藏", style: UIBarButtonItemStyle.Plain, target: self, action: "AddCollect")
        if isCollect == "yes" {
            rightButton.title = "取消收藏"
        }else {
            rightButton.title = "收藏"
        }
        rightButton.tintColor = UIColor.whiteColor()
        self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
        
        let imageView = UIView(frame: CGRectMake(0, 0, width, 150))
        //设置背景图片
        imageView.layer.contents = UIImage(named:"servantbackground.png")?.CGImage
        self.view.addSubview(imageView)
        introImg.frame = CGRectMake(10,10,90, 90)
        //网络地址获取图片
        //1.定义一个地址字符串常量
        let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/servant/\(Servantdata.id)/\(Servantdata.headPicture)"
        
        introImg.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg" )
        imageView.addSubview(introImg)
        //姓名
        let name = UILabel(frame: CGRectMake(110, 20, 60, 10))
        name.text = Servantdata.servantName
        name.font = UIFont.systemFontOfSize(14)
        name.textColor = UIColor.orangeColor()
        imageView.addSubview(name)
        //所属公司
        let facilitator = UILabel(frame: CGRectMake(170, 20, width-170, 10))
        facilitator.text = Servantdata.facilitatorName
        facilitator.font = UIFont.systemFontOfSize(11)
        facilitator.textColor = UIColor.grayColor()
        imageView.addSubview(facilitator)
        //性别
        let Gender = UILabel(frame: CGRectMake(110,40, 30, 10))
        Gender.text = "性别:"
        Gender.font = UIFont.systemFontOfSize(11)
        Gender.textColor = UIColor.grayColor()
        imageView.addSubview(Gender)
        
        let servantGender = UILabel(frame: CGRectMake(145, 40, 20, 10))
        servantGender.text =  Servantdata.servantGender
        servantGender.font = UIFont.systemFontOfSize(11)
        servantGender.textColor = UIColor.grayColor()
        imageView.addSubview(servantGender)
        //教育程度
        let Level = UILabel(frame: CGRectMake(170,40, 50, 10))
        Level.text = "教育程度:"
        Level.font = UIFont.systemFontOfSize(11)
        Level.textColor = UIColor.grayColor()
        imageView.addSubview(Level)
        
        let educationLevel = UILabel(frame: CGRectMake(225, 40, 50, 10))
        educationLevel.text = Servantdata.educationLevel
        educationLevel.font = UIFont.systemFontOfSize(11)
        educationLevel.textColor = UIColor.grayColor()
        imageView.addSubview(educationLevel)
        //联系电话
        let Contact = UILabel(frame: CGRectMake(110,55, 50, 10))
        Contact.text = "联系电话:"
        Contact.font = UIFont.systemFontOfSize(11)
        Contact.textColor = UIColor.grayColor()
        imageView.addSubview(Contact)
        
        let phoneNo = UILabel(frame: CGRectMake(160, 55, 50, 10))
        phoneNo.text = Servantdata.phoneNo
        phoneNo.font = UIFont.systemFontOfSize(11)
        phoneNo.textColor = UIColor.grayColor()
        imageView.addSubview(phoneNo)
        let servantMobil = UILabel(frame: CGRectMake(160, 70, 50, 10))
        servantMobil.text = Servantdata.servantMobil
        servantMobil.font = UIFont.systemFontOfSize(11)
        servantMobil.textColor = UIColor.grayColor()
        imageView.addSubview(servantMobil)
        //所属区域
        let County = UILabel(frame: CGRectMake(110,85, 50, 10))
        County.text = "所属区域:"
        County.font = UIFont.systemFontOfSize(11)
        County.textColor = UIColor.grayColor()
        imageView.addSubview(County)
        let servantCity = UILabel(frame: CGRectMake(160, 85, width-170, 10))
        servantCity.text = "\(Servantdata.servantProvince)\(Servantdata.servantCity)\(Servantdata.servantCounty)"
        servantCity.font = UIFont.systemFontOfSize(11)
        servantCity.textColor = UIColor.grayColor()
        imageView.addSubview(servantCity)
        //        let servantCounty = UILabel(frame: CGRectMake(160, 100, width-170, 10))
        //        servantCounty.text = "\(ServantData.servantCounty)"
        //        servantCounty.font = UIFont.systemFontOfSize(11)
        //        servantCounty.textColor = UIColor.grayColor()
        //        imageView.addSubview(servantCounty)
        
        //let  color = UIColor(red: 255/255, green: 45/255, blue: 0/255, alpha: 0.65)
        let color =  UIColor(red: 255/255, green: 90/255, blue: 0/255, alpha: 0.65)
        //从业年限
        var workYears = UILabel(frame: CGRectMake(0, 130, width/3, 20))
        workYears.textColor = UIColor.whiteColor()
        workYears.text = "从业年限"
        workYears.textAlignment = NSTextAlignment.Center
        workYears.font = UIFont.systemFontOfSize(10)
        workYears.backgroundColor = color
        imageView.addSubview(workYears)
        var  Time = UILabel(frame: CGRectMake(0, 110, width/3, 20))
        Time.textColor = UIColor.whiteColor()
        Time.text = "\( Servantdata.workYears)年"
        Time.textAlignment = NSTextAlignment.Center
        Time.font = UIFont.systemFontOfSize(10)
        Time.backgroundColor = color
        imageView.addSubview(Time)
        //服务次数
        var serviceCount = UILabel(frame: CGRectMake(width/3, 130, width/3, 20))
        serviceCount.textColor = UIColor.whiteColor()
        serviceCount.text = "服务次数"
        serviceCount.textAlignment = NSTextAlignment.Center
        serviceCount.font = UIFont.systemFontOfSize(10)
        serviceCount.backgroundColor = color
        imageView.addSubview(serviceCount)
        var  Count = UILabel(frame: CGRectMake(width/3, 110, width/3, 20))
        Count.textColor = UIColor.whiteColor()
        Count.text = "\(Servantdata.serviceCount)次"
        Count.textAlignment = NSTextAlignment.Center
        Count.font = UIFont.systemFontOfSize(10)
        Count.backgroundColor = color
        imageView.addSubview(Count)
        //期望薪资
        var servantScore = UILabel(frame: CGRectMake((width/3)*2, 130, width/3, 20))
        servantScore.textColor = UIColor.whiteColor()
        servantScore.text = "期望薪资"
        servantScore.textAlignment = NSTextAlignment.Center
        servantScore.font = UIFont.systemFontOfSize(10)
        servantScore.backgroundColor = color
        imageView.addSubview(servantScore)
        var  Score = UILabel(frame: CGRectMake((width/3)*2-0.1, 110, width/3+0.1, 20))
        Score.textColor = UIColor.whiteColor()
        if Servantdata.servantScore == ""{
            
            Score.text = "暂无"
        }else {
            Score.text = "\(Servantdata.servantSalary)元/月"
        }
        Score.textAlignment = NSTextAlignment.Center
        Score.font = UIFont.systemFontOfSize(10)
        Score.backgroundColor = color
        imageView.addSubview(Score)
        //分段选择设置
        var arr = NSArray(objects: "详细介绍","客户评价")
        var sw = width/2
        //分段选择标题
        segmentedControl = UISegmentedControl(items: arr as [AnyObject])
        segmentedControl.frame =  CGRectMake(0, 150,self.view.frame.width, 50)
        //设置颜色
        segmentedControl.tintColor = UIColor.whiteColor()
        //自定义字体颜色和大小
        var Selecteddic  = NSDictionary(dictionaryLiteral: (NSForegroundColorAttributeName,UIColor.orangeColor()),(NSFontAttributeName,UIFont(name:"AppleGothic",size: 16)!))
        //设置在某状态下（选中状态）
        segmentedControl.setTitleTextAttributes(Selecteddic as [NSObject : AnyObject], forState: UIControlState.Selected)
        var Normaldic  = NSDictionary(dictionaryLiteral: (NSForegroundColorAttributeName,UIColor.grayColor()),(NSFontAttributeName,UIFont(name:"AppleGothic",size: 16)!))
        //设置在某状态下（未选中状态）
        segmentedControl.setTitleTextAttributes(Normaldic as [NSObject : AnyObject], forState: UIControlState.Normal)
        //设置背景图片
        segmentedControl.setBackgroundImage(UIImage(named:"u4.png"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)//选中状态
        segmentedControl.setBackgroundImage(UIImage(named:"u4.png"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)//未选中状态
        //每个的宽度按segment的宽度平分
        segmentedControl.apportionsSegmentWidthsByContent =  true
        //选中第几个segment 一般用于初始化时选中
        segmentedControl.selectedSegmentIndex = 0
        self.view.addSubview(segmentedControl)//添加到父视图
        //添加事件
        segmentedControl.addTarget(self, action: "selected", forControlEvents: UIControlEvents.ValueChanged)
        //底层按钮
        var y_button = CGFloat(self.view.frame.height - 104)
        var orderButton = UIButton(frame:CGRectMake((width/3)*2,y_button,width/3,40))
        
        orderButton.titleLabel!.textColor = UIColor.whiteColor()
        orderButton.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
        orderButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        orderButton.showsTouchWhenHighlighted = true
        let  orangecolor = UIColor(red: 234/255, green: 100/255, blue: 6/255, alpha: 1)
        if Servantdata.servantStatus == "false"{
            
            orderButton.backgroundColor = UIColor.grayColor()
            orderButton.titleLabel!.textAlignment = NSTextAlignment.Center
            orderButton.setTitle("服务中..." as String, forState:UIControlState.Normal)
            orderButton.enabled = false
        }else {
            
            orderButton.backgroundColor = orangecolor
            orderButton.titleLabel!.textAlignment = NSTextAlignment.Center
            orderButton.setTitle("免费预约" as String, forState:UIControlState.Normal)
            
            
        }
        
        orderButton.addTarget(self , action: Selector("Order"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(orderButton)
        
        let grayColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        let  View = UIView(frame:CGRectMake(0,y_button, (width/3)*2,40))
        View.backgroundColor = grayColor
        self.view.addSubview(View)
        
        let Title1 = UILabel(frame:CGRectMake(8,5,(width/3)*2-8,15))
        Title1.textColor = UIColor.grayColor()
        Title1.text = "成功预约后商家会与您取得联系，并根据你的需求确定服务价格，"
        Title1.font = UIFont.systemFontOfSize(7)
        Title1.textAlignment = NSTextAlignment.Left
        View.addSubview(Title1)
        
        let Title2 =  UILabel(frame:CGRectMake(8,20,(width/3)*2-8,15))
        Title2.textColor = orangecolor
        Title2.text = "最后由您决定选择或放弃服务，预约完全免费。"
        Title2.font = UIFont.systemFontOfSize(7)
        Title2.textAlignment = NSTextAlignment.Left
        View.addSubview(Title2)
        //评论
        commentTableView = UITableView(frame:CGRectMake(0,200,self.view.frame.width,self.view.frame.height-200-104))
         commentTableView.hidden = true
        commentTableView.dataSource = self
        self.view.addSubview(commentTableView)
        
        serverResponse = getResponse(Servantdata.servantID) as String
        commentlabel = UILabel(frame:CGRectMake(8,8,self.view.frame.width,40))
        commentlabel.textColor = UIColor.grayColor()
        commentlabel.text = "该人员暂无评价!"
        commentlabel.textAlignment = NSTextAlignment.Center
        commentlabel.font = UIFont.systemFontOfSize(14)
        commentTableView.addSubview(commentlabel)
        
        introScroll = UIScrollView(frame:CGRectMake(0,200,self.view.frame.width,self.view.frame.height-200-104))
        introScroll.contentSize=CGSizeMake(width,self.view.frame.height*5)
        introScroll.pagingEnabled = false
        
        introScroll.showsHorizontalScrollIndicator = false
        introScroll.showsVerticalScrollIndicator = false
        //设置不可下拉
        introScroll.bounces = false
        introScroll.scrollsToTop = false
        self.view.addSubview(introScroll)
       
        var labelW  = self.view.frame.width - 20
        //是否住家
        var isStayHome = UILabel(frame: CGRectMake(8, 8, labelW, 20))
        //level.text = detailItem.facilitatorLevel
        if Servantdata.isStayHome {
            isStayHome.text = "是否住家:住家"
        }else {
            isStayHome.text = "是否住家:不住家"
        }
        //isStayHome.text = "是否住家:\(workerdetail.isStayHome)"
        isStayHome.textColor = UIColor.grayColor()
        isStayHome.font = UIFont.systemFontOfSize(12)
        introScroll.addSubview(isStayHome)
        
        //每月休息天数
        var holidayInMonth = UILabel(frame: CGRectMake(8, 8+20, labelW, 20))
        //level.text = detailItem.facilitatorLevel
        holidayInMonth.text = "每月休息天数:\(Servantdata.holidayInMonth)天"
        holidayInMonth.textColor = UIColor.grayColor()
        holidayInMonth.font = UIFont.systemFontOfSize(12)
        introScroll.addSubview(holidayInMonth)
        //培训经历
        //计算文字的高度
        let text1 = Servantdata.trainingIntro
        let statusLabelText1 = text1
        var font = UIFont.systemFontOfSize(14)
        var statusLabelSize1 = statusLabelText1.sizeWithAttributes([NSFontAttributeName:font])
        //根据高度设LabelFrame
        var H1 = statusLabelSize1.height
        var W1 = statusLabelSize1.width
        var TH1 = H1*(W1/labelW+1)
        
        var trainingIntro = UILabel(frame: CGRectMake(8,50,labelW, TH1))
        trainingIntro.text = "培训经历:\(Servantdata.trainingIntro)"
        trainingIntro.textColor = UIColor.grayColor()
        trainingIntro.font = UIFont.systemFontOfSize(12)
        //保留整个单词
        //trainingIntro.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //保留整个字符
        //trainingIntro.lineBreakMode = NSLineBreakMode.ByCharWrapping
        //以边界为止
        trainingIntro.lineBreakMode = NSLineBreakMode.ByClipping
        trainingIntro.numberOfLines = 0
        introScroll.addSubview(trainingIntro)
        var trainingYH = CGFloat(50+TH1)
        
        //所获奖项
        //计算文字的高度
        var text2 = Servantdata.servantHonors
        var statusLabelText2 = text2
        var statusLabelSize2 = statusLabelText2.sizeWithAttributes([NSFontAttributeName:font])
        //根据高度设LabelFrame
        var H2 = statusLabelSize2.height
        var W2 = statusLabelSize2.width
        var TH2 = H2*(W2/labelW+1)
        var servantHonors = UILabel(frame: CGRectMake(8, trainingYH+4, labelW, TH2))
        servantHonors.text = "所获奖项:\(Servantdata.servantHonors)"
        servantHonors.textColor = UIColor.grayColor()
        servantHonors.font = UIFont.systemFontOfSize(12)
        servantHonors.lineBreakMode = NSLineBreakMode.ByCharWrapping
        servantHonors.numberOfLines = 0
        introScroll.addSubview(servantHonors)
        var Honors = CGFloat(trainingYH+TH2+4)
        //工作介绍
        //计算文字的高度
        var text3 = Servantdata.servantIntro
        var statusLabelText3 = text3
        var statusLabelSize3 = statusLabelText3.sizeWithAttributes([NSFontAttributeName:font])
        //根据高度设LabelFrame
        var H3 = statusLabelSize3.height
        var W3 = statusLabelSize3.width
        var TH3 = H3*(W3/labelW+1)
        var servantIntro = UILabel(frame: CGRectMake(8, Honors+4, labelW, TH3))
        //level.text = detailItem.facilitatorLevel
        servantIntro.text = "工作介绍:\(Servantdata.servantIntro)"
        servantIntro.textColor = UIColor.grayColor()
        //        servantIntro.lineBreakMode = NSLineBreakMode.ByCharWrapping
        servantIntro.lineBreakMode = NSLineBreakMode.ByWordWrapping
        servantIntro.numberOfLines = 0
        servantIntro.font = UIFont.systemFontOfSize(12)
        introScroll.addSubview(servantIntro)
        var servantintroYH = CGFloat(Honors+TH3+8)
        
     
         introScroll.contentSize=CGSizeMake(width,servantintroYH)
        
        
        
        
    }
    //分段选择器的函数
    func selected() {
         //读取控件
        var x = segmentedControl.selectedSegmentIndex
        switch(x){
        case 0:
            introScroll.hidden = false
            commentTableView.hidden = true
 
            break
        default:
             introScroll.hidden = true
             commentTableView.hidden = false
             
             if serverResponse == "Success" {
                
                commentdata =  getSconmmentData(Servantdata.servantID) as! [CommentInfo]
               commentlabel.hidden = true
                
             }else {
                commentlabel.hidden = false
                
             }


            break
        }
        
        
    }
    
    func Order(){
        
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
        
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
            
            isCollect = GetServantCollect(Servantdata.servantID, customerid) as String
            
            if isCollect == "yes" {
                var serviceresponse = deleteSCollection(customerid,Servantdata.servantID)
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
                
                var serviceresponse =  addSCollection(customerid,Servantdata.servantID,Servantdata.servantName)
                
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
        
        
        return 1;
            
 
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        
            return commentdata.count
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell",forIndexPath: indexPath) as! CommentTCell
        
        let Commentcell = commentdata[indexPath.row] as CommentInfo
        cell.customer.text = Commentcell.customerID
        cell.comment.text = Commentcell.commentType
        cell.time.text = Commentcell.commentDate
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
        commentTableView.delegate  = self
        readNSUerDefaults()
        if customerid != "" && loginPassword != "" {
            isCollect = GetServantCollect(Servantdata.servantID, customerid) as String
            
        }
        
        
        if isCollect == "yes" {
            rightButton.title = "取消收藏"
        }else {
            rightButton.title = "收藏"        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
                commentTableView.delegate = nil
        
    }
    
    
}
