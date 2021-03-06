//
//  AppDelegate.swift
//  SHW
//
//  Created by star on 15/5/17.
//  Copyright (c) 2015年 star. All rights reserved.
//
import UIKit
import CoreData

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mapManager: BMKMapManager?

//    private func createMenuView() {
//        
//        // create viewController code...
//        var storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
//        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController")as!LeftViewController
//        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
//        
//        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
//        
//        leftViewController.mainViewController = nvc
//        
//        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
//        
        //self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
       // self.window?.rootViewController = MainVC
//        self.window?.makeKeyAndVisible ()
//    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        mapManager = BMKMapManager() // 初始化 BMKMapManager
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        //let ret = mapManager?.start("BwjB06RplQKOngwCwB5PfRA9", generalDelegate: nil)  // 注意此时 ret 为 Bool? 类型
        let ret = mapManager?.start("W64DZGMGe8SaBFisH3vuiwtc", generalDelegate: nil)  // 注意此时 ret 为 Bool? 类型
        
        if !ret! {  // 如果 ret 为 false，先在后面！强制拆包，再在前面！取反
            NSLog("manager start failed!") // 这里推荐使用 NSLog，当然你使用 println 也是可以的
        }
        //self.window?.addSubview(navigationController!.view) // 以下这两句如果不用 navigationController 的话完全可以不用要的
        //self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
////        [AlipaySDK.defaultService() processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
////            {
////            println("result = %@",resultDic)
////            }
////        ]
//        
//        AlipaySDK.defaultService().processAuthResult(url, standbyCallback: resultDic )
//    }
}

