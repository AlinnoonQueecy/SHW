////
////  Maintwo.swift
////  SHW
////
////  Created by Zhang on 15/6/24.
////  Copyright (c) 2015年 star. All rights reserved.
//
//
//import UIKit
//
//class Maintwo: UIViewController {
//    
//     var select:String?
//     var titleOfState:String = ""
//    
//     var serviceTypeData:[ServiceType]=[]
//    //声明导航条
//    var navigationBar : UINavigationBar?
//    
////    @IBAction func Reply(sender: AnyObject) {
////        self.dismissViewControllerAnimated(true , completion: nil )
////    }
//    
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            serviceTypeData = refreshServiceType(select!) as! [ServiceType]
//            //serviceTypeData = refreshServiceType("家政服务") as! [ServiceType]
//            
//            //实例化导航条
//            navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.width, 64))
//            self.view.addSubview(navigationBar!)
//            println("创建导航条详情")
//            onMakeNavitem()
//
//            var pageWidth = self.view.frame.width
//            var pageHeight = self.view.frame.height
//            var scrollView = UIScrollView()
//            scrollView.frame = CGRectMake(0, 64, pageWidth, pageHeight)
//            scrollView.contentSize=CGSizeMake(pageWidth, pageHeight*3)
//            //scrollView.contentInset = UIEdgeInsetsMake(0,64,-49, 0)
//            self.automaticallyAdjustsScrollViewInsets = false
//
//            scrollView.pagingEnabled = false
//            scrollView.bounces = false
//            scrollView.showsHorizontalScrollIndicator = false
//            scrollView.alwaysBounceVertical = false
//            scrollView.showsVerticalScrollIndicator = false
//            scrollView.scrollsToTop = false
//            self.view.addSubview(scrollView)
//            
//            
////            var terms = HttpData.Item.count
//            var terms = serviceTypeData.count
//            var width = (pageWidth-20)/3
//            var a = terms%3
//            for var i = 0;i < terms;i++ {
//                
//                let term1 = UIButton(frame:CGRectMake(8+(width+2)*CGFloat(i%3),CGFloat(i/3)*(width+4), width,width))
//                term1 .setTitle(serviceTypeData[i].typeName , forState:UIControlState.Normal)
//                term1.setTitleShadowColor(UIColor.whiteColor(),forState: UIControlState.Normal)
//                term1.backgroundColor = UIColor.orangeColor()
//                term1.titleLabel?.font = UIFont.systemFontOfSize(15)
//                term1.showsTouchWhenHighlighted = true
//                term1.addTarget(self , action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
//                scrollView.addSubview(term1)
//            }
//            if a == 0 {
//                scrollView.contentSize = CGSizeMake(pageWidth, CGFloat(terms/3)*(width+4)+width+5)}
//            else{
//                scrollView.contentSize = CGSizeMake(pageWidth, CGFloat(terms/3+1)*(width+4)+width+5)
//            }
//
//            
//        }
//    
//    //导航条详情
//    func reply (){
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func onMakeNavitem() -> UINavigationItem{
//        println("创建导航条step1")
//        //创建一个导航项
//        var navigationItem = UINavigationItem()
//        //创建左边按钮
//       var leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
//          //var leftButton =  UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Bordered, target: self, action: "reply")
//        //导航栏的标题
//        navigationItem.title = "类别详情"
//        //设置导航栏左边按钮
//        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
//      
//        navigationBar?.pushNavigationItem(navigationItem, animated: true)
//        
//        
//        return navigationItem
//    }
//  func tapped(term1:UIButton){
//           
//             titleOfState = term1.titleForState(.Normal)!
//             println("标题\(titleOfState)")
//             self.performSegueWithIdentifier("toitem", sender: self)
//    }
//        //页面跳转时
////       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////                if segue.identifier == "toitem"{
////                        //通过seque的标识获得跳转目标
////                        let controller = segue.destinationViewController as BusinessVC
////                        //设置代理
////                       // controller.delegate = self
////                        //将值传递给新页面
////                         let object = titleOfState
////                        controller.selectInfo = titleOfState = object
////                    }
////            }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier! == "toitem" {
//            let controller = segue.destinationViewController as! BusinessVC
//            var  object = titleOfState
//            controller.selectInfo = object
//            println(controller.selectInfo)
//            println("fffffff")
//            
//            
//        }
//    }
//        override func didReceiveMemoryWarning() {
//            super.didReceiveMemoryWarning()
//            // Dispose of any resources that can be recreated.
//        }
//        
//}
//
//
//
//
//
