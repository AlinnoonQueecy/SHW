//
//  MineTVC.swift
//
//
//  Created by Zhang on 15/12/5.
//
//

import UIKit

class MineTVC: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    let baseArray:[String] = ["基本资料","修改密码","修改头像"]
    let dataArray:[String] = ["我的收藏"]
    //读取本地数据
    var  customerid:String  = ""
    var loginPassword:String = ""
    //存储查询的用户信息
    var  MineData:MyInfo!
    var imagePicker:UIImagePickerController!
    var av:UIActivityIndicatorView!
    let headerPicture = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取用户信息，如果不是第一次登录，则会自动登录
        readNSUerDefaults()
        if customerid != "" && loginPassword != ""{
            MineData = QueryInfo(customerid) as MyInfo
            
        }
        let width = self.view.frame.width
        let height = self.view.frame.height
        //        self.tableView.frame = CGRectMake(0,0, width, height)
        self.tableView.scrollEnabled = false
        
        
 
        let rightButton =  UIBarButtonItem(title: "设置", style: UIBarButtonItemStyle.Plain, target: self, action: "seting")
   
        self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
        

        
        
    }
    
    func  seting(){
     
        
          self.performSegueWithIdentifier("toSeting", sender: self)
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewControllerWithIdentifier("SetingVC") as! SetingVC
//        
//        self.navigationController!.pushViewController(vc, animated:true)

        
    }
      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    //section Number
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }
    //cell Number
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
            
            
        }else if section == 1{
            return baseArray.count
            
        }else if section == 2{
            return  dataArray.count
            
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            let  cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! HeaderCell
            
            
            if customerid != "" && loginPassword != ""{
                MineData = QueryInfo(customerid) as MyInfo

                //1.定义一个地址字符串常量
                let imageUrlString:String = HttpData.http+"/FamilyServiceSystem/upload/customer/\(MineData.id)/\(MineData.headPicture)"
                headerPicture.setZYHWebImage(imageUrlString, defaultImage: "touxiang.jpg")
                cell.Picture.image = headerPicture.image
                cell.CustomerName.text = MineData.customerName
                cell.Phone.text = MineData.mobilePhone
                //cell不可被点击
                cell.userInteractionEnabled = false
                
            }else {
                cell.userInteractionEnabled = true
                cell.CustomerName.text = "登录/注册"
                cell.Phone.text =  "登录后可享受更多特权"
                cell.Picture.image = UIImage(named: "touxiang.jpg")
            }
            //圆角
            cell.Picture.layer.cornerRadius = 50
            cell.Picture.layer.masksToBounds = true
            let color = UIColor  (red: 234/255, green: 103/255, blue: 7/255, alpha: 1.0)
            cell.backgroundColor = color
            return cell
            
            
        }else if indexPath.section == 1{
            let  cell = tableView.dequeueReusableCellWithIdentifier("FooterCell", forIndexPath: indexPath) as! FooterCell
            
            let imageName:[String]  = ["phone.png","tel.png","location.png"]
            var image  = UIImage(named:imageName[indexPath.row])
            cell.Picture.image = image
            cell.Label.text = baseArray[indexPath.row]
            return cell
        }else if indexPath.section == 2{
            let  cell = tableView.dequeueReusableCellWithIdentifier("FooterCell", forIndexPath: indexPath) as! FooterCell
            
            let imageName:[String]  = ["phone.png"]
            var image  = UIImage(named:imageName[indexPath.row])
            cell.Picture.image = image
            cell.Label.text = dataArray[indexPath.row]
            
            return cell
        }
        
        
        
        
        return cell
    }
    //cehiscehishisihfeiodvhfed
    
    //set Cell Row Height
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var  h = 50
        if indexPath.section == 0{
            h =  140;
        }else {
            h = 50
        }
        return CGFloat(h)
    }
    //set Footer Height
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    //set Header Height
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000000000000000000000001
    }
    
    //cell  DidSelectAction
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            
            
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
            
            self.navigationController!.pushViewController(vc, animated:true)

            
            
            
            
        }else if indexPath.section == 1{
            
            if customerid != "" && loginPassword != ""{
                
                var x = indexPath.row
                switch(x){
                case 0:
                    let vc = BaseInfoVC()
                    self.navigationController!.pushViewController(vc, animated:true)
                    
                    break
                case 1:
                    
                    let vc = ChangePasswordVC()
                    vc.Password = MineData.loginPassword
                    vc.id = MineData.id
                    self.navigationController!.pushViewController(vc, animated:true)
                    
                    break
                    
                default:
                    
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.title = "相册"
                    imagePicker.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
                    //指定使用照相机模式,可以指定使用相册／照片库
                    //imagePicker.sourceType=UIImagePickerControllerSourceType.Camera
                    imagePicker.modalTransitionStyle=UIModalTransitionStyle.CoverVertical
                    //设置当拍照完或在相册选完照片后，是否跳到编辑模式进行图片剪裁。只有当showsCameraControls属性为true时才有效果
                    imagePicker.allowsEditing=true
                    //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
                    //                    imagePicker.showsCameraControls  = true;
                    //                    //设置使用后置摄像头，可以使用前置摄像头
                    //                    imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
                    //self.navigationController?.pushViewController(imagePicker, animated: true)
                    self.presentViewController(imagePicker, animated:true, completion: nil)
                    
                    break
                }
                
                
                
            }else{
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
                
                self.navigationController!.pushViewController(vc, animated:true)

                
            }
            
            
        }else if indexPath.section == 2{
              if customerid != "" && loginPassword != ""{
                
               self.performSegueWithIdentifier("toCollect", sender: self)
            
              }else{
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
                
                self.navigationController!.pushViewController(vc, animated:true)


            }
        
        }
        
    }
    
    //上传图片
    func imagePickerController(picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject :AnyObject])
    {
        self.dismissViewControllerAnimated(true, completion:nil);
        //获取照片的原图
        //  let gotImage=info[UIImagePickerControllerOriginalImage]as! UIImage
        //获取图片裁剪的图
        let gotImage=info[UIImagePickerControllerEditedImage]as! UIImage
        
        let midImage:UIImage=self.imageWithImageSimple(gotImage,scaledToSize:CGSizeMake(100.0,100.0))//这是对图片进行缩放，因为固定了长宽，所以这个方法会变型，有需要的自已去完善吧， 这里只是粗略使用。
        upload(midImage)//上传
    }
    //缩放图片
    func imageWithImageSimple(image:UIImage,scaledToSize newSize:CGSize)->UIImage
    {
        UIGraphicsBeginImageContext(newSize);
        image.drawInRect(CGRectMake(0,0,newSize.width,newSize.height))
        let newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
        
    }
    
    //上传
    func upload(img:UIImage)
    {
        
        //        lb.frame=CGRectMake(0,0,300,20)
        //
        //        lb.textColor=UIColor.whiteColor()
        //        lb.text="上传中...."
        //        lb.textAlignment=NSTextAlignment.Center
        //        lb.backgroundColor=UIColor.blackColor()
        //        lb.alpha=1
        //
        //       // 添加风火轮
        //        av.frame=CGRectMake(200,200,20, 20)
        //        av.backgroundColor=UIColor.whiteColor()
        //        av.color=UIColor.redColor()
        //        av.startAnimating()
        
        
        
        //
        //        self.view.addSubview(av)
        //
        //        self.view.addSubview(lb)
        
        let data=UIImagePNGRepresentation(img)//把图片转成data
        headerPicture.image = UIImage(data: data!)
        self.tableView.reloadData()
        
        let uploadurl:String="http://219.216.65.182:8080/NationalService/MultiFormAction?operation=_updateCustomerPicture"//设置服务器接收地址
        let request=NSMutableURLRequest(URL:NSURL(string:uploadurl)!)
        
        request.HTTPMethod="POST"//设置请求方式
        let boundary:String="-------------------"
        //上传文件必须设置
        let contentType:String="multipart/form-data;boundary="+boundary
        request.addValue(contentType, forHTTPHeaderField:"Content-Type")
        let body=NSMutableData()
        let customerID = customerid
        
        //        一个图片
        body.appendData(NSString(format:"\r\n--\(boundary)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition:form-data;name=\"userfile\";filename=\"1.jpg\"\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Type:application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(data!)
        body.appendData(NSString(format:"\r\n--\(boundary)").dataUsingEncoding(NSUTF8StringEncoding)!)
        
        //        传入一个普通参数
        body.appendData(NSString(format:"\r\n--\(boundary)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition:form-data;name=\"customerID\"\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Type:text/plain;charset=utf-8\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"\(customerID)").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"\r\n--\(boundary)").dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        request.HTTPBody=body
        let que=NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: que, completionHandler: {
            (response, data, error) ->Void in
            
            if (error != nil){
                
            }else{
                //Handle data in NSData type
                //             println("data\(data)")
                //             println("response\(response)")
                let tr:AnyObject=NSString(data:data!,encoding:NSUTF8StringEncoding)!
                //var test2: AnyObject? = json?.objectForKey("tr")
                //            let json:AnyObject? = NSJSONSerialization.JSONObjectWithData(tr, options: NSJSONReadingOptions.AllowFragments, error: nil)
                //            //        var dic = dict as! NSDictionary
                // println(test2)
                //                print("tr\(tr)")
                //            let serverResponse = tr.objectForKey("serverResponse") as? String
                //            println(serverResponse)
                
                
                //在主线程中更新UI风火轮才停止
                dispatch_sync(dispatch_get_main_queue(), {
                    //self.av.stopAnimating()
                    //self.lb.hidden=true
                    
                })
                
            }
        })
    }
    
    
    
    override func  viewWillAppear(animated: Bool) {
        
        readNSUerDefaults () 
        self.tableView.reloadData()
        
        
        
    }
    
    
    //从NSUerDefaults 中读取数据
    func readNSUerDefaults () {
        
        var userDefaultes = NSUserDefaults.standardUserDefaults()
        if  (userDefaultes.stringForKey("customerID")) != nil && (userDefaultes.stringForKey("loginPassword")) != nil{
            customerid = userDefaultes.stringForKey("customerID")!
            loginPassword = userDefaultes.stringForKey("loginPassword")!
            
        }
        
    }
    
    
}
