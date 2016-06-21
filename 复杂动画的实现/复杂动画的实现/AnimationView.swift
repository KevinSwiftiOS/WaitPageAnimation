//
//  AnimationView.swift
//  复杂动画的实现
//
//  Created by hznucai on 16/6/21.
//  Copyright © 2016年 hznucai. All rights reserved.
//

import UIKit
//当动画结束后 加载label welcome这个标签
protocol AnimationViewDelegate:class {
    func completeAnimation()
}
//实现圆形以及椭圆的渐变
class AnimationView: UIView {
let circleLayer = CircleLayer()
let triangleLayer = TriangleLayer()
 let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    let waveLayer = WaveLayer()
    var parentFrame:CGRect = CGRectZero
    weak var delegate:AnimationViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        addCircleLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //add circle layer
    func addCircleLayer() {
        self.layer.addSublayer(circleLayer)
        circleLayer.expand()
        //当这个动画结束后 增加wobbleCircleLayer 就是这样一层一层的推导下去
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(AnimationView.wobbleCircleLayer), userInfo: nil, repeats: false)
        
    }
    func wobbleCircleLayer() {
        circleLayer.wobbleAnimate()
        layer.addSublayer(triangleLayer)
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(showTriangleAnimation), userInfo: nil, repeats: false)

    }
    func showTriangleAnimation() {
        triangleLayer.triangleAnimate()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(AnimationView.transformAnima), userInfo: nil, repeats: false)
        
    }
    func transformAnima() {
        transformRotationZ()
        circleLayer.contract()
        NSTimer.scheduledTimerWithTimeInterval(0.45, target: self, selector: #selector(drawRedRectangleAnimation), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.65, target: self, selector: #selector(drawBlueRectangleAnimation), userInfo: nil, repeats: false)
    }
    //进行旋转
    func transformRotationZ() {
        self.layer.anchorPoint = CGPointMake(0.5, 0.65)
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2)
        rotationAnimation.duration = 0.45
        rotationAnimation.removedOnCompletion = true
        layer.addAnimation(rotationAnimation, forKey: nil)
        
    }
    /*draw red stroke
    */
    func drawRedRectangleAnimation() {
        layer.addSublayer(redRectangleLayer)
        redRectangleLayer.strokeChangeWithColor(UIColor.colorWithHexString("#da70d6"))
    }
    
    /**
     draw blue stroke
     */
    func drawBlueRectangleAnimation() {
        layer.addSublayer(blueRectangleLayer)
        blueRectangleLayer.strokeChangeWithColor(UIColor.colorWithHexString("#40e0b0"))
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(drawWaveAnimation), userInfo: nil, repeats: false)
    }
    
    func drawWaveAnimation() {
        layer.addSublayer(waveLayer)
        waveLayer.animate()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(expandView), userInfo: nil, repeats: false)
    }

    //expand方法
    func expandView() {
        backgroundColor = UIColor.colorWithHexString("#40e0b0")
        self.frame = CGRectMake(frame.origin.x - blueRectangleLayer.lineWidth, frame.origin.y - blueRectangleLayer.lineWidth, frame.size.width + blueRectangleLayer.lineWidth * 2, frame.size.height + blueRectangleLayer.lineWidth * 2)
        blueRectangleLayer.sublayers = nil
        //delay 动画开始前的延迟时间
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.frame = self.parentFrame
            }) { (finish) in
                self.delegate?.completeAnimation()
        }
    }
}
