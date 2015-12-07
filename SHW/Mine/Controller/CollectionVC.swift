//
//  CollectionVC.swift
//  SHW
//
//  Created by Zhang on 15/7/23.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController,UITableViewDataSource,UITableViewDelegate ,JSDropDownMenuDataSource,JSDropDownMenuDelegate {
        
        
 
      
    //change by LZF
    var data1 :[String] = []
 
    var currentData1Index : Int = 0
 
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var CollectTable: UITableView!
    //读取本地数据
   var customerid:String = ""
   var loginPassword:String = ""
 
    var isPerson =  0 //声明点击店家还是人员
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
  
           CollectTable.dataSource = self
  
            FacilitatorData = refreshFCollection(customerid, "", "", "") as [facilitatorInfo]
            ServantData = refreshSCollection(customerid, "")
            data1 = ["商家","人员"]

            var menu = JSDropDownMenu(origin: CGPointMake(0, 0), andHeight: 30)
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
           

            CollectTable.frame =  CGRectMake(0, 36, width, self.view.frame.height-100)
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
            
            if isPerson  ==  0 {
            let collect = FacilitatorData[indexPath.row] as facilitatorInfo
            cell.facilitatorName.text = "商家名称:\(collect.facilitatorName)"
            cell.itemName.text = "联系电话:\(collect.contactPhone)"
            cell.servicePay.text = "信用评分:\(collect.creditScore)分"
            //网络地址获取图片
            //1.定义一个地址字符串常量
                 let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/\(collect.facilitatorLogo)"
 
                
                cell.picture.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg")
            }else if  isPerson == 1 {
                
                let collect = ServantData[indexPath.row] as ServantInfo
                cell.facilitatorName.text = "人员姓名:\(collect.servantName)"
                cell.itemName.text = "所属公司:\(collect.facilitatorName)"
                cell.servicePay.text = "从业年限:\(collect.workYears)年"
                //网络地址获取图片
                //1.定义一个地址字符串常量
                let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/servant/\(collect.id)/\(collect.headPicture)"
                
 
                 cell.picture.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg")
                
            }
            //圆角
            cell.picture.layer.cornerRadius = 26.5
            cell.picture.layer.masksToBounds = true
            return cell
      }
    
        
 
        
    
       // Return the number of sections.
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1;
        }
        
        // Return the number of rows in the section.
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
            var  count = 0
            if isPerson == 0 {
                //返回商家数量作为表格的行数
                count = FacilitatorData.count;
                
            }else if isPerson == 1 {
                //返回人员数量作为表格的行数
                count = ServantData.count;
                
            }
            return count

            }
    
    
    
        //-------------------Table view
  
    //cell响应事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isPerson == 0 {
           
            self.performSegueWithIdentifier("toFDetail", sender: self)
           
        }else if isPerson == 1 {
            let svc = workerViewController()
            if let indexPath = self.CollectTable.indexPathForSelectedRow(){
                svc.Servantdata = ServantData[indexPath.row]
                
            }
            self.navigationController!.pushViewController(svc,animated:true)

//            self.performSegueWithIdentifier("toSDetail", sender: self)
    
        }
        
        
    }

 
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
 
        
        return 0;
    }
    
    func menu(menu: JSDropDownMenu!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
        
        if (column==0) {
            return data1.count;
        }
 
        
        return 0;
    }
    
    func menu(menu: JSDropDownMenu!, titleForColumn column: Int) -> String! {
        
        switch (column) {
        case 0:
            return data1[0] as String;
 
        default:
            return nil;
        }
    }
    
    func menu(menu: JSDropDownMenu!, titleForRowAtIndexPath indexPath: JSIndexPath!) -> String! {
        
 
            return data1[indexPath.row] as String
 
    }
    //点击触发函数
    func menu(menu: JSDropDownMenu!, didSelectRowAtIndexPath indexPath: JSIndexPath!) {
 
        row0 = indexPath.row
        if row0 ==  0 {
            FacilitatorData = refreshFCollection(customerid, "", "", "") as [facilitatorInfo]
            isPerson = 0
            CollectTable.reloadData()
        }else if row0 == 1 {
            ServantData = refreshSCollection(customerid, "")
            isPerson = 1
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
               
            }
        }else if segue.identifier=="toSDetail"{
            if let indexPath = self.CollectTable.indexPathForSelectedRow(){
                var  object = ServantData[indexPath.row]
            
                (segue.destinationViewController as! workerViewController).Servantdata = object
            
            }
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        CollectTable.delegate = self
        
      
    }
    
    override func viewWillDisappear(animated: Bool) {
        CollectTable.delegate = nil
        
 
    }


        
}
