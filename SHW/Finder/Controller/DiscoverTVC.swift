//
//  FinderTVC.swift
//  
//
//  Created by Zhang on 15/11/29.
//
//

import UIKit

class DiscoverTVC: UITableViewController {
    
 
    //上拉加载更多
    var page = 1//下拉加载后的页数
    var allpage:Int?
    var loadMoreText = UILabel()
    //列表的底部，用于显示“上拉查看更多”的提示，当上拉后显示类容为“松开加载更多”。
    let tableFooterView = UIView()
    
    
    var FinderData:[facilitatorAdvertise]=[]
    var pageNo:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
      loadData()
      refresh()
    
    }
    func loadMoreData() {
            allpage  =  GetFinderPage(1)
        var data   = GetfacilitatorAdvertise(pageNo) as! [facilitatorAdvertise]
        FinderData += data
        
    }
    func loadData() {
        allpage  =  GetFinderPage(1)
        FinderData = GetfacilitatorAdvertise(pageNo) as! [facilitatorAdvertise]
        
    }
    //默认的下拉刷新模式
    func refresh(){
        
        self.tableView.headerView = XWRefreshNormalHeader(target: self, action: "upPullLoadData")
          self.tableView.headerView!.beginRefreshing()
          self.tableView.headerView!.endRefreshing()
          self.tableView.footerView = XWRefreshAutoNormalFooter(target: self, action: "downPlullLoadData")
    }
    //MARK: 下拉刷新数据
    func upPullLoadData(){
        page = 1
        loadData()
          self.tableView.reloadData()
          self.tableView.headerView?.endRefreshing()
          self.tableView.footerView?.endRefreshing()
        
        
    }
    //上拉加载
    func downPlullLoadData(){
        page++
        println("pagennn\(page)")
        if  page <= allpage {
            loadMoreData()
              self.tableView.reloadData()
              self.tableView.footerView?.endRefreshing()
            
        }else {
              self.tableView.footerView?.allRefreshing()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return FinderData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscoverCell", forIndexPath: indexPath) as! DiscoverCell
        let Data = FinderData[indexPath.row] as facilitatorAdvertise
        //1.定义一个地址字符串常量
        let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/\(Data.advertisePicture)"
        println(imageUrlString)
        cell.DiscoverImage.setZYHWebImage(imageUrlString, defaultImage: "122.jpg")

        return cell
    }

    //cell响应事件
  override  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if FinderData[indexPath.row].facilitatorID != "" {
            
            self.performSegueWithIdentifier("toDetail", sender: self)
            
        }else {
            //push跳转
            let svc = DiscoverDetailVC()
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                svc.Data = FinderData[indexPath.row]
                
            }
            self.navigationController!.pushViewController(svc,animated:true)
 
            
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier=="toDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                var  object = FinderData[indexPath.row].facilitatorID
                (segue.destinationViewController as! BusinessDVC).facilitatorid = object
                
            }
            
        } 
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
