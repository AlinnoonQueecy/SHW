//
//  ServantListVC.swift
//  
//
//  Created by Zhang on 15/12/4.
//
//
//商家人员列表
import UIKit

class ServantListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate{
    //接受传递过来的参数
    var facilitatorID:String!
    var facilitatorName:String!
    
    @IBOutlet weak var ServantLIstTV: UITableView!
    //保存一个商家的服务人员
    var ServantData:[ServantInfo] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         loadData()
       if  ServantData.count == 0 {
        let alert =  UIAlertView(title: "", message: "该商家暂时没有完善人员信息!", delegate: self, cancelButtonTitle: "确定")
        alert.show()
 
       }else{
       self.title = ServantData[0].facilitatorName
        }
        ServantLIstTV.dataSource = self
        ServantLIstTV.delegate = self
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  loadData(){
        
        ServantData = refreshServantData(facilitatorID!) as! [ServantInfo]
    }
    
    
    
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIndentifier:String = "ServantCell"
        let cell:ServantCell =  tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! ServantCell
        
        let Data = ServantData[indexPath.row] as ServantInfo
        
         cell.servantname.text = Data.servantName //名称
        cell.facilitator.text = Data.facilitatorName//所属公司
        
        
                //1.定义一个地址字符串常量
                let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/servant/\(Data.id)/\(Data.headPicture)"
        
                cell.picture.setZYHWebImage(imageUrlString, defaultImage: "122.jpg")
                if  Data.servantSalary == "" {
                    cell.salary.text = "暂无"
                }else{
                    cell.salary.text = "\(Data.servantSalary)元/月"
                }
                cell.score.text = "\(Data.servantScore)分"
                cell.serviceCount.text = "\(Data.serviceCount)次"
                if Data.servantStatus == "false"{
                    let grayColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
                    cell.StatusButton.backgroundColor = grayColor
                    cell.StatusButton.titleLabel?.text = "服务中"
                }
        
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    override func viewDidLayoutSubviews() {
        
        ServantLIstTV.frame = CGRectMake(0, 0,self.view.frame.width,self.view.frame.height-64)
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return ServantData.count;
        
    }
    
    //-------------------Table view delegate-----------------------------
    //cell响应事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
            //push跳转
            let svc = workerViewController()
            if let indexPath = self.ServantLIstTV.indexPathForSelectedRow(){
                svc.Servantdata = ServantData[indexPath.row]
                
            }
            self.navigationController!.pushViewController(svc,animated:true)
            //            self.performSegueWithIdentifier("toServantDetail", sender: self)
            
        
        
    }
    
    

    override func  viewWillAppear(animated: Bool) {
    
        ServantLIstTV.delegate = self
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        ServantLIstTV.delegate = nil
        
    }

}
