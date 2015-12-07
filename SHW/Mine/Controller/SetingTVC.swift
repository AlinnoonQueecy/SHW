//
//  SetingTVC.swift
//  
//
//  Created by Zhang on 15/12/7.
//
//

import UIKit

class SetingTVC: UITableViewController {

    
    let baseArray:[String] = ["意见反馈","服务条款","检查更新","关于我们"]
    override func viewDidLoad() {
        super.viewDidLoad()
        println("vvvvvvvvvvvv")
       // self.tableView.registerClass:[FcailitatorCell class] forCellWithReuseIdentifier:@"FacilitatorCell"
        self.tableView.registerClass(FooterCell.self, forCellReuseIdentifier: "FooterCell")
        
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
        if section == 0{
            return baseArray.count

            
            
        }else if section == 1{
            return 1
            
        }
         return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         var cell = UITableViewCell()
         if indexPath.section == 0{
            let  cell = tableView.dequeueReusableCellWithIdentifier("FooterCell", forIndexPath: indexPath) as! FooterCell
            
            let imageName:[String]  = ["phone.png","phone.png","phone.png","phone.png"]
            var image  = UIImage(named:imageName[indexPath.row])
//            cell.Picture.image = image
//            cell.Label.text = baseArray[indexPath.row]
            cell.Label.text = "jjjj"
            return cell
        }else if indexPath.section == 1 {
            
            
            
        }
        return cell
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
