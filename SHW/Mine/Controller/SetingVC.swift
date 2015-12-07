//
//  SetingVC.swift
//  
//
//  Created by Zhang on 15/12/7.
//
//

import UIKit

class SetingVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var Table: UITableView!
   let baseArray:[String] = ["意见反馈","服务条款","检查更新","关于我们"]
    //读取本地数据
    var  customerid:String  = ""
    var loginPassword:String = ""
    
    override func viewDidLoad() {
        readNSUerDefaults ()
        super.viewDidLoad()
        self.title = "设置"
        Table.dataSource = self
        Table.delegate = self
        Table.scrollEnabled = false
        //Table.registerClass(SetingCell.self, forCellReuseIdentifier: "SetingCell")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        var width = self.view.frame.width
        Table.frame =  CGRectMake(0, 0, width, self.view.frame.height-36)
    }
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if customerid != "" && loginPassword != ""{

        return 2
        }else {
        return  1
        }
        return  0
        
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if customerid != "" && loginPassword != ""{
        if section == 0{
            return baseArray.count
        }else if section == 1{
            return 1
        
                }
        }else {
            
        return baseArray.count

                
        }
       return 0
                
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0{
            let  cell = tableView.dequeueReusableCellWithIdentifier("SetingCell", forIndexPath: indexPath) as! SetingCell
            
            let  imageName:[String]  = ["message","message","message","message"]
            let  image  = UIImage(named:imageName[indexPath.row])
            cell.Picture.image = image
            cell.Label.text = baseArray[indexPath.row]
             return cell
        }else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "退出登录"
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.textColor = UIColor.orangeColor()
            cell.textLabel?.font = UIFont.systemFontOfSize(17)
            return cell
        }
        return cell
    }
    //set Header Height
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
           if indexPath.section == 0 {
            
            
           }else if indexPath.section == 1{
        
           removeNSUerDefaults ()
            
        self.navigationController?.popViewControllerAnimated(true)
            
        }


        
        
        
    }
    //    //清除NSUerDefaults中数据
    func removeNSUerDefaults () {
        
        //将数据全部存储到NSUerDefaults中
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
        userDefaults.setObject("" , forKey: "customerID")
        userDefaults.setObject("", forKey: "loginPassword")
        
        //建议同步到磁盘，但不是必须得
        userDefaults.synchronize()
        
        
    }
    
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }

 

}
