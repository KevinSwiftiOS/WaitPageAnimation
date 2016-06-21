//
//  TriangleLayer.swift
//  复杂动画的实现
//
//  Created by hznucai on 16/6/21.
//  Copyright © 2016年 hznucai. All rights reserved.
//

import UIKit

class TriangleLayer: CAShapeLayer {
    let paddingSpace:CGFloat = 30.0
    override init() {
        super.init()
        self.fillColor = UIColor.colorWithHexString("#009ad6").CGColor
        self.strokeColor = UIColor.colorWithHexString("#009ad6").CGColor
        self.lineWidth = 7.0
        path = smallTrianglePath.CGPath
        lineCap = kCALineCapRound
        lineJoin = kCALineJoinRound
    }
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    var smallTrianglePath:UIBezierPath{
        let smallPath = UIBezierPath()
        smallPath.moveToPoint(CGPointMake(5.0 + paddingSpace, 95.0))
        smallPath.addLineToPoint(CGPointMake(50.0, 12.5 + paddingSpace))
        smallPath.addLineToPoint(CGPointMake(95.0 - paddingSpace, 95.0))
        smallPath.closePath()
        return smallPath
    }
    var leftTrianglePath: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLineToPoint(CGPoint(x: 50.0, y: 12.5 + paddingSpace))
        trianglePath.addLineToPoint(CGPoint(x: 95.0 - paddingSpace, y: 95.0))
        trianglePath.closePath()
        return trianglePath
    }
    
    var rightTrianglePath: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLineToPoint(CGPoint(x: 50.0, y: 12.5 + paddingSpace))
        trianglePath.addLineToPoint(CGPoint(x: 95.0, y: 95.0))
        trianglePath.closePath()
        return trianglePath
    }
    
    var topTrianglePath: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLineToPoint(CGPoint(x: 50.0, y: 12.5))
        trianglePath.addLineToPoint(CGPoint(x: 95.0, y: 95.0))
        trianglePath.closePath()
        return trianglePath
    }

    //向外做拉伸的动作
    func triangleAnimate() {
        // left
        let triangleAnimationLeft: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimationLeft.fromValue = smallTrianglePath.CGPath
        triangleAnimationLeft.toValue = leftTrianglePath.CGPath
        triangleAnimationLeft.beginTime = 0.0
        triangleAnimationLeft.duration = 0.3
        // right
        let triangleAnimationRight: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimationRight.fromValue = leftTrianglePath.CGPath
        triangleAnimationRight.toValue = rightTrianglePath.CGPath
        triangleAnimationRight.beginTime = triangleAnimationLeft.beginTime + triangleAnimationLeft.duration
        triangleAnimationRight.duration = 0.25
        // top
        let triangleAnimationTop: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimationTop.fromValue = rightTrianglePath.CGPath
        triangleAnimationTop.toValue = topTrianglePath.CGPath
        triangleAnimationTop.beginTime = triangleAnimationRight.beginTime + triangleAnimationRight.duration
        triangleAnimationTop.duration = 0.20
        // group
        let triangleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        triangleAnimationGroup.animations = [triangleAnimationLeft, triangleAnimationRight, triangleAnimationTop]
        triangleAnimationGroup.duration = triangleAnimationTop.beginTime + triangleAnimationTop.duration
        triangleAnimationGroup.fillMode = kCAFillModeForwards
        triangleAnimationGroup.removedOnCompletion = false
        addAnimation(triangleAnimationGroup, forKey: nil)
    }
}
