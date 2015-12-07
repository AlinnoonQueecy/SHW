//
//  orderTableViewController.swift
//  order
//
//  Created by appl on 15/6/19.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class orderTableViewController: UITableViewController {

    @IBOutlet var orderTabel: UITableView!
    
    var customerInfo:[customer] = customerDate
    
    var collectionInfo:Collection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //orderTabel.dataSource = self
        //orderTabel.delegate = self
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return customerInfo.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0:
            return "客户信息";
        case 1:
            return "订单信息";
        default:
            return "";
        }
}

//    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        switch(section)
//        {
//        case 0:
//            return 10;
//        case 1:
//            return 20;
//        default:
//            return 1;
//        }
//    }
    
        
        
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell:orderTableViewCell = orderTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! orderTableViewCell
        
        let collectioncell : Collection = self.collectionInfo!
        let customercell = customerInfo[0] as customer
        //let collectioncell = collectionDate[0] as Collection
        
        switch(indexPath.section){
            
        case 0:
            println("1");
            cell.infor1.text = customercell.customerName
            cell.infor2.text = customercell.customerID
            cell.infor3.text = customercell.customerCity
            cell.infor4.text = customercell.contactAddress
            //cell.button.accessibilityElementsHidden = true
            //cell.button.enabled = false
            cell.button.hidden = true
            //cell.button.showsTouchWhenHighlighted = true
            break;
        case 1:
            println("2")
            cell.infor1.text = collectioncell.first
            cell.infor2.text = collectioncell.cost
            cell.infor3.text = collectioncell.cate
            cell.infor4.text = collectioncell.detail
            cell.button.showsTouchWhenHighlighted = true

            break;
        default:
            break;
            
        }

        // Configure the cell...
        
        return cell
    }
    
    //set Header Height
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    
    //set Cell Row Height
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130;
    }
    
    //cell  DidSelectAction
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

//     func tableView(tableView: UITableView) -> (UITableViewCell,UITableViewCell) {
//        let cell1 = tableView.dequeueReusableCellWithIdentifier("customercell") as! orderTableViewCell
//        
//        let cell2 = tableView.dequeueReusableCellWithIdentifier("collectioncell") as! dingdanTableViewCell
//        
//        let customercell = customerInfo[0] as customer
//        let collectioncell = collectionInfo[0] as Collection
//        
//        cell1.customerName.text = customercell.customerName
//            
//        cell2.cost.text = collectioncell.cost
//        
//
//        // Configure the cell...
//
//        return (cell1,cell2)
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimation.Top)
//        } else if editingStyle == UITableViewCellEditingStyle.Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
    

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

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    



}

