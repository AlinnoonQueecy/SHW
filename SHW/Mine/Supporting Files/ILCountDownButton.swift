//
//  ILCountDownButton.swift
//  ILButton
//
//  Created by Mac on 15/7/20.
//  Copyright © 2015年 Mac. All rights reserved.
//

import UIKit

class ILCountDownButton: UIButton {
    
    
    private var timer: NSTimer!
    private var countDown = 0
    private var originCoutDown: Int!
    //回调接口
    var restartCallback: (() -> (Void))?
    //动态计数时，加在数字前面的字符串
    var countFrontString: String = ""
    //动态计数时，加在数字后面的字符串
    var countRearString: String = ""

    convenience init(count: Int) {
        self.init(frame: CGRectZero)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        //self.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(17)
        self.originCoutDown = count
        self.countDown = count
        //super.addTarget(self, action: "restart", forControlEvents: UIControlEvents.TouchUpInside )
    }
 
    
    //开始倒计时
    func restart() {
        self.countDown = self.originCoutDown
        self.heartbeat()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "heartbeat", userInfo: nil, repeats: true)
        self.enabled = false
        self.restartCallback?()
    }
//    //开始倒计时
//    func restart(count: Int) {
//        self.countDown = self.originCoutDown
//        self.heartbeat()
//        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "heartbeat", userInfo: nil, repeats: true)
//        self.enabled = false
//        self.restartCallback?()
//    }
    
    //设置可点击时标题
    func setTitleForRestart(title: String) {
        super.setTitle(title, forState: UIControlState.Normal)
    }
    
    //设置可点击时背景图片
    func setBackgroundImageForRestart(image: UIImage) {
        super.setBackgroundImage(image, forState: UIControlState.Normal)
        self.setBackgroundImageForHighlighted(image)
    }
    
    //设置计数背景图片
    func setBackgroundImageForCount(image: UIImage) {
        super.setBackgroundImage(image, forState: UIControlState.Disabled)
    }
    

    
    
//////////////////////////////////////////////////////////////////////////
    
    override func setTitle(title: String?, forState state: UIControlState) {
        assertionFailure("please use setTitleForRestart")
    }
    
//    override func addTarget(target: AnyObject?, action: Selector, forControlEvents controlEvents: UIControlEvents) {
////        assertionFailure("please use buttonClickedCallback")
//        println("please use buttonClickedCallback")
//    }
    
 
    private func setBackgroundImageForHighlighted(image: UIImage) {
        super.setBackgroundImage(image, forState: UIControlState.Highlighted)
        
    }
    
    
    @objc private func heartbeat() {
        self.countDown--
        if self.countDown == 0 {
            self.normalState()
            return
        }
        let countDwonStr = self.countFrontString + String(self.countDown) + self.countRearString
        super.setTitle(countDwonStr, forState: UIControlState.Disabled)
    }
    
    private func normalState() {
        if self.timer == nil {
            return
        }
        self.timer.invalidate()
        self.timer = nil
        self.enabled = true
    }
    

}
