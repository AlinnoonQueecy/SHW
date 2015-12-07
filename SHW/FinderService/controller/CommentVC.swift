//
//  CommentVC.swift
//  SHW
//
//  Created by Zhang on 15/8/6.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class CommentVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate{
    
    //声明导航条
    var navigationBar : UINavigationBar?
    
    @IBOutlet weak var CommentTable: UITableView!
    
    //存储评论
    var commentdata:[CommentInfo] = []
    var  serverResponse:String!
    //上个界面传递的数据
    var servantID:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var width = self.view.frame.width
//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情Comment")
//        onMakeNavitem()
        
       serverResponse = getResponse(servantID) as String
        println(serverResponse)
        
        if serverResponse == "Success" {
            
            commentdata =  getSconmmentData(servantID) as! [CommentInfo]
           println(commentdata)
            
        }else {
            let alert =  UIAlertView(title: "", message: "该人员还没有评论!", delegate: self, cancelButtonTitle: "确定")
            alert.show()

        }
        CommentTable.dataSource = self
        CommentTable.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        var width = self.view.frame.width
        
        CommentTable.frame =  CGRectMake(0,74, width, self.view.frame.height)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return commentdata.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("1")
        //let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTCell
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell",forIndexPath: indexPath) as! CommentTCell
        
        let Commentcell = commentdata[indexPath.row] as CommentInfo
        cell.customer.text = Commentcell.customerID
        cell.comment.text = Commentcell.commentType
        cell.time.text = Commentcell.commentDate
        return cell
    }
    
    func  alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
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
        navigationItem.title = "评论列表"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
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
