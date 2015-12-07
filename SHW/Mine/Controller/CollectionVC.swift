//
//  CollectionVC.swift
//  SHW
//
//  Created by Zhang on 15/7/23.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController,UITableViewDataSource,UITableViewDelegate ,JSDropDownMenuDataSource,JSDropDownMenuDelegate {
        
        
        //声明导航条
        var navigationBar : UINavigationBar?
      
    //change by LZF
    var data1 :[String] = []
 
    var currentData1Index : Int = 0
 
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var CollectTable: UITableView!
    //读取本地数据
   var customerid:String = ""
   var loginPassword:String = ""
 
    var notPerson =  1 //声明点击店家还是人员
    //存储网络数据
 
    var FacilitatorData:[facilitatorInfo] = []
    var ServantData:[ServantInfo] = []
    var types :[String] = []
 
    //筛选和排序
    var  row0   =  0
    //初始化函数
        override func viewDidLoad() {
            super.viewDidLoad()
            var width = self.view.frame.width
            //读取用户信息，如果不是第一次登录，则会自动登录
            readNSUerDefaults()
 
            println("infoCollection:\(FacilitatorData)")
 
            CollectTable.dataSource = self
            CollectTable.delegate = self
 
            FacilitatorData = refreshFCollection(customerid, "", "", "") as [facilitatorInfo]
            
               println("商家商家商家")
 

      
     
            
//            //实例化导航条
//            navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
//            self.view.addSubview(navigationBar!)
//            println("创建导航条详情")
//            onMakeNavitem()
            
            data1 = ["商家","人员"]
 
            
            var menu = JSDropDownMenu(origin: CGPointMake(0, 68), andHeight: 30)
            menu.indicatorColor = UIColor(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 1.0)
            menu.separatorColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
            menu.textColor = UIColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0)
            menu.dataSource = self;
            menu.delegate = self;
            
            
            label.removeFromSuperview()
            self.view.addSubview(menu)
            
            
            
        }
        
        override func viewDidLayoutSubviews() {
            var width = self.view.frame.width
           

            CollectTable.frame =  CGRectMake(0, 100, width, self.view.frame.height-100)
    }
 
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        //-------------------Table view data source-----------------------------
        // 根据indexPath(section,row)创建每行cell及其内容
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            println("显示列表")
            //创建cell
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectCell", forIndexPath: indexPath) as! CollectCell
            
            if notPerson  == 1 {
            let collect = FacilitatorData[indexPath.row] as facilitatorInfo
            cell.facilitatorName.text = "商家名称:\(collect.facilitatorName)"
            cell.itemName.text = "联系电话:\(collect.contactPhone)"
            cell.servicePay.text = "信用评分:\(collect.creditScore)分"
            //网络地址获取图片
            //1.定义一个地址字符串常量
            let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/facilitator/\(collect.id)/\(collect.facilitatorLogo)"
//            //2.通过String类型，转换NSUrl对象
//            let url :NSURL = NSURL(string: imageUrlString)!
//            println("url:\(url)")
//            //3.从网络获取数据流
//            if let data:NSData = NSData(contentsOfURL: url){
//                //4.通过数据流初始化图片
//                cell.picture.image = UIImage(data: data)
//            }else {
//                
//                cell.picture.image = UIImage(named: "reserve2.jpg")!
//            }
                
//                var data = getImageData(imageUrlString)
//                 var data :NSData?
//                if data == nil{
//                    cell.picture.image = UIImage(named: "reserve2.jpg")
//                }else{
//                    cell.picture.image = UIImage(data: data!)
//                    
//                    
//                }
                
                cell.picture.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg")
            }else if  notPerson == 0 {
                
                let collect = ServantData[indexPath.row] as ServantInfo
                cell.facilitatorName.text = "人员姓名:\(collect.servantName)"
                cell.itemName.text = "所属公司:\(collect.facilitatorName)"
                cell.servicePay.text = "从业年限:\(collect.workYears)年"
                //网络地址获取图片
                //1.定义一个地址字符串常量
                let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/servant/\(collect.id)/\(collect.headPicture)"
//                //2.通过String类型，转换NSUrl对象
//                let url :NSURL = NSURL(string: imageUrlString)!
//                println("url:\(url)")
//                //3.从网络获取数据流
//                if let data:NSData = NSData(contentsOfURL: url){
//                    //4.通过数据流初始化图片
//                    //
//                    cell.picture.image = UIImage(data: data)
//                }else {
//                    
//                    cell.picture.image = UIImage(named: "122.jpg")!
//                }
                
//                var data = getImageData(imageUrlString)
//               
//                if data == nil{
//                    cell.picture.image = UIImage(named: "reserve2.jpg")
//                }else{
//                    cell.picture.image = UIImage(data: data!)
//                    
//                    
//                }
                 cell.picture.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg")
                
            }
            return cell
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
            navigationItem.title = "收藏列表"
            //设置导航栏左边按钮
            navigationItem.setLeftBarButtonItem(leftButton, animated: true)
            navigationBar?.pushNavigationItem(navigationItem, animated: true)
            return navigationItem
        }
        
    
       // Return the number of sections.
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1;
        }
        
        // Return the number of rows in the section.
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
            var  count = 0
            if notPerson == 1 {
                //返回商家数量作为表格的行数
                count = FacilitatorData.count;
                
            }else if notPerson == 0 {
                //返回人员数量作为表格的行数
                count = ServantData.count;
                
            }
            return count

            }
    
        //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //        return "";//HttpData.channelTitles[section]
        //    }
    
    
    //滑动删除必须实现的方法
    
//    //Override to support editing the table view.
//     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            //Delete the row from the data source
//            println("删除\(indexPath.row)")
//            info.removeAtIndex(indexPath.row)
//            println("删\(indexPath.row)")
//            println(indexPath.row)
//         
//            //collectionTable.reloadData()
//            self.CollectTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Left)
//            
//        } else if editingStyle == .Insert {
//            //Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    
//    //滑动删除
//    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.Delete
//    }
//    //修改删除按钮的文字
//     func  tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
//        return "删除"
//    }
    

    //从NSUerDefaults 中读取数据
//    func readNSUerDefaults () {
//        
//        var userDefaultes = NSUserDefaults.standardUserDefaults()
//        //customerid = userDefaultes.stringForKey("customerID")!
//         //println("collectionID\(customerid)")
//    }
    

    
        //-------------------Table view
  
    //cell响应事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if notPerson == 1 {
            println("去商家详情2")
            self.performSegueWithIdentifier("toFDetail", sender: self)
            println("去商家详情")
        }else if notPerson == 0 {
            println("去人员详情1")
            self.performSegueWithIdentifier("toSDetail", sender: self)
            println("去人员详情")
        }
        
        
    }

    
    //change by LZF
    //列数
    func numberOfColumnsInMenu(menu: JSDropDownMenu!) -> Int
    {
        return 1
    }
    
    func displayByCollectionViewInColumn(column: Int) -> Bool
    {
        return false;
    }
    
    func haveRightTableViewInColumn(column: Int) -> Bool
    {
        return false;
    }
    
    func widthRatioOfLeftColumn(column: Int) -> CGFloat
    {
        return 1;
    }
    
    func currentLeftSelectedRow(column: Int) -> Int
    {
        if (column==0) {
            
            return currentData1Index;
            
        }
//        if (column==1) {
//            
//            return currentData2Index;
//        }
        
        return 0;
    }
    
    func menu(menu: JSDropDownMenu!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
        
        if (column==0) {
            return data1.count;
        }
            //else if (column==1){
//            
//            return data2.count;
//            
//        } else if (column==2){
//            
//            return data3.count;
//        }
        
        return 0;
    }
    
    func menu(menu: JSDropDownMenu!, titleForColumn column: Int) -> String! {
        
        switch (column) {
        case 0:
            return data1[0] as String;
//        case 1:
//            return data2[0] as! String;
//            break;
//        case 2:
//            return data3[0] as! String;
        default:
            return nil;
        }
    }
    
    func menu(menu: JSDropDownMenu!, titleForRowAtIndexPath indexPath: JSIndexPath!) -> String! {
        
//        if (indexPath.column==0) {
            return data1[indexPath.row] as String
//        } else if (indexPath.column==1) {
//            
//            return data2[indexPath.row] as! String
//            
//        } else {
//            
//            return data3[indexPath.row] as! String
//        }
    }
    //点击触发函数
    func menu(menu: JSDropDownMenu!, didSelectRowAtIndexPath indexPath: JSIndexPath!) {
        
        println("我点击的是\(indexPath.column),\(indexPath.row)")
        row0 = indexPath.row
        if row0 ==  0 {
              FacilitatorData = refreshFCollection(customerid, "", "", "") as [facilitatorInfo]
            notPerson = 1
            CollectTable.reloadData()
        }else if row0 == 1 {
            ServantData = refreshSCollection(customerid, "")
            notPerson = 0
            CollectTable.reloadData()
            
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier=="toFDetail"{
            if let indexPath = self.CollectTable.indexPathForSelectedRow(){
                var  object = FacilitatorData[indexPath.row].facilitatorID
                (segue.destinationViewController as! BusinessDVC).facilitatorid = object
                println("到商家详情")
            }
        }else if segue.identifier=="toSDetail"{
            if let indexPath = self.CollectTable.indexPathForSelectedRow(){
                var  object = ServantData[indexPath.row]
                println("到人员详情")
                (segue.destinationViewController as! workerViewController).Servantdata = object
                println("到人员详情")
            }
        }
        
    }

        
}
