//
//  CityHandle.swift
//  SZFU
//
//  Created by wufei on 15/7/26.
//  Copyright (c) 2015年 wufei. All rights reserved.
//

import UIKit

class CityHandle: NSObject {
    
    
    var s_cityList = NSArray()
    var s_provinceList = NSArray()
    var s_sectionCityList = NSArray()
    var s_indexList = NSArray()
    
    
    
   func  shareProvinceList  () -> NSArray {
        var onceToken:dispatch_once_t = 0
        dispatch_once(&onceToken){
            if self.s_provinceList.count == 0 {
                self.s_provinceList = self.getProvinceList()
            }
        }
        return s_provinceList
    }
    
    //3.得到转化后的城市列表
    func shareCityList  () -> NSArray {
        var onceToken:dispatch_once_t = 0
        dispatch_once(&onceToken){
            if self.s_cityList.count == 0 {
                self.s_cityList = self.getCityList()
            }
        }
        return s_cityList
    }
    
    //得到城市分组
    func shareSectionCityList () -> NSArray {
      var onceToken:dispatch_once_t = 0
         dispatch_once(&onceToken){
            if self.s_sectionCityList.count == 0 {
                self.s_sectionCityList = self.dataForSection()
                }
            }
        return s_sectionCityList
    }
    

    func shareIndexList () -> NSArray {
        var onceToken:dispatch_once_t = 0
        dispatch_once(&onceToken){
            
            if self.s_indexList.count == 0  {
                self.s_indexList = self.tableViewIndex()
             }
           
            }
    
        return s_indexList
    }
    
    //0.省
    func getProvinceList  () -> NSArray{
        
    let path = NSBundle.mainBundle().pathForResource("city",ofType:"js")
    let  data:NSData = NSFileManager.defaultManager().contentsAtPath(path!)!
    let provinceList:NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: nil) as! NSArray
        
    return provinceList
    }
    
    //2.得到城市
    func getCityList  () -> NSArray {
        //1.得到省
        let provinceList:NSArray = self.shareProvinceList()
        let cityList:NSMutableArray = NSMutableArray()
        for var i = 0; i < provinceList.count; i++ {
            let provinceDict:NSDictionary = provinceList.objectAtIndex(i) as! NSDictionary
            let cityForProvince: NSArray = provinceDict.objectForKey("cities") as! NSArray
            for var j = 0; j < cityForProvince.count; j++ {
                let cityDict:NSDictionary  = cityForProvince.objectAtIndex(j) as! NSDictionary
                let city:CityModel  = CityModel()
                city.cityID =  cityDict.objectForKey("id") as? NSString
                city.cityName = cityDict.objectForKey("name") as? NSString
                city.parentID = cityDict.objectForKey("parentId") as? NSString
                city.cityPinYin = cityDict.objectForKey("pinyin") as? NSString
                cityList.addObject(city)
            }
        }
        return cityList
    }
    
    
    
   func getCityNameWithCityID(cityID:NSString ) -> NSString {
    
        var cityName: NSString?
        let cityList:NSArray  = self.shareCityList()
        var city:CityModel?
        for  city in cityList  {
            if  city.cityID!!.isEqualToString(cityID as String) {
                cityName = city.cityName
                break
                }
            }
            return cityName!
        }
    
   
    
    
    func getProvinceIndexWithCityID(cityID:NSString ) -> NSInteger {
        var cityModel:CityModel?
        let cityList: NSArray = self.shareCityList()
        var city:CityModel?
        for city in cityList  {
            if city.cityID!!.isEqualToString(cityID as String) {
                cityModel = city as? CityModel
                break
            }
        }
        var index:NSInteger = 0
        for var i = 0; i < self.shareProvinceList().count; i++ {
            let provinceDict:NSDictionary = self.shareProvinceList().objectAtIndex(i) as! NSDictionary
            let parentID: NSString = provinceDict.objectForKey("id") as! NSString
            if parentID.isEqualToString(cityModel!.parentID as! String) {
                index = i
                break
                }
            }
        return  index
      
        }
    
    
    
    
    func getCityIndexWithCityID(cityID:NSString ) -> NSInteger {
        
        let provinceIndex: NSInteger = self.getProvinceIndexWithCityID(cityID) as NSInteger
        
        let provinceDict: NSDictionary = self.shareProvinceList().objectAtIndex(provinceIndex) as! NSDictionary
        let cityForProvince:NSArray = provinceDict.objectForKey("cities") as! NSArray
        var index = 0
        for var i = 0; i < cityForProvince.count ; i++ {
            let cityDict:NSDictionary = cityForProvince.objectAtIndex(i) as! NSDictionary
            let city_ID:NSString = cityDict.objectForKey("id") as! NSString
            if city_ID.isEqualToString(cityID as String) {
                index = i
                break
            }
        }
        return index
    }
    
    
    
    //按拼音城市排序
    func sortCityList() -> NSArray{
        let cityList:NSArray = self.shareCityList()
        let sort:NSSortDescriptor = NSSortDescriptor(key:"cityPinYin", ascending: true)
        let arr = NSArray().arrayByAddingObject(sort)
        return cityList.sortedArrayUsingDescriptors(arr as AnyObject as! [AnyObject])
      
    }
    
    
    func tableViewIndex() -> NSArray{
        //给城市按拼音排序
        let sortArry:NSArray = self.sortCityList()
        let resultArray: NSMutableArray = NSMutableArray()
        var indexString:NSString = ""
    //#栏
        var otherIndex = false
        var city:CityModel?
        for city in sortArry {
            if city.cityPinYin!!.length < 1 {
                otherIndex = true
            }
            else {
                let firstCharacter:NSString = city.cityPinYin!!.substringToIndex(1).uppercaseString
                //若第一个字符为非A-Z
               // let firstChar: Character = firstCharacter.characterAtIndex(0) as! Character
                let firstChar: Character = Character( firstCharacter as String)

                if ((firstChar >= "A" && firstChar <= "Z") == false) {
                    otherIndex = true
                }
                else {
                    if (indexString.isEqualToString(firstCharacter as String)) == false {
                        resultArray.addObject(firstCharacter)
                        indexString = firstCharacter
                    }
                }
    
            }
        }
        if otherIndex == true {
            resultArray.addObject("#")
        }
        return resultArray
    }

    
  //按拼音给城市分组
  func dataForSection () -> NSArray{
    //
    let sortArray:NSArray = self.sortCityList()
    var resultArray: NSMutableArray = NSMutableArray()
    var sectionArray: NSMutableArray = NSMutableArray()
    var indexString:NSString = ""
    //#栏
    var otherArray:NSMutableArray = NSMutableArray()
    var city:CityModel?
    for  city in sortArray {
        if city.cityPinYin!!.length < 1 {
            otherArray.addObject(city)
        }
        else {
          let firstCharacter:NSString  = city.cityPinYin!!.substringToIndex(1).uppercaseString as NSString
            //若第一个字符为非A-Z
           // let firstChar: Character = (firstCharacter.characterAtIndex(0) as? Character)!
            let firstChar: Character = Character(firstCharacter as String)
            if ((firstChar >= "A" && firstChar <= "Z") == false) {
                otherArray.addObject(city)
            }
            else {
                //A-Z
                if indexString.isEqualToString(firstCharacter as String) == false {
                    sectionArray = NSMutableArray()
                    sectionArray.addObject(city)
                    resultArray.addObject(sectionArray)
                    indexString = firstCharacter
                }
                else {
                    sectionArray.addObject(city)
                }
            }
            
        }
    }
    resultArray.addObject(otherArray)
    return resultArray
   }
    
    //是否被覆盖
    func QueryCovered (cityName:String)->String{
        var url: NSURL! = NSURL(string: HttpData.http+"/FamilyServiceSystem/MobileCityInfoAction?operation=_queryisCovered")
        println("url:\(url)")
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url, cachePolicy:NSURLRequestCachePolicy.UseProtocolCachePolicy,timeoutInterval: 10)
        
        request.HTTPMethod = "POST"
        //var param:String = "{\"customerAccount\":\"Alex\",\"Password\":\"a123\"}"
        var param:String = "{\"cityName\":\"\(cityName)\"}"
            println("param:\(param)")
        var data:NSData = param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        request.HTTPBody = data;
        var response:NSURLResponse?
        var error:NSError?
        var receiveData:NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        if (error != nil)
        {
            println(error?.code)
            println(error?.description)
        }
        else
        {
            var jsonString = NSString(data:receiveData!, encoding: NSUTF8StringEncoding)
            println(jsonString)
            
        }
        
        let json:AnyObject! = NSJSONSerialization.JSONObjectWithData(receiveData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        var Covered: AnyObject?=json.objectForKey("isCovered")
        
        var isCovered :String = Covered as! String
        
        return isCovered
     }
    
  }
    



