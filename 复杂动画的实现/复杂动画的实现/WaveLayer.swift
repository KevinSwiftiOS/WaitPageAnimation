//
//  WaveLayer.swift
//  复杂动画的实现
//
//  Created by hznucai on 16/6/21.
//  Copyright © 2016年 hznucai. All rights reserved.
//

import UIKit

class WaveLayer: CAShapeLayer {
    let kAnimationDuration:CFTimeInterval = 0.18
    override init() {
        super.init()
        fillColor = UIColor.colorWithHexString("#40e0b0").CGColor
        
    }
    //加载xib的时候需要 表明是从toryboard中初始化
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var wavePathPre:UIBezierPath{
        let arcPath = UIBezierPath()
        arcPath.moveToPoint(CGPointMake(0.0, 100.0))
        arcPath.addLineToPoint(CGPointMake(0.0, 99.0))
        arcPath.addLineToPoint(CGPointMake(100.0, 99.0))
        arcPath.addLineToPoint(CGPointMake(100.0, 100.0))
        arcPath.addLineToPoint(CGPointMake(0.0, 100.0))
        arcPath.closePath()
        return arcPath
    }
    var wavePathStarting:UIBezierPath{
        let arcPath = UIBezierPath()
        arcPath.moveToPoint(CGPointMake(0.0, 100.0))
        arcPath.addLineToPoint(CGPointMake(0.0, 80.0))
        arcPath.addCurveToPoint(CGPointMake(100.0, 80), controlPoint1: CGPointMake(30.0, 70.0), controlPoint2: CGPointMake(40.0, 90.0))
        arcPath.addLineToPoint(CGPointMake(100.0, 100.0))
        arcPath.addLineToPoint(CGPointMake(0.0, 100.0))
        arcPath.closePath()
        return arcPath
    }
    var wavePathLow:UIBezierPath{
        let arcPath = UIBezierPath()
        arcPath.moveToPoint(CGPointMake(0.0, 100.0))
        arcPath.addLineToPoint(CGPointMake(0.0, 60.0))
        arcPath.addCurveToPoint(CGPointMake(100.0, 60.0), controlPoint1: CGPointMake(30.0, 65.0), controlPoint2: CGPointMake(40.0, 50.0))
        arcPath.addLineToPoint(CGPointMake(100.0, 100.0))
        arcPath.addLineToPoint(CGPointMake(0.0, 100.0))
        arcPath.closePath()
        return arcPath
    }
    var wavePathMid: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.moveToPoint(CGPoint(x: 0.0, y: 100.0))
        arcPath.addLineToPoint(CGPoint(x: 0.0, y: 40.0))
        arcPath.addCurveToPoint(CGPoint(x: 100.0, y: 40.0), controlPoint1: CGPoint(x: 30.0, y: 30.0), controlPoint2: CGPoint(x: 40.0, y: 50.0))
        arcPath.addLineToPoint(CGPoint(x: 100.0, y: 100.0))
        arcPath.addLineToPoint(CGPoint(x: 0.0, y: 100.0))
        arcPath.closePath()
        return arcPath
    }
    
    var wavePathHigh: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.moveToPoint(CGPoint(x: 0.0, y: 100.0))
        arcPath.addLineToPoint(CGPoint(x: 0.0, y: 20.0))
        arcPath.addCurveToPoint(CGPoint(x: 100.0, y: 20.0), controlPoint1: CGPoint(x: 30.0, y: 25.0), controlPoint2: CGPoint(x: 40.0, y: 10.0))
        arcPath.addLineToPoint(CGPoint(x: 100.0, y: 100.0))
        arcPath.addLineToPoint(CGPoint(x: 0.0, y: 100.0))
        arcPath.closePath()
        return arcPath
    }
    
    var wavePathComplete: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.moveToPoint(CGPoint(x: 0.0, y: 100.0))
        arcPath.addLineToPoint(CGPoint(x: 0.0, y: -5.0))
        arcPath.addLineToPoint(CGPoint(x: 100.0, y: -5.0))
        arcPath.addLineToPoint(CGPoint(x: 100.0, y: 100.0))
        arcPath.addLineToPoint(CGPoint(x: 0.0, y: 100.0))
        arcPath.closePath()
        return arcPath
    }
    func animate() {
        //1
        let waveAnimationPre = CABasicAnimation(keyPath: "path")
        waveAnimationPre.fromValue = wavePathPre.CGPath
        waveAnimationPre.toValue = wavePathStarting.CGPath
        waveAnimationPre.beginTime = 0.0
        waveAnimationPre.duration = kAnimationDuration
        /// 2
        let waveAnimationLow: CABasicAnimation = CABasicAnimation(keyPath: "path")
        waveAnimationLow.fromValue = wavePathStarting.CGPath
        waveAnimationLow.toValue = wavePathLow.CGPath
        waveAnimationLow.beginTime = waveAnimationPre.beginTime + waveAnimationPre.duration
        waveAnimationLow.duration = kAnimationDuration
        /// 3
        let waveAnimationMid: CABasicAnimation = CABasicAnimation(keyPath: "path")
        waveAnimationMid.fromValue = wavePathLow.CGPath
        waveAnimationMid.toValue = wavePathMid.CGPath
        waveAnimationMid.beginTime = waveAnimationLow.beginTime + waveAnimationLow.duration
        waveAnimationMid.duration = kAnimationDuration
        /// 4
        let waveAnimationHigh: CABasicAnimation = CABasicAnimation(keyPath: "path")
        waveAnimationHigh.fromValue = wavePathMid.CGPath
        waveAnimationHigh.toValue = wavePathHigh.CGPath
        waveAnimationHigh.beginTime = waveAnimationMid.beginTime + waveAnimationMid.duration
        waveAnimationHigh.duration = kAnimationDuration
        /// 5
        let waveAnimationComplete: CABasicAnimation = CABasicAnimation(keyPath: "path")
        waveAnimationComplete.fromValue = wavePathHigh.CGPath
        waveAnimationComplete.toValue = wavePathComplete.CGPath
        waveAnimationComplete.beginTime = waveAnimationHigh.beginTime + waveAnimationHigh.duration
        waveAnimationComplete.duration = kAnimationDuration
      //加一个组别
        let arcAnimationGroup = CAAnimationGroup()
        arcAnimationGroup.animations = [waveAnimationPre,waveAnimationLow,waveAnimationMid,waveAnimationHigh,waveAnimationComplete]
        arcAnimationGroup.duration = waveAnimationComplete.beginTime + waveAnimationComplete.duration
        arcAnimationGroup.fillMode = kCAFillModeForwards
        arcAnimationGroup.removedOnCompletion = false
        self.addAnimation(arcAnimationGroup, forKey: nil)
    }
}
