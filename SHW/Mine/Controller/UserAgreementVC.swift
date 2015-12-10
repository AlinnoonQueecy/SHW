//
//  UserAgreementVC.swift
//  
//
//  Created by Zhang on 15/12/8.
//
//

import UIKit

class UserAgreementVC: UIViewController,UIScrollViewDelegate{

    @IBOutlet weak var introScroll: UIScrollView!
    @IBOutlet weak var agreement: UITextView!
    //声明导航条
    let   navigationBar =  UINavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        let  width = self.view.frame.width
        navigationBar.frame = CGRectMake(0, 0, self.view.frame.width, 64)
        onMakeNavitem()
        self.view.addSubview(navigationBar)
       
        
        introScroll.pagingEnabled = false
        
        introScroll.showsHorizontalScrollIndicator = false
        introScroll.showsVerticalScrollIndicator = false
        //设置不可下拉
        introScroll.bounces = false
        introScroll.scrollsToTop = false
        //self.view.addSubview(introScroll)
        agreement.textColor = UIColor.grayColor()
       
        
        introScroll.contentSize=CGSizeMake(width,4820)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        var width = self.view.frame.width
        introScroll.frame = CGRectMake(0,64,width,self.view.frame.height-64)
        agreement.frame =  CGRectMake(5, 70, width-10, 4820)
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
        //        var leftButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: "reply")
        var leftButton =  UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "reply")
        //导航栏的标题
        navigationItem.title = "生活网用户协议"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar.pushNavigationItem(navigationItem, animated: true)
        
        return navigationItem
    }
}
