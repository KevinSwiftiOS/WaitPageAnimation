//
//  RectangleLayer.swift
//  复杂动画的实现
//
//  Created by hznucai on 16/6/21.
//  Copyright © 2016年 hznucai. All rights reserved.
//

import UIKit

class RectangleLayer: CAShapeLayer {
    override init() {
        super.init()
        fillColor = UIColor.clearColor().CGColor
        lineWidth = 5.0
        path = rectangleFullPath.CGPath
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    var rectangleFullPath:UIBezierPath{
        let rectanglePath = UIBezierPath()
        rectanglePath.moveToPoint(CGPointMake(0.0, 100.0))
        rectanglePath.addLineToPoint(CGPointMake(0.0, -lineWidth))
        rectanglePath.addLineToPoint(CGPointMake(100.0, -lineWidth))
        rectanglePath.addLineToPoint(CGPointMake(100.0, 100.0))
        rectanglePath.addLineToPoint(CGPointMake(-lineWidth / 2, 100.0))
        return rectanglePath
    }
    
    func strokeChangeWithColor(color:UIColor) {
        self.strokeColor = color.CGColor
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.duration = 0.4
        self.addAnimation(strokeAnimation, forKey: nil)
    }
}
