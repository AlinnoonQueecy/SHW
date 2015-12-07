//
//  TableViewController.swift
//  未完成订单
//
//  Created by appl on 15/6/9.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class FinishVController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate{
  
    @IBOutlet var yuding: UITableView!
    //读取本地数据
    var customerid:String = ""
    var loginPassword:String = ""
    //获取网络数据
    var Infor:[Finishinfo] = []
    var FinishDatas:[Finishinfo] = []
    //删除
     var barButtonItem:UIBarButtonItem?;
   
     //刷新
    var refreshControl = UIRefreshControl()
    var timer: NSTimer!
    //分段选择
    var segmentedControl = UISegmentedControl()
    //orderStatus
    var  orderStatus:String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单"
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        yuding.dataSource = self
        yuding.delegate = self
        //分段选择设置
        var arr = NSArray(objects: "全部","待接受","待付款","待评价","退款中")
        var sw = (self.view.frame.width-10)/4
        //设置item
        segmentedControl = UISegmentedControl(items: arr as [AnyObject])
        //设置位置
        segmentedControl.frame =  CGRectMake(5, 0,self.view.frame.width-10, 36)
        //设置颜色
        segmentedControl.tintColor = UIColor.orangeColor()
        //每个的宽度按segment的宽度平分
        segmentedControl.apportionsSegmentWidthsByContent =  true
        //选中第几个segment 一般用于初始化时选中
        segmentedControl.selectedSegmentIndex = 0
        //风格
        self.view.addSubview(segmentedControl)//添加到父视图
        //添加事件
        segmentedControl.addTarget(self, action: "selected", forControlEvents: UIControlEvents.ValueChanged)
           
        //初始下拉刷新控件
        refreshControl.attributedTitle = NSAttributedString(string: "松开后自动刷新")
        //背景色和tint颜色都要清除,保证自定义下拉视图高度自适应
        //refreshControl.tintColor = UIColor.clearColor()
        refreshControl.backgroundColor = UIColor.clearColor()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        yuding.addSubview(refreshControl)
        loadData()
        if customerid == "" || loginPassword == ""{

        let alert =  UIAlertView(title: "", message: "您还没有登录", delegate: self, cancelButtonTitle: "去登录")
        alert.show()
            
            
        }
        
        
        
           
    }
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
 
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        
        self.navigationController!.pushViewController(vc, animated:true)
        
    }

 
    
    // 下拉刷新方法
    func refresh() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "数据加载中...")
        //模拟加载数据
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,
            selector: "loadData", userInfo: nil, repeats: true)
       
        
    }
    //计时器时间到,加载数据
    func loadData() {
        FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
        self.yuding.reloadData()
        self.refreshControl.endRefreshing()
        timer?.invalidate()
        timer = nil
    }
    
    override func viewDidLayoutSubviews() {
        yuding.frame = CGRectMake(0, 36, self.view.frame.width, self.view.frame.height-100)
        
        
    }
    
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return FinishDatas.count;
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FinishTVCell
        
        let yud = FinishDatas[indexPath.row] as Finishinfo
        cell.orderNo.text = "订单编号:\(yud.orderNo)"
        cell.serviceType.text = "订单状态:\(yud.orderStatus)"
        cell.facilitator.text = "商家名称:\(yud.facilitatorName)"
        cell.servantName.text = "服务类型:\(yud.serviceType)"
        cell.servicePay.text = "服务费用:\(yud.servicePrice )元"
        //cell.pic.image = UIImage(named:yud.pic)

        return cell
    }
    //分段选择器的函数
    func selected() {
        println("点击开始")
        //读取控件
        var x = segmentedControl.selectedSegmentIndex
        switch(x){
        case 0:
            orderStatus = ""
            FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
            println("点击第一个")
            self.yuding.reloadData()

            break
        case 1:
            orderStatus = "待接受"
            FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
            println("点击第2个")
            self.yuding.reloadData()
            break
        case 2:
            orderStatus = "待付款"
            FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
            println("点击第3个")
            self.yuding.reloadData()
            break
        case 3:
            orderStatus = "付款完成"
            FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
            println("点击第3个")
            self.yuding.reloadData()
            break

        default:
            orderStatus = "退款"
            FinishDatas = refreshRefundOrder(customerid,orderStatus) as! [Finishinfo]
            println("点击其他")
            self.yuding.reloadData()
            break
        }
        
        
    }
    
    
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }
    
    override func  viewWillAppear(animated: Bool) {
         readNSUerDefaults()
//        if customerid == "" || loginPassword == ""{
//            
//            let alert =  UIAlertView(title: "", message: "您还没有登录", delegate: self, cancelButtonTitle: "去登录")
//            alert.show()
//            
//            
//        }
        FinishDatas = refreshOrderData(customerid,orderStatus) as! [Finishinfo]
        self.yuding.reloadData()
        
    }
    


    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier=="detail"{
            if let indexPath = self.yuding.indexPathForSelectedRow(){
                println("哈哈哈哈哈哈哈哈")
                let object = FinishDatas[indexPath.row] as Finishinfo
                println( "Finish:\(object)" )
                (segue.destinationViewController as! FinishViewController).detailData = object
               
            }
        }
    }
    


}
