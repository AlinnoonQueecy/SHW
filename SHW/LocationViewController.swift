//
//  LocationViewController.swift
//  SZFU
//
//  Created by wufei on 15/7/25.
//  Copyright (c) 2015年 wufei. All rights reserved.
//

import UIKit
import CoreLocation




protocol selectCityDelegate:NSObjectProtocol{
    
    func selectCity(controller:LocationViewController,cityModel:CityModel)
    
}

class LocationViewController: UIViewController,UITableViewDelegate, UITableViewDataSource ,UISearchBarDelegate,UISearchControllerDelegate ,CLLocationManagerDelegate {
    
    //声明导航条
    var navigationBar : UINavigationBar?
    var  isCovered :String!
    var sectionArray:NSArray!
    var cityArray:NSArray!
    var locationManager : CLLocationManager = CLLocationManager()
    var currentCity:CityModel!
    var selectedCity:CityModel = CityModel()
    var tableView:UITableView?
    var resultArray:NSMutableArray?
      var delegate:selectCityDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var width = self.view.frame.width
        var height = self.view.frame.height

//        //实例化导航条
//        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, 64))
//        self.view.addSubview(navigationBar!)
//        println("创建导航条详情")
//        onMakeNavitem()

        self.title = "城市选择"
        
 
        
        sectionArray = NSArray()
        cityArray = NSArray()
        resultArray = NSMutableArray()
        
        tableView = UITableView(frame: CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Plain)
        //tableView!.separatorStyle =  UITableViewCellSeparatorStyle.None
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        
 
        //单个城市数组
        sectionArray = CityHandle().shareIndexList()
        //分组后的城市数组
        cityArray = CityHandle().shareSectionCityList()
        self.getUserLocation()
      

        
    }

    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
    
        return sectionArray!.count + 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        }
        else
        {
            return cityArray!.objectAtIndex(section - 1).count
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
         let cellIdentifier: String = "locationCellIdentifier"
        
         if indexPath.section == 0  {
            var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
            let currentLB = UILabel(frame: CGRectMake(20, 0, 80, cell.bounds.size.height))
            currentLB.backgroundColor = UIColor.clearColor()
            currentLB.font = UIFont.systemFontOfSize(14)
            currentLB.text = "当前城市:"
            cell.contentView.addSubview(currentLB)
            let cityLB = UILabel(frame: CGRectMake(80, 0, 200, cell.bounds.size.height))
            cityLB.backgroundColor = UIColor.clearColor()
            cityLB.textColor = UIColor.orangeColor()
            cityLB.font = UIFont.systemFontOfSize(16)
            if currentCity != nil {
                cityLB.text = currentCity!.cityName as? String
              }
             else {
               cityLB.text = "正在定位中..."
            }
            cell.contentView.addSubview(cityLB)
            return cell

        }
        else
        {
           
            var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            }
    
            let model:CityModel = cityArray!.objectAtIndex(indexPath.section - 1).objectAtIndex(indexPath.row) as! CityModel

            cell!.textLabel!.text = model.cityName as? String
     
            return cell!
        }
    }
    
    
     func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]!
     {
       // return CityHandle().shareIndexList() as [AnyObject]
        return sectionArray! as [AnyObject]
        
        }
    
   
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
    
        //return CityHandle().shareIndexList().objectAtIndex(section) as? String
        if section == 0
        {
            return nil
            
            }
        else
        {
            return sectionArray!.objectAtIndex(section - 1) as? String
            }
    
        }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       
        if indexPath.section == 0 {
        
           selectedCity = currentCity
           println("selectedCity1:\(selectedCity)")
 
            println("跳转1")

        }
        else
        {
           selectedCity = cityArray!.objectAtIndex(indexPath.section - 1).objectAtIndex(indexPath.row) as! CityModel
 
        }
        
        
        if((delegate) != nil){
            delegate?.selectCity(self,cityModel:selectedCity)
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        isCovered = CityHandle().QueryCovered(selectedCity.cityName as  String)
        
        println("isCovered\(isCovered)")
        if  (isCovered == "true") {
            
            
         saveNSUerDefaults()
         self.performSegueWithIdentifier("toLocation", sender: self)
          println("跳转3")
        }else {
            
            let alert =  UIAlertView(title: "暂未开通!", message: "", delegate: self, cancelButtonTitle: "确定")
            alert.show()

        }
    }
    
    
//pragma mark - 定位
    func getUserLocation() {
        if CLLocationManager.locationServicesEnabled() == true {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters //控制定位精度
            locationManager.distanceFilter = 100 //控制定位服务更新频率。单位是“米”
//            locationManager!.startUpdatingLocation()
            //在ios 8.0下要授权
            locationManager.distanceFilter = kCLLocationAccuracyKilometer
            if self.locationManager.respondsToSelector("requestAlwaysAuthorization"){
                locationManager.requestAlwaysAuthorization()
                println("requestAlwaysAuthorization")
                
                
            }
            locationManager.startUpdatingLocation()
            println("定位开始1111")

        }
    }
    
    
    
    
    func  locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        println("定位进行中1")
        //获取最新坐标
        var currentLocation:CLLocation  = locations[locations.count-1]  as! CLLocation
        var geocoder = CLGeocoder()
        var p:CLPlacemark?
        geocoder.reverseGeocodeLocation(currentLocation , completionHandler: {
            (placemarks, error) in
            if error != nil {
                println("reverse geodcode fail: \(error.localizedDescription)")
                return
            }
            let pm = placemarks as! [CLPlacemark]
            if (pm.count > 0){
                p = placemarks[0] as? CLPlacemark
                let cityName: NSString = p!.locality
                self.getCurrentCityInfoWithCityName(cityName)
                self.locationManager.stopUpdatingLocation()
 
            }else{
                println("No Placemarks!")
            }
            
        })

        
     }
    
    func getCurrentCityInfoWithCityName(cityName:NSString ) {
        println("cityname:\(cityName)")
    
        let cityList = NSArray(array: CityHandle().shareCityList())
        for var i = 0 ; i < cityList.count; i++  {
            let model:CityModel = cityList.objectAtIndex(i) as! CityModel
            if ((cityName as String).rangeOfString((model.cityName as? String)!) != nil)  {
                    currentCity = model
                println("currentCity:\(currentCity.cityName)")
                    break
            }else {
                println("没有得到")
            }
        }
        
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        tableView!.beginUpdates()
        tableView!.reloadRowsAtIndexPaths([indexPath] as AnyObject as! [AnyObject], withRowAnimation:UITableViewRowAnimation.Automatic)
        tableView!.endUpdates()
        
     
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
        navigationItem.title = "当前城市"
        //设置导航栏左边按钮
        navigationItem.setLeftBarButtonItem(leftButton, animated: true)
        
        navigationBar?.pushNavigationItem(navigationItem, animated: true)
        
        
        return navigationItem
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //保存数据到NSUerDefaults
    func saveNSUerDefaults () {
        //将数据全部存储到NSUerDefaults中
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
        userDefaults.setObject( selectedCity.cityName, forKey: "location")
        println("存储")
        //建议同步到磁盘，但不是必须得
        userDefaults.synchronize()
    }
    

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == "toLocation"{
//            
//            let controller = segue.destinationViewController as! MainVC
//            var object = selectedCity.cityName
//            controller.location = object  as String
//        }
//        
//    }

 

}
