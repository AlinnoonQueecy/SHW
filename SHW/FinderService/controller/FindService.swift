//
//  FindService.swift
//  
//
//  Created by Zhang on 15/11/27.
//
//

import UIKit

class FindService: UIViewController , UITableViewDelegate,
UIScrollViewDelegate,UIAlertViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate {

    
    
    var imgLabel:UILabel!
    var urlSelected:String = ""
    var titleOfState:String = ""
    var AdvertiseDatas:[HomeAdvertise]=[]
    var range:NSArray = []
    var location:String = "当前城市"
    
    
    var customerid:String =  ""
    var loginPassword:String = ""
    
    //详细界面属性
    var scrollView = UIScrollView()
    var ButtonScroll: UIScrollView!
    var pageCtrl: UIPageControl!
    
    
    var detailView:UIView!
    var webView:UIWebView!
    var LocationB = UIButton()
    var _data:NSData?
    var imageUrlString:NSString?
    
    var img:UIImage?
    var termImg:UIImage?
    /// 定位服务
    var locationService: BMKLocationService!
    /// 当前用户位置
    var userLocation: BMKUserLocation!
    /// 地理位置编码
    var geocodeSearch: BMKGeoCodeSearch!
    //初始化
    var  FirstTypeData:[ServiceType] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hidesBottomBarWhenPushed = true
        self.title = "找服务"
        self.view.backgroundColor = UIColor.whiteColor()
        //初始化数据
        AdvertiseDatas = refreshAdvertise(1) as! [HomeAdvertise]
        FirstTypeData  = refreshParentType("") as! [ServiceType]
        //定位
        GetLocation()
        
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        
        //获取屏幕大小
        var screenBounds:CGRect = UIScreen.mainScreen().bounds
         //获取屏幕大小（不包括状态栏高度）
        var viewBounds:CGRect = UIScreen.mainScreen().applicationFrame
        
        
        let  leadheight = viewBounds.height*0.11
        
        var scrollviewheight = viewBounds.height*0.27
//      var pageCtrly = leadheight + scrollviewheight-viewBounds.height*0.03
        var pageCtrly = viewBounds.height*0.25

        var pageCtrlheight = 37
        var ButtonScrolly = pageCtrly + CGFloat(pageCtrlheight)-3
        var ButtonScrollheight = viewBounds.height*0.53
        var lastheight = viewBounds.height*0.09
        
        
        scrollView = UIScrollView(frame: CGRectMake(0, 0, viewBounds.width, viewBounds.height*0.27))
        
        scrollView.contentSize =  CGSize(width: viewBounds.width * CGFloat(AdvertiseDatas.count), height: viewBounds.height*0.27)
        scrollView.pagingEnabled = true  //设true时，会按页滑动
        scrollView.backgroundColor = UIColor.redColor()
        scrollView.bounces = false  //取消UIScrollView的弹性属性，这个可以按个人喜好来定
        scrollView.delegate = self //UIScrollView的delegate函数在本类中定义
        scrollView.showsHorizontalScrollIndicator = false//因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
        self.view.addSubview(scrollView)
         //2.设置图片滚动
        for var i = 0; i < AdvertiseDatas.count; i++ {
            var imgView:UIButton = UIButton(frame: CGRect(x: viewBounds.width*CGFloat(i), y:0, width: viewBounds.width, height: viewBounds.width*0.47) )
           // var imgView = UIButton()
            //网络地址获取图片
            //1.定义一个地址字符串常量
//            imageUrlString = HttpData.http+"/FamilyServiceSystem/upload/ad/\(AdvertiseDatas[i].id)/\(AdvertiseDatas[i].advertisePicture)"
            imageUrlString = HttpData.http+"/FamilyServiceSystem/\(AdvertiseDatas[i].advertisePicture)"
            println(imageUrlString)
           //2.通过String类型，转换NSUrl对象
            let url:NSString = imageUrlString!.URLEncodedString()
            var data = getImageData(url as String)
            if  data == nil{
                img = UIImage(named: HttpData.imgArray[i])
            }else{
                img = UIImage(data: data!)
            }
            imgView.setBackgroundImage(img, forState: UIControlState.Normal)
        
            scrollView.addSubview( imgView )
 
        }
        
        //4.创建UIPageControl，位置在屏幕最下方。
        pageCtrl = UIPageControl( frame: CGRectMake(viewBounds.width*0.25, pageCtrly, viewBounds.width*0.5, CGFloat(pageCtrlheight) ))
        pageCtrl.numberOfPages = AdvertiseDatas.count;//总的图片页数
        pageCtrl.currentPage = 0; //当前页
        pageCtrl.pageIndicatorTintColor = UIColor.grayColor()
        pageCtrl.currentPageIndicatorTintColor = UIColor.redColor()
        pageCtrl.addTarget(self, action:"pageTurn:" ,forControlEvents:UIControlEvents.ValueChanged) //用户点击UIPageControl的响应函数
        self.view.addSubview(pageCtrl)
        
//        //5.设置定时器（滑动切换图片）
//        var timer = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: "timerFireMethod:", userInfo: nil, repeats:true);
        
        
        
        //创建buttonScroll
        ButtonScroll  = UIScrollView( frame: CGRectMake(0, ButtonScrolly, viewBounds.width, viewBounds.height*0.53))
        let terms =  FirstTypeData.count
        let a = terms%3
        if a == 0 {
            ButtonScroll.contentSize = CGSizeMake(viewBounds.width, CGFloat(terms/3)*((ButtonScrollheight-4)/3+2))}
        else{
            ButtonScroll.contentSize = CGSizeMake(viewBounds.width, CGFloat(terms/3+1)*((ButtonScrollheight-4)/3+2))
        }
        
        ButtonScroll.pagingEnabled = false
        ButtonScroll.delegate = self
        ButtonScroll.showsHorizontalScrollIndicator = false
        ButtonScroll.showsVerticalScrollIndicator = false
        ButtonScroll.bounces = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(ButtonScroll)
        
        //创建button
        var button1C = UIColor  (red: 204/255, green: 255/255, blue: 0/255, alpha: 1.0)
        var button2C = UIColor(red: 1.0, green: 153/255, blue: 102/255, alpha: 1.0)
        var button3C = UIColor(red: 204/255, green: 204/255, blue: 255/255, alpha: 1.0)
        var button4C = UIColor(red: 1.0, green: 153/255, blue: 153/255, alpha: 1.0)
        var button5C = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0)
        var button6C = UIColor(red: 255/255, green: 153/255, blue: 204/255, alpha: 1.0)
        var button7C = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
        var button8C = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        var button9C = UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1.0)
        var color = [button1C,button2C,button3C,button4C,button5C,button6C,button7C,button8C,button9C]
        
        
        var width = (self.view.bounds.width-20)/3
        
        // mainatwo的button
        var i:Int = 0 ;
        for i = 0;i < terms;i++ {
            
            let term1 = UIButton(frame: CGRectMake(8+(width+2)*CGFloat(i%3),CGFloat(i/3)*((ButtonScrollheight-4)/3+2), width,width-20))
            //let term1 = UIButton(frame: CGRectMake(8+(width+2)*CGFloat(i%3),CGFloat(i/3)*((ButtonScrollheight-4)/3+2), width,(ButtonScrollheight-4)/3))
            term1.titleColorForState(UIControlState.Normal)
            term1.tag = i
            let buttonImageUS = HttpData.http+"/FamilyServiceSystem/\(FirstTypeData[i].typeLogo)"
            let url:NSString = buttonImageUS.URLEncodedString()
             let data = getImageData(url as String)
            if data == nil{
                termImg = UIImage(named: HttpData.imgArray[i%3])
                
            }else{
                termImg = UIImage(data: data!)
            }
            
            term1.setBackgroundImage(termImg, forState: UIControlState.Normal)
            //term1.backgroundColor = color[i%9]
            //term1.titleLabel?.font = UIFont.systemFontOfSize(16)
            term1.showsTouchWhenHighlighted = true
            term1.addTarget(self , action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
            ButtonScroll.addSubview(term1)
            
            
        }
        
        if a == 0 {
            ButtonScroll.contentSize = CGSizeMake(viewBounds.width, CGFloat(terms/3)*((ButtonScrollheight-4)/3+2))}
        else{
            ButtonScroll.contentSize = CGSizeMake(viewBounds.width, CGFloat(terms/3+1)*((ButtonScrollheight-4)/3+2))
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
    //6.定时器函数
//    func timerFireMethod(timer: NSTimer) {
//        
//        //令UIScrollView做出相应的滑动显示
//        self.pageCtrl.currentPage = (self.pageCtrl.currentPage+1)%AdvertiseDatas.count
//        var viewSize:CGSize  = scrollView.frame.size
//        var rect:CGRect = CGRect(x:CGFloat(self.pageCtrl.currentPage)*viewSize.width , y: 0, width: viewSize.width, height: viewSize.height)
//        scrollView.scrollRectToVisible(rect , animated:true);
//        //imgLabel.text = AdvertiseDatas[pageCtrl.currentPage].signName
//    }
//    //7.单击滚动图片事件
//    func clickImg( sender:UIButton) {
//        urlSelected = AdvertiseDatas[pageCtrl.currentPage].facilitatorID
//        self.performSegueWithIdentifier("AdvertTo", sender: self)
//        
//    }
    
     
    func ToLocation(){
         // self.performSegueWithIdentifier("toLocation", sender: self)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("LocationVC") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    

    // tapped函数，跳转
    func tapped(term1:UIButton){
        
        titleOfState = FirstTypeData[term1.tag].typeName
        
        var  serviceTypeData = refreshServiceType(titleOfState) as![ServiceType]
  
        if serviceTypeData != [] {
            
            self.performSegueWithIdentifier("toItem", sender: self)
            
            
         
        }else {
            let alert =  UIAlertView(title: "", message: "暂无数据，敬请期待!", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "toItem" {
            
            
            let controller = segue.destinationViewController as! BusinessVC
            
            var object = titleOfState
            controller.FirstType = object
            
        } else if segue.identifier! == "AdvertTo" {
            
            let controller = segue.destinationViewController as! BusinessDVC
            var object = urlSelected
            controller.facilitatorid = object
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
        if  (userDefaultes.stringForKey("location")) != nil && (userDefaultes.stringForKey("location")) != "" {
            location = userDefaultes.stringForKey("location")!
           
        }else{
            //ToLocation()
        }
        
    }
    //保存数据到NSUerDefaults
    func saveNSUerDefaults () {
        //将数据全部存储到NSUerDefaults中
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //存储时，除了NSNumber类型使用对应的类型外，其他的都使用setObject:forKey:
        userDefaults.setObject( location, forKey: "location")
        
        //建议同步到磁盘，但不是必须得
        userDefaults.synchronize()
    }

    
    
    func  GetLocation() {
        // 定位功能初始化
        locationService = BMKLocationService()
        // 设置定位精确度，默认：kCLLocationAccuracyBest
        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyBest)
    
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        BMKLocationService.setLocationDistanceFilter(10)
       
        locationService.startUserLocationService()
        // 地理编码器初始化
        geocodeSearch = BMKGeoCodeSearch()
        
        
    }
    
    // 1.在地图将要启动定位时，会调用此函数
    func willStartLocatingUser() {
             }
    // 2.用户位置更新后，会调用此函数
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        
        self.userLocation = userLocation
        println("目前位置：\(userLocation.location.coordinate.longitude), \(userLocation.location.coordinate.latitude)")
        var  Longtitude = userLocation.location.coordinate.longitude
        var  Latitude = userLocation.location.coordinate.latitude
        var point = CLLocationCoordinate2DMake(0, 0)
        
        point = CLLocationCoordinate2DMake(Latitude, Longtitude)
        
        var unGeocodeSearchOption = BMKReverseGeoCodeOption()
        unGeocodeSearchOption.reverseGeoPoint = point
        var flag = geocodeSearch.reverseGeoCode(unGeocodeSearchOption)
        if flag {
            println("反 geo 检索发送成功")
        }else {
            println("反 geo 检索发送失败")
        }
        
        locationService.stopUserLocationService()
        
    }
    // 用户方向更新后，会调用此函数
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        
    }
    
    // 在地图将要停止定位时，会调用此函数
    func didStopLocatingUser() {
        println("关闭定位")
        
    }
    
    // 定位失败的话，会调用此函数
    func didFailToLocateUserWithError(error: NSError!) {
        println("定位失败！")
        
    }
    
    
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        println("进入编码状态2")
        
        if error.value == 0 {
            
            var city = result.addressDetail.city
            //            println("city\(result.addressDetail.city)")
            //            var index = advance(city.endIndex, -1);
            //            let location = city.substringToIndex(index)
            
            location = city
           
            saveNSUerDefaults ()
            readNSUerDefaults()
            
            LocationB.setTitle(location, forState: UIControlState.Normal)
            //
            //                        let alert =  UIAlertView(title:location, message:city, delegate: self, cancelButtonTitle: "确定")
            //                        alert.show()
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        if location == "当前城市"{
            locationService.startUserLocationService()
        }
        locationService.delegate = self
        geocodeSearch.delegate = self
        
    }
    override func viewWillDisappear(animated: Bool) {
        
        locationService.delegate = nil
        
        geocodeSearch.delegate = nil
    }




}
