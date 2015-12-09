   //
   //  BusinessVC.swift
   //  SHW
   //
   //  Created by Zhang on 15/6/4.
   //  Copyright (c) 2015年 star. All rights reserved.
   //
   
   import UIKit
   import Alamofire
   
   class BusinessVC: UIViewController,UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDelegate,JSDropDownMenuDataSource, CDRTranslucentSideBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, OptionalItemCollectionViewCellDelegate, SideMenuBottomViewDelegate{
    
    
    
    var FirstType:String?//选择的大类
    //var SecondType:String?//会有的小类
    var status = true
    
    //声明右边按钮
    var rightButton =  UIBarButtonItem()
    //声明label
    //var label :UILabel?
    //声明地址
    var location:String = ""
    //声明一个去一口价的BUtton
    var writing = UIButton()
    //change by LZF
    var data12:[String] = []
    var data1:[String] = ["区域不限"]
    var data11:[String] = [""]
    var data21:[String] = []//存类型
    var data3 = []
    var data31 = []
    var currentData1Index : Int = 0
    var currentData2Index : Int = 0
    var currentData3Index : Int = 0
    var isPerson =  1 //声明点击店家还是人员
    var facilitatorCounty = ""//区域筛选
    var SecondType = ""//会有的小类
    var attributeName = "" //排序
    var upDown = "asc"
    //存储类型数据
    var serviceTypeData:[ServiceType]=[]
    var data2:[String] = []//存类型
    var Person:[String] = []
    //筛选和排序
    var column0 = 0
    var  row0   =  0
    var column1 = 1
    var  row1  = 0
    var column2 = 2
    var  row2  = 0
    var  n = 0
    var facilitatorCity = ""
    var condition = ""
    let color = UIColor(red: 234/255, green: 103/255, blue: 7/255, alpha: 1.0)
     //上拉加载更多
    var page = 1//下拉加载后的页数
    var allpage:Int?
    var loadMoreText = UILabel()
    //列表的底部，用于显示“上拉查看更多”的提示，当上拉后显示类容为“松开加载更多”。
    let tableFooterView = UIView()
    
    // 筛选相关
    let rightSideBar = CDRTranslucentSideBar.init(direction: true)
    let backgroundButton = UIButton()
    let optionalItemCollectionView = OptionalItemCollectionView()
    let contentView = UIView()
    let sideMenuBottomView = SideMenuBottomView()
    var conditions = NSArray()
    
    var selectedOperationArray = NSMutableArray()

    
    @IBOutlet weak var businessTable: UITableView!
    //声明一个数组businesss来保存获取的信息
    var ServantData:[ServantInfo] = []
    var selectbusiness:[facilitatorInfo] = []
  
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var width = self.view.frame.width
        var height = self.view.frame.height
        businessTable.dataSource = self
        businessTable.delegate = self
        //读取本地存储的地址
        readNSUerDefaults()
       
        //类型
        serviceTypeData = refreshServiceType(FirstType!) as![ServiceType]
        for var i = 0;i < serviceTypeData.count;i++ {
            data2 += [serviceTypeData[i].typeName] // 小类名称
            Person +=  [serviceTypeData[i].isPerson]
        }
        SecondType  = data2[row1]
        //区域
        data12 = queryCounty(location) as! [String]
        data1 += data12
        data11 += data12
 
         if  Person[0] == "1" {
            isPerson = 1
          }else{
            isPerson = 0
            
             
        }
        facilitatorCity = location
        loadData()
   
 
        var menu = JSDropDownMenu(origin: CGPoint(x: 0.0,y: 0.0), andHeight: 36)
        menu.indicatorColor = UIColor(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 1.0)
        menu.separatorColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        menu.textColor = UIColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        menu.dataSource = self;
        menu.delegate = self
        label.removeFromSuperview()
        self.view.addSubview(menu)
       

        writing = UIButton(frame: CGRect(x: width-100, y: height-200, width: 100, height:50))
        var background  = UIImage(named: "u4")
        writing.setBackgroundImage(background, forState: UIControlState.Normal)
        writing.setTitle("去一口价", forState: UIControlState.Normal)
        writing.titleLabel?.font = UIFont.systemFontOfSize(16)
        //设置按钮中Title的位置
        writing.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        writing.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);
        writing.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        writing.showsTouchWhenHighlighted = true
        writing.addTarget(self , action: Selector("package"), forControlEvents: UIControlEvents.TouchUpInside)
        
        refresh()
        
        self.view.addSubview(writing)
        
  
        
        
        
        // 创建Right SideBar
        self.setupRightSideBar()
        
        // 创建选择contentView
        self.setupContentView()
        
        // 添加手势
        self.setupPanGesture()


    }
    //加载更多数据
    func loadMoreData() {
        
        if isPerson == 1 {
            var data = refreshServant(SecondType,attributeName,upDown,facilitatorCity,facilitatorCounty,page,condition) as! [ServantInfo]
            ServantData += data
            data3 = ["默认排序","人员星级"]
            data31 = ["","servantScore"]
            writing.enabled = false
            writing.hidden = true
        
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "筛选", style: UIBarButtonItemStyle.Plain, target: self, action: "showSideBar")
           
            //self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
            allpage = GetSPage(SecondType,attributeName,upDown,facilitatorCity,facilitatorCounty,page,condition)
        }else if isPerson == 0 {
            var data = refreshFacilitator(SecondType,attributeName,upDown,facilitatorCity,facilitatorCounty,page,condition) as! [facilitatorInfo]
            selectbusiness += data
            data3 = ["默认排序","点击次数由高到低","信用评分由高到低"]
            data31 = ["","clientClick","creditScore"]
            writing.enabled = true
            writing.hidden = false
    
            self.navigationItem.rightBarButtonItem = nil
            allpage = GetFPage(SecondType,attributeName,upDown,facilitatorCity,facilitatorCounty,page,condition)
        }
        self.businessTable.reloadData()
        
    }
    //刷新、重载
    func loadData() {
        
        if isPerson == 1 {
            var data = refreshServant(SecondType,attributeName,upDown,facilitatorCity,facilitatorCounty,page,condition) as! [ServantInfo]

            ServantData = data
            data3 = ["默认排序","人员星级"]
            data31 = ["","servantScore"]
            writing.enabled = false
            writing.hidden = true
              self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "筛选", style: UIBarButtonItemStyle.Plain, target: self, action: "showSideBar")
             allpage = GetSPage(SecondType,attributeName,upDown,facilitatorCity,facilitatorCounty,page,condition)
        }else if isPerson == 0 {
            var data = refreshFacilitator(SecondType,attributeName,upDown,facilitatorCity,facilitatorCounty,page,condition) as! [facilitatorInfo]

            selectbusiness = data
            data3 = ["默认排序","点击次数由高到低","信用评分由高到低"]
            data31 = ["","clientClick","creditScore"]
            writing.enabled = true
            writing.hidden = false
            self.navigationItem.rightBarButtonItem = nil
            allpage = GetSPage(SecondType,attributeName,upDown,facilitatorCity,facilitatorCounty,page,condition)
        }
        self.businessTable.reloadData()
        
    }
    

    // 重置数组
    func resetSelectedArray(){
        for var i = 0; i < self.conditions.count; ++i{
            self.selectedOperationArray.replaceObjectAtIndex(i, withObject:"")
        }
        
    }
    
    // MARK: - 创建自定义VIew
    func setupRightSideBar(){
        self.rightSideBar.delegate = self
        self.rightSideBar.sideBarWidth = UIScreen.mainScreen().bounds.size.width * 0.8
        self.rightSideBar.translucentStyle = UIBarStyle.Default
    }
    
    func setupContentView(){
        self.contentView.frame =  CGRectMake(0, 0, self.rightSideBar.sideBarWidth, UIScreen.mainScreen().bounds.size.height)
        self.contentView.backgroundColor = UIColor.whiteColor()
        // 创建collectionView
        self.setupCollectionView()
        // 创建SiderBar的底部按钮
        self.setupSideMenuBottomView()
        
        self.rightSideBar.setContentViewInSideBar(self.contentView)
        
    }
    func setupCollectionView(){
        self.optionalItemCollectionView.frame = CGRectMake(0, 0, self.rightSideBar.sideBarWidth, UIScreen.mainScreen().bounds.size.height - 49)
        self.optionalItemCollectionView.delegate = self
        self.optionalItemCollectionView.dataSource = self
        self.optionalItemCollectionView.registerClass(OptionalItemCollectionViewCell.self, forCellWithReuseIdentifier: "OptionalCell")
        self.optionalItemCollectionView.registerNib(TitleCollectionViewHeaderCellCollectionViewCell.nib(), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier:"UICollectionElementKindSectionHeader")
        
        
        self.contentView.addSubview(self.optionalItemCollectionView)
    }
    
    func setupSideMenuBottomView(){
        self.sideMenuBottomView.delegate = self
        self.sideMenuBottomView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 49, self.rightSideBar.sideBarWidth, 49)
        self.contentView.addSubview(self.sideMenuBottomView)
    }

    
    /**
    显示侧栏
    */
    func showSideBar(){
        self.backgroundButton.frame = self.view.bounds
        self.backgroundButton.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(self.backgroundButton)
        self.rightSideBar.show()
        // 加载数据
        self.loadConditions()
    }
    
    func collectionButtonItemClicked(sender:UIButton){
        sender.selected = !sender.selected
    }
    
    // MARK: - 手势
    func setupPanGesture(){
        let panGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: "handlePanGesture:")
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    /**
    手势触发
    */
    func handlePanGesture(recognizer:UIPanGestureRecognizer){
        if recognizer.state == UIGestureRecognizerState.Began{
            self.rightSideBar.isCurrentPanGestureTarget = true
        }
        self.rightSideBar.handlePanGestureToShow(recognizer, inView: self.view)
        self.backgroundButton.frame = self.view.bounds
        self.backgroundButton.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(self.backgroundButton)
        // 加载数据
        self.loadConditions()
    }
    
    // MARK: - 加载数据
    func loadConditions(){
        // 告诉系统将operations字典数组转为模型数组
        Condition.mj_setupObjectClassInArray { () -> [NSObject : AnyObject]! in
            return ["operations" : "Operation"]
        }
        
        let parameters = [
            "typeName" : SecondType,
            
        ]
        
        Alamofire.request(.POST, "http://219.216.65.182:8080/FamilyServiceSystem/MobileServiceTypeAction?operation=_queryByName", parameters: parameters, encoding: .JSON, headers: nil)
            .responseJSON(options: NSJSONReadingOptions.AllowFragments) { (request, response, data, error) -> Void in
                let JSON: AnyObject? = data
                self.conditions = Condition.mj_objectArrayWithKeyValuesArray(JSON!["fiterCondition"] as! [AnyObject])
                // 初始化选中选项数组
                self.selectedOperationArray.removeAllObjects()
                for var i = 0; i < self.conditions.count; ++i{
                    self.selectedOperationArray.addObject("")
                }
                self.optionalItemCollectionView.reloadData()
            }
//            .responseJSON { response in
//                let JSON = response
//                self.conditions = Condition.mj_objectArrayWithKeyValuesArray(JSON!["fiterCondition"] as! [AnyObject])
//                // 初始化选中选项数组
//                self.selectedOperationArray.removeAllObjects()
//                for var i = 0; i < self.conditions.count; ++i{
//                    self.selectedOperationArray.addObject("")
//                }
//                self.optionalItemCollectionView.reloadData()
//        }
    }
    
    // MARK: - DataSource
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.conditions.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let condition = self.conditions[section] as! Condition
        return condition.operations.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCellWithReuseIdentifier("OptionalCell", forIndexPath: indexPath) as! OptionalItemCollectionViewCell
        cell.delegate = self
        let condition = self.conditions[indexPath.section] as! Condition
        let operation = condition.operations[indexPath.item] as! Operation
        operation.section = indexPath.section
        operation.item = indexPath.item
        cell.cellBtn.setTitle(operation.name, forState: UIControlState.Normal)
        cell.cellBtn.userInteractionEnabled = false
        cell.cellBtn.selected = operation.selected
        return cell
    }
    // MARK: - 代理方法
    // MARK:CDRTranslucentSideBarDelegate
    func sideBar(sideBar: CDRTranslucentSideBar!, didDisappear animated: Bool) {
        self.backgroundButton.removeFromSuperview()
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let condition = self.conditions[indexPath.section] as! Condition
        let operation = condition.operations[indexPath.item] as! Operation
        
        let operationArray = condition.operations
        var selectedOperation = Operation()
        for var i = 0; i < operationArray.count; ++i{
            let tempOperation = operationArray[i] as! Operation
            if tempOperation.selected{
                selectedOperation = tempOperation
                continue
            }else{
                selectedOperation.section = -1
                selectedOperation.item = -1
            }
        }
        
        if selectedOperation.section == operation.section && selectedOperation.item == operation.item{
            operation.selected = !operation.selected
            self.selectedOperationArray.replaceObjectAtIndex(indexPath.section, withObject: "")
        }else{
            selectedOperation.selected = !selectedOperation.selected
            operation.selected = !operation.selected
            for var i = 0; i < operationArray.count; ++i{
                let tempOperation = operationArray[i] as! Operation
                if tempOperation.selected{
                    self.selectedOperationArray.replaceObjectAtIndex(indexPath.section, withObject: tempOperation.name)
                }
            }
        }
        self.optionalItemCollectionView.reloadData()
     
    }
    
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width * 0.8, 40)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "UICollectionElementKindSectionHeader", forIndexPath: indexPath) as! TitleCollectionViewHeaderCellCollectionViewCell
        let condition = self.conditions[indexPath.section] as! Condition
        cell.sectionTitleLabel!.text = condition.name
        return cell
    }
    
    // MARK: SideMenuBottomViewDelegate
    func resetButtonDidClicked() {
        for var i = 0; i < self.conditions.count; ++i{
            let condition = self.conditions[i] as! Condition
            let operationArray = condition.operations as NSArray
            for var j = 0; j < operationArray.count; ++j{
                let operation = operationArray[j] as! Operation
                operation.selected = false
            }
        }
        // 重置数组
        self.resetSelectedArray()
        // 重载数据
        self.optionalItemCollectionView.reloadData()
    }
    
    func confirmButtonDidClicked() {
        self.rightSideBar.dismissAnimated(true)
        print("选中的选项数组----\(self.selectedOperationArray[0])")
             print("选中的选项数组----\(self.selectedOperationArray[1])")
        print("选中的选项数组----\(self.selectedOperationArray[2])")
        print("选中的选项数组----\(self.selectedOperationArray[3])")
    }


    
    //默认的下拉刷新模式
    func refresh(){
        
       businessTable.headerView = XWRefreshNormalHeader(target: self, action: "upPullLoadData")
       businessTable.headerView!.beginRefreshing()
       businessTable.headerView!.endRefreshing()
       businessTable.footerView = XWRefreshAutoNormalFooter(target: self, action: "downPlullLoadData")
     }
    //MARK: 下拉刷新数据
    func upPullLoadData(){
            page = 1
            loadData()
            businessTable.reloadData()
            businessTable.headerView?.endRefreshing()
            businessTable.footerView?.endRefreshing()

     
    }
    //上拉加载
    func downPlullLoadData(){
        page++
        println("pagennn\(page)")
        if  page <= allpage {
            loadMoreData()
            businessTable.reloadData()
            businessTable.footerView?.endRefreshing()

        }else {
             businessTable.footerView?.allRefreshing()
        }
        
    }

    
 
    
    
    
    
    override func viewDidLayoutSubviews() {
        var width = self.view.frame.width
        businessTable.frame =  CGRectMake(0, 36, width, self.view.frame.height-36)
    }
    
    
    //-------------------Table view data source-----------------------------
    // 根据indexPath(section,row)创建每行cell及其内容
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
          //创建cell
        var cell = UITableViewCell()
        
        
        if isPerson == 0 {
            
           let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
            
            let business = selectbusiness[indexPath.row] as facilitatorInfo
            cell.name.text = business.facilitatorName//名称
            cell.address.text = "\(business.creditScore)分 " //信用评分
          
            //网络地址获取图片
            //1.定义一个地址字符串常量
            let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/\(business.facilitatorLogo)"
            
            cell.picture.setZYHWebImage(imageUrlString, defaultImage: "reserve2.jpg")
            cell.officePhone.text =   business.contactAddress//地址
            cell.dizhi.text = "信用评分:"
            cell.dianhua.text =  "联系地址:"
            return cell
            
          }else if isPerson == 1 {
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ServantCell", forIndexPath: indexPath) as! ServantCell

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
        
        return cell
    }
    
    
    
    func package(){
 
        

//       self.performSegueWithIdentifier("toPackage", sender: self)
        
       self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    // Return the number of sections.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;//HttpData.channelTitles.count
    }
    
    // Return the number of rows in the section.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var  count = 0
        if isPerson == 0 {
            //返回商家数量作为表格的行数
            count = selectbusiness.count;
            
        }else if isPerson == 1 {
            //返回人员数量作为表格的行数
            count =   ServantData.count;
            
        }
        return count
        
    }
    
    
    
    
    
    //-------------------Table view delegate-----------------------------
    //cell响应事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isPerson == 0 {
            
           self.performSegueWithIdentifier("toBDetail", sender: self)
 
            
        
        

            
        }else if isPerson == 1 {
            //push跳转
            let svc = workerViewController()
            if let indexPath = self.businessTable.indexPathForSelectedRow(){
              svc.Servantdata = ServantData[indexPath.row]
                
            }
            self.navigationController!.pushViewController(svc,animated:true)
//            self.performSegueWithIdentifier("toServantDetail", sender: self)
            
        }
        
        
    }
    
 

    
//顶部下拉选择控件
//列数
func numberOfColumnsInMenu(menu: JSDropDownMenu!) -> Int
    {
        return 3
    }
    
func displayByCollectionViewInColumn(column: Int) -> Bool
    {
        return false;
    }
    
func haveRightTableViewInColumn(column: Int) -> Bool
    {
        return false;
    }
    
func widthRatioOfLeftColumn(column: Int) -> CGFloat
    {
        return 1;
    }
//当前选择
func currentLeftSelectedRow(column: Int) -> Int
    {
        if (column==0) {
            
            return currentData1Index;
            
        }
        if (column==1) {
            
            return currentData2Index;
        }
        
        return 0;
    }
//具体显示条数
func menu(menu: JSDropDownMenu!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
        
        if (column==0) {
            return data1.count;
        } else if (column==1){
            
            return data2.count;
            
        } else if (column==2){
            
            return data3.count;
        }
        
        return 0;
    }
//初始显示
    func menu(menu: JSDropDownMenu!, titleForColumn column: Int) -> String! {
        
        switch (column) {
        case 0:
            return data1[0] as String
        case 1:
            return data2[0] as String
        case 2:
            return data3[0] as! String
        default:
            return nil
        }
    }
//具体显示内容
    func menu(menu: JSDropDownMenu!, titleForRowAtIndexPath indexPath: JSIndexPath!) -> String! {
        
        if (indexPath.column==0) {
            return data1[indexPath.row] as String
        } else if (indexPath.column==1) {
            
            return data2[indexPath.row] as String
            
        } else {
            
            return data3[indexPath.row] as! String
        }
    }
//点击触发
    func menu(menu: JSDropDownMenu!, didSelectRowAtIndexPath indexPath: JSIndexPath!) {
        if (indexPath.column == 0) {
            currentData1Index = indexPath.row
            column0 = 0
            row0   =  indexPath.row
        } else if(indexPath.column == 1){
            currentData2Index = indexPath.row;
            row1   =  indexPath.row
            if  serviceTypeData[row1].isPerson == "1"{
                data3 = ["默认排序","人员星级"]
                data31 = ["","servantScore"]
                rightButton.title = ""
                writing.enabled = false
                writing.hidden = true
                //self.navigationItem.rightBarButtonItem = rightButton
            }else{
                data3 = ["默认排序","点击次数由高到低","信用评分由高到低"]
                data31 = ["","clientClick","creditScore"]
                writing.enabled = true
                writing.hidden = false
                 // self.navigationItem.rightBarButtonItem = rightButton
               // self.navigationItem.rightBarButtonItem = nil
            }
        } else{
            currentData3Index = indexPath.row;
            row2   =  indexPath.row
        }
        
        facilitatorCounty = data11[row0] as String
        SecondType  = data2[row1]
        attributeName = data31[row2] as! String
        
        if  Person[row1]  == "1"{
            isPerson =  1
            page = 1
          
        }else {
            isPerson =  0
            page = 1
           
        }
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        
        if  (userDefaultes.stringForKey("location")) != nil{
            location = userDefaultes.stringForKey("location")!
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier=="toBDetail"{
            if let indexPath = self.businessTable.indexPathForSelectedRow(){
                var  object = selectbusiness[indexPath.row].facilitatorID
                (segue.destinationViewController as! BusinessDVC).facilitatorid = object
                
            }
        
        }else if segue.identifier=="toPackage"{
            var  object = FirstType
           
            (segue.destinationViewController as! PackageVC).FirstType = object
            
        }
    }
    
   }
