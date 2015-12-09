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
    override func viewDidLoad() {
        super.viewDidLoad()
        let  width = self.view.frame.width
        
        self.title = "生活网用户协议"
        //introScroll = UIScrollView(frame:CGRectMake(0,0,self.view.frame.width,self.view.frame.height-64))
        introScroll.contentSize=CGSizeMake(self.view.frame.width,self.view.frame.height*5)
        introScroll.pagingEnabled = false
        
        introScroll.showsHorizontalScrollIndicator = false
        introScroll.showsVerticalScrollIndicator = false
        //设置不可下拉
        introScroll.bounces = false
        introScroll.scrollsToTop = false
        self.view.addSubview(introScroll)
        agreement.textColor = UIColor.grayColor()
       
        
        introScroll.contentSize=CGSizeMake(width,4820)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        var width = self.view.frame.width
        introScroll.frame = CGRectMake(0,0,width,self.view.frame.height-64)
        agreement.frame =  CGRectMake(5, 5, width-10, 4820)
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
