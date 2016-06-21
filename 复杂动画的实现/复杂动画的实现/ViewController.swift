//
//  ViewController.swift
//  复杂动画的实现
//
//  Created by hznucai on 16/6/21.
//  Copyright © 2016年 hznucai. All rights reserved.
//

import UIKit

class ViewController: UIViewController,AnimationViewDelegate{
    var animationView = AnimationView(frame:CGRectZero)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAnimationView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addAnimationView() {
        let size:CGFloat = 100.0
       animationView.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - size/2, CGRectGetHeight(self.view.frame)/2 - size/2, size, size)
        view.addSubview(animationView)
        animationView.parentFrame = self.view.frame
        animationView.delegate = self
        
    }
    //加label
    func completeAnimation() {
        animationView.removeFromSuperview()
        view.backgroundColor = UIColor.colorWithHexString("#40e0b0")
        let label = UILabel(frame: view.frame)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.text = "welcome"
        label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25)
        view.addSubview(label)
        //3
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0)
            
            }) { (finish) in
                self.addTouchButton()
        }
    }
    func addTouchButton() {
        let button = UIButton()
        button.frame = CGRectMake(0.0, 0.0, view.bounds.width, view.bounds.height)
        button.addTarget(self, action: #selector(btnClick), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func btnClick() {
        view.backgroundColor = UIColor.whiteColor()
        view.subviews.forEach { (
            $0.removeFromSuperview()
            )}
        animationView = AnimationView(frame: CGRectZero)
        addAnimationView()
    }
}

