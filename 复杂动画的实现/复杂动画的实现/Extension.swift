//
//  Extension.swift
//  复杂动画的实现
//
//  Created by hznucai on 16/6/21.
//  Copyright © 2016年 hznucai. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    //make color with hex string
    static func colorWithHexString(hex:String) -> UIColor{
        var cString = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).uppercaseString
        if(cString.hasPrefix("#")){
            cString = (cString as NSString).substringToIndex(1)
        }
        if(cString.characters.count != 6){
            return UIColor.grayColor()
        }
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringToIndex(2) as NSString).substringToIndex(2)
         let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        var r:CUnsignedInt = 0,g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}