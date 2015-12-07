//
//  ViewController.swift/Users/zhang/Desktop/ Learn IOS/SHW/SHW/FinishTVCell.swift
//  未完成订单
//
//  Created by appl on 15/6/14.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {


    var detailItem:Finishinfo!
    var pageHeight = 1300
    var detailData:Finishinfo!
    @IBOutlet weak var scrollView: UIScrollView!
    //声明导航条
    var navigationBar : UINavigationBar?
    
    var ScrollY = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        var width = self.view.frame.width-16
         println("宽度:\(width)")
        
        
            detailItem = getOrderData(detailData.id)
        
            scrollView.bounds = self.view.bounds
            scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
            
            scrollView.contentSize=CGSizeMake(self.view.frame.width,self.view.frame.height*5)
 
            scrollView.pagingEnabled = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            //设置不可下拉
            scrollView.bounces = false
            scrollView.scrollsToTop = false
            //self.view.addSubview(scrollView)
            //Label设置
             var  detail : Finishinfo = self.detailItem!
            var orderNo = UILabel(frame: CGRectMake(8, 5, width, 20))
            orderNo.text = "订单编号:\(detail.orderNo)"
            orderNo.textColor = UIColor.blackColor()
            orderNo.font = UIFont.systemFontOfSize(15)
            scrollView.addSubview(orderNo)
        
        
            var orderStatus = UILabel(frame: CGRectMake(8, 25, width, 20))
            orderStatus.text = "订单状态:\(detail.orderStatus)"
            orderStatus.textColor = UIColor.orangeColor()
            orderStatus.font = UIFont.systemFontOfSize(15)
            scrollView.addSubview(orderStatus)
        
            var button8C = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
            var lable1 = UILabel(frame: CGRectMake(0, 45,width+16, 7))
            lable1.backgroundColor = button8C
            scrollView.addSubview(lable1)
                
            var customerID = UILabel(frame: CGRectMake(8,55 , width, 20))
            customerID.text = "客户账号:\(detail.customerID)"
            customerID.textColor = UIColor.blackColor()
            customerID.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(customerID)
            
        
            var customerName = UILabel(frame: CGRectMake(8, 75, width, 20))
            customerName.text = "客户姓名:\(detail.customerName)"
            customerName.textColor = UIColor.blackColor()
            customerName.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(customerName)
            
//            let scoreImg = UIImageView(frame: CGRectMake(75, 60, 80, 16))
//            scoreImg.image = imageForRank(Detail2.scoreImg)
//            scrollView.addSubview(scoreImg)
            
        
            var facilitatorID = UILabel(frame: CGRectMake(8, 95, width , 20))
            facilitatorID.text = "商家账号:\(detail.facilitatorID)"
            facilitatorID.textColor = UIColor.blackColor()
            facilitatorID.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(facilitatorID )

            var facilitatorName = UILabel(frame: CGRectMake(8, 115, width, 20))
            facilitatorName.text = "商家名称:\(detail.facilitatorName)"
            facilitatorName.textColor = UIColor.blackColor()
            facilitatorName.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(facilitatorName )
        
            var servantName = UILabel(frame: CGRectMake(8, 135, width, 20))
            servantName.text = "服务人员:\(detail.servantName)"
            servantName.textColor = UIColor.blackColor()
            servantName.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(servantName)

//            var servantID = UILabel(frame: CGRectMake(8, 155, width, 20))
//            servantID.text = "人员工号:\(detail.servantID)"
//            servantID.textColor = UIColor.blackColor()
//            servantID.font = UIFont.systemFontOfSize(14)
//            scrollView.addSubview(servantID)
        
        var lable2 = UILabel(frame: CGRectMake(0, 155,width+16, 7))
        lable2.backgroundColor = button8C
        scrollView.addSubview(lable2)

            var serviceType = UILabel(frame: CGRectMake(8, 165, width, 20))
            serviceType.text = "服务类型:\(detail.serviceType)"
            serviceType.textColor = UIColor.blackColor()
            serviceType.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(serviceType)

            var serviceContent = UILabel(frame: CGRectMake(8, 185, width, 40))
            serviceContent.text = "服务内容:\(detail.serviceContent)"
            serviceContent.numberOfLines = 0
////            serviceContent.lineBreakMode = .ByTruncatingMiddle//折行方式
//            serviceContent.adjustsFontSizeToFitWidth = true //字体适应label大小
//            serviceContent.baselineAdjustment = UIBaselineAdjustment.AlignCenters\\文本基线位置
            serviceContent.baselineAdjustment = .None
            serviceContent.textColor = UIColor.blackColor()
            serviceContent.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(serviceContent)
        var contactPhone = UILabel(frame: CGRectMake(8, 225, width, 20))
        contactPhone.text = "联系电话:\(detail.contactPhone)"
        contactPhone.textColor = UIColor.blackColor()
        contactPhone.font = UIFont.systemFontOfSize(14)
        contactPhone.numberOfLines = 0
        contactPhone.baselineAdjustment = .AlignBaselines
        scrollView.addSubview(contactPhone)
        var contactAddress = UILabel(frame: CGRectMake(8, 245, width, 40))
        contactAddress.text = "联系地址:\(detail.contactAddress)"
        contactAddress.textColor = UIColor.blackColor()
        contactAddress.font = UIFont.systemFontOfSize(14)
        contactAddress.numberOfLines = 0
        contactAddress.baselineAdjustment = .AlignBaselines
        scrollView.addSubview(contactAddress)
        

            
            var itemName = UILabel(frame: CGRectMake(8, 285, width, 20))
            itemName.text = "项目名称:\(detail.itemName)"
            itemName.textColor = UIColor.blackColor()
            itemName.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(itemName)
//
//            var itemID = UILabel(frame: CGRectMake(8, 305, width, 20))
//            itemID.text = "项目ID:\(detail.itemIDs)"
//            itemID.textColor = UIColor.blackColor()
//            itemID.font = UIFont.systemFontOfSize(14)
//            scrollView.addSubview(itemID)

        var lable3 = UILabel(frame: CGRectMake(0, 305,width+16, 7))
        lable3.backgroundColor = button8C
        scrollView.addSubview(lable3)
        
            var orderTime = UILabel(frame: CGRectMake(8,315, width, 20))
            orderTime.text = "订单时间:\(detail.orderTime)"
            orderTime.textColor = UIColor.blackColor()
            orderTime.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(orderTime)
            
            var confirmTime = UILabel(frame: CGRectMake(8, 335, width, 20))
            confirmTime.text = "确定时间:\(detail.confirmTime)"
            confirmTime.textColor = UIColor.blackColor()
            confirmTime.font = UIFont.systemFontOfSize(14)
            scrollView.addSubview(confirmTime)
            var H = CGFloat(355)
 
        var lable4 = UILabel(frame: CGRectMake(0, H,width+16, 7))
        lable4.backgroundColor = button8C
        scrollView.addSubview(lable4)

            var servicePrice = UILabel(frame: CGRectMake(8, H+10, width, 20))
            servicePrice.text = "服务费用:\(detail.servicePrice)元"
            servicePrice.textColor = UIColor.orangeColor()
            servicePrice.font = UIFont.systemFontOfSize(15)
            scrollView.addSubview(servicePrice)

            var paidAmount = UILabel(frame: CGRectMake(8, H+30
, width, 20))
            paidAmount.text = "已付金额:\(detail.paidAmount)元"
            paidAmount.textColor = UIColor.orangeColor()
            paidAmount.font = UIFont.systemFontOfSize(15)
            scrollView.addSubview(paidAmount)
        
        var lable5 = UILabel(frame: CGRectMake(0, H+50,width+16, 7))
        lable5.backgroundColor = button8C
        scrollView.addSubview(lable5)

            var customerEvaluate = UILabel(frame: CGRectMake(8, H+60, width, 40))
            customerEvaluate.text = "订单评价:\(detail.customerEvaluate)"
            customerEvaluate.textColor = UIColor.blackColor()
            customerEvaluate.font = UIFont.systemFontOfSize(14)
            customerEvaluate.numberOfLines = 0
            customerEvaluate.baselineAdjustment = .AlignBaselines
            scrollView.addSubview(customerEvaluate)

            var remarks = UILabel(frame: CGRectMake(8, H+100, width, 60))
            remarks.text = "备注:\(detail.remarks)"
            remarks.textColor = UIColor.blackColor()
            remarks.font = UIFont.systemFontOfSize(14)
            remarks.numberOfLines = 0
            scrollView.addSubview(remarks)
        
        
        var payButton = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, H+200, 250, 30))
        payButton.setTitle("立即支付", forState: UIControlState.Normal)
        payButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        payButton.backgroundColor = UIColor.orangeColor()
        payButton.layer.cornerRadius = 5
        payButton.showsTouchWhenHighlighted = true
        if detail.orderStatus == "待付款"{
            payButton.hidden = false
            payButton.enabled = true
        }else {
            payButton.enabled = false
            payButton.hidden = true
        }
        payButton.addTarget(self, action: "Pay:", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(payButton)

       var w = self.view.frame.width/2
        var EvaluationButton = UIButton(frame: CGRectMake((w-110)/2, H+200, 110, 30))
        EvaluationButton.setTitle("评价订单", forState: UIControlState.Normal)
        EvaluationButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        EvaluationButton.backgroundColor = UIColor.orangeColor()
        EvaluationButton.layer.cornerRadius = 5
        EvaluationButton.showsTouchWhenHighlighted = true
//        var refundButton = UIButton(frame: CGRectMake((3*w-110)/2, 530, 110, 30))
        var refundButton = UIButton()
        
       
       
        if detail.orderStatus == "付款完成"{
            EvaluationButton.hidden = false
            EvaluationButton.enabled = true
            refundButton = UIButton(frame: CGRectMake((3*w-110)/2, H+200, 110, 30))
            refundButton.hidden = false
            refundButton.enabled = true
        }else if detail.orderStatus == "已完成"{
            EvaluationButton.hidden = true
            EvaluationButton.enabled = false
            refundButton = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, H+200, 250, 30))
            refundButton.hidden = false
            refundButton.enabled = true
        }else {
            EvaluationButton.hidden = true
            EvaluationButton.enabled = false
            refundButton.hidden = true
            refundButton.enabled = false
        }
        
        refundButton.setTitle("申请退款", forState: UIControlState.Normal)
        refundButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        refundButton.backgroundColor = UIColor.orangeColor()
        refundButton.layer.cornerRadius = 5
        refundButton.showsTouchWhenHighlighted = true
        
        
        var alterRefund = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, H+200, 250, 30))
        alterRefund.setTitle("修改退款", forState: UIControlState.Normal)
        alterRefund.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        alterRefund.backgroundColor = UIColor.orangeColor()
        alterRefund.layer.cornerRadius = 5
        alterRefund.showsTouchWhenHighlighted = true
        
        if  detail.orderStatus == "申请退款"{
            alterRefund.hidden = false
            alterRefund.enabled = true
          }else {
            alterRefund.hidden = true
            alterRefund.enabled = false
           }
        var CheckRefund = UIButton(frame: CGRectMake((self.view.frame.width-250)/2, H+200, 250, 30))
        CheckRefund.setTitle("查看退款详情", forState: UIControlState.Normal)
        CheckRefund.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        CheckRefund.backgroundColor = UIColor.orangeColor()
        CheckRefund.layer.cornerRadius = 5
        CheckRefund.showsTouchWhenHighlighted = true
        
        
        if  detail.orderStatus == "退款中" || detail.orderStatus == "已退款"{
            CheckRefund.hidden = false
            CheckRefund.enabled = true
        }else {
            CheckRefund.hidden = true
            CheckRefund.enabled = false
        }

        
        
        
        EvaluationButton.addTarget(self, action: "Evaluation:", forControlEvents: UIControlEvents.TouchUpInside)
        refundButton.addTarget(self, action: "refund:", forControlEvents: UIControlEvents.TouchUpInside)
        alterRefund.addTarget(self, action: "ralterRefund:", forControlEvents: UIControlEvents.TouchUpInside)
        CheckRefund.addTarget(self, action: "CheckRefund:", forControlEvents: UIControlEvents.TouchUpInside)

        scrollView.addSubview(refundButton)
        scrollView.addSubview(alterRefund)
        scrollView.addSubview(EvaluationButton)
         scrollView.addSubview(CheckRefund)
         ScrollY = H+250
         scrollView.contentSize=CGSizeMake(self.view.frame.width,H+250)
        

        
    }
    //支付函数
    func Pay(payButton:UIButton){
        self.performSegueWithIdentifier("toPay", sender: self)
    }

    //评价函数
    func Evaluation(EvaluationButton:UIButton){
        self.performSegueWithIdentifier("toEvaluate", sender: self)
    }

    //退款函数
    func refund(refundButton:UIButton){
        self.performSegueWithIdentifier("toRefund", sender: self)
    }
    //修改退款
    func ralterRefund(alterRefund:UIButton){
        self.performSegueWithIdentifier("alterRefund", sender: self)
    }
  //查看退款详情
    func CheckRefund(alterRefund:UIButton){
        self.performSegueWithIdentifier("toDetail", sender: self)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
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
    
    
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier! == "toPay" {
            let controller = segue.destinationViewController as! PayVC
            var  object = detailItem
            controller.PayData = object
            
        }else if segue.identifier! == "toEvaluate" {
            let controller = segue.destinationViewController as! EvaluateVC
            var  object = detailItem
            controller.EvaluateData = object
            println(detailItem)
            
        }else if segue.identifier! == "toRefund" {
            let controller = segue.destinationViewController as! RefundVC
            var  object = detailItem
            controller.Data = object

        }else if segue.identifier! == "alterRefund" {
            let controller = segue.destinationViewController as! AlterRefund
            var  object = detailItem
            controller.Data = object
            
        }else if segue.identifier! == "toDetail" {
            let controller = segue.destinationViewController as! RefundDetailVC
            var  object = detailItem
            controller.Data = object
            
        }



    }

    override func  viewWillAppear(animated: Bool) {
    
        
        
    }
    
 
}