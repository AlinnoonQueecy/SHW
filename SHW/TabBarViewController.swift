//
//  TabViewController.swift
//  NewTestTabbar
//
//  Created by Zhang on 15/11/23.
//  Copyright © 2015年 Zhang. All rights reserved.
//

import UIKit

class TabBarViewController: HSTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewController()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupChildViewController() {
        
        
        let homeViewController: FindService = FindService()
     
        self.addTabBarItemWithViewController(homeViewController, title: "找服务", image: "home", selectedImage: "home_highlighted", isWapperedByNavigationController: true)
        
        let orderViewController: FinishVController = FinishVController()
        self.addTabBarItemWithViewController(orderViewController, title: "订单", image: "order", selectedImage: "order_highlighted", isWapperedByNavigationController: true)
        
       let discoverViewController: DiscoverTVC = DiscoverTVC()
        self.addTabBarItemWithViewController(discoverViewController, title: "发现", image: "discover", selectedImage: "discover_highlighted", isWapperedByNavigationController: true)
        
        let mineViewController: MineTVC = MineTVC()
        self.addTabBarItemWithViewController(mineViewController, title: "我的", image: "mine", selectedImage: "mine_highlighted", isWapperedByNavigationController: true)
        
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
