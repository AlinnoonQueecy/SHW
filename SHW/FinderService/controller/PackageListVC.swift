//
//  PackageListVC.swift
//  
//
//  Created by Zhang on 15/12/4.
//
//

import UIKit

class PackageListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate {
    //接受传递过来的参数
    var facilitatorID:String!
    
    var PackageItemData:[serviceItemInfo]=[]
    
    
    @IBOutlet weak var PackageListTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        if  PackageItemData.count == 0 {
            let alert =  UIAlertView(title: "", message: "该商家暂时没有一口价项目!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            
        }else{
            self.title = PackageItemData[0].facilitatorName
        }
        PackageListTV.dataSource = self
        PackageListTV.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func  loadData(){
        
        PackageItemData = refreshPackageItem(facilitatorID!) as! [serviceItemInfo]
    }
    
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //创建cell
        
        var cell = tableView.dequeueReusableCellWithIdentifier("packageCell", forIndexPath: indexPath) as! packageCell
        
        let Data = PackageItemData[indexPath.row] as serviceItemInfo
        cell.introLabel.text = Data.itemIntro//名称
        cell.facilitator.text = Data.facilitatorName//商户
        //cell.rank.image = imageForRank(business.facilitatorLevel)
        //        //网络地址获取图片
        //        //1.定义一个地址字符串常量
        let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/service/\(Data.id)/\(Data.servicePicture)"
        cell.packageImage.setZYHWebImage(imageUrlString, defaultImage: "1211.jpg")
        cell.price.text = "\(Data.priceDescription)元/次"
        cell.item.text = Data.serviceType
        
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    override func viewDidLayoutSubviews() {
        
        PackageListTV.frame = CGRectMake(0, 0,self.view.frame.width,self.view.frame.height-64)
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return PackageItemData.count;
        
    }

    //cell响应事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.performSegueWithIdentifier("topackageItemDetail", sender: self)
        
        //        let svc = PackageItemVC ()
        //        svc.ItemData = PackageItemInfo[indexPath.row] as serviceItemInfo
        //
        //        self.navigationController!.pushViewController(svc,animated:true)
        //
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if let indexPath = self.PackageListTV.indexPathForSelectedRow(){
            var  object = PackageItemData[indexPath.row] as serviceItemInfo
            (segue.destinationViewController as! PackageItemVC).ItemData = object
            
            
        }
        
        
    }



    override func  viewWillAppear(animated: Bool) {
        
        PackageListTV.delegate = self
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        PackageListTV.delegate = nil
        
    }

}
