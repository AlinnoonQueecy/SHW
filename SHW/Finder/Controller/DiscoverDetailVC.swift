//
//  DiscoverDetailVC.swift
//  
//
//  Created by Zhang on 15/12/4.
//
//

import UIKit

class DiscoverDetailVC: UIViewController {
    //声明接收到的数据
    var Data:facilitatorAdvertise?
    
    //介绍
    var introScroll = UIScrollView()
    //图片
    let introImg = UIImageView()
    //图片url
    var imageUrlString:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "详情"
         var width = self.view.frame.width
        
        
        introImg.frame = CGRectMake(0,0,width, 150)
        //网络地址获取图片
        //1.定义一个地址字符串常量
     let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/\(Data!.advertisePicture)"
        
        introImg.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg" )
        self.view.addSubview(introImg)
        
        introScroll = UIScrollView(frame:CGRectMake(0,150,self.view.frame.width,self.view.frame.height-150-64))
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
      
        var statusLabelText:NSString = Data!.advertiseIntro
        var font = UIFont.systemFontOfSize(12)
        var statusLabelSize = statusLabelText.sizeWithAttributes([NSFontAttributeName:font])
        //根据高度设LabelFrame
        var H = statusLabelSize.height
        var W = statusLabelSize.width
        var labelW = self.view.frame.width - 16
        var TH = H*(W/labelW+1)
        var introheight = TH
        let introText = UILabel(frame:CGRectMake(8,8,labelW,introheight ))
        introText.text = Data!.advertiseIntro
        introText.textColor = UIColor.grayColor()
        introText.font = font
        introText.numberOfLines = 0
        introScroll.addSubview(introText)
        introScroll.contentSize=CGSizeMake(width,introheight)




    
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
