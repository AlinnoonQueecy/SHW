//
//  ServiceItemVC.swift
//  
//
//  Created by Zhang on 15/12/3.
//
//
//商家爱服务项目列表
import UIKit
 class ServiceItemVC:UIViewController, UIAlertViewDelegate,UIScrollViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate{

    
    let introImg = UIImageView()
    var introScroll = UIScrollView()
    //声明BUtton
    var term1:UIButton?//最底层
    var ItemButton:UIButton?//项目Button
    var imageUrlString:String?
    //声明上个界面传递来的数据
     var detailItem:facilitatorInfo!
    //读取数据
    var ServiceItemData:[serviceItemInfo] = []
    //传递数据
    var ItemInfo:serviceItemInfo!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "服务项目"
        let  width = self.view.frame.width
        ServiceItemData = refreshCommonItem(detailItem.facilitatorID) as! [serviceItemInfo]
        
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
        
        
        introScroll = UIScrollView(frame:CGRectMake(0,180,self.view.frame.width,self.view.frame.height-180-104))
        introScroll.contentSize=CGSizeMake(width,self.view.frame.height*5)
        introScroll.pagingEnabled = false
        introScroll.showsHorizontalScrollIndicator = false
        introScroll.showsVerticalScrollIndicator = false
        //设置不可下拉
        introScroll.bounces = false
        introScroll.scrollsToTop = false
        self.view.addSubview(introScroll)
        var bounds = self.view.frame
        var ItemButtonW = (width-20)/3
         var ItemButtonH = CGFloat(40)
        var terms = ServiceItemData.count
       
        
        for var i = 0;i < terms;i++ {
            ItemButton = UIButton(frame:CGRectMake(8+(ItemButtonW+2)*CGFloat(i%3),8 + CGFloat(i/3)*(ItemButtonH+8), ItemButtonW,ItemButtonH))
            ItemButton! .setTitle(ServiceItemData[i].serviceType as String, forState:UIControlState.Normal)
            ItemButton!.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
            ItemButton!.backgroundColor = UIColor.orangeColor()
            ItemButton?.layer.cornerRadius = 15
            ItemButton!.titleLabel?.font = UIFont.systemFontOfSize(14)
            ItemButton!.showsTouchWhenHighlighted = true
            ItemButton!.addTarget(self , action: Selector("Common:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            introScroll.addSubview(ItemButton!)
           
        }
        introScroll.contentSize = CGSizeMake(width,8 + CGFloat(terms/3+1)*(ItemButtonH+8))
        
        
        
        //服务项目按钮
      
       
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
       
        
        
        
        
        
        

  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
