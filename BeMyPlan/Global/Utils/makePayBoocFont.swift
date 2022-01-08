//
//  makePayBoocFont.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/06.
//

import UIKit
extension UIFont{
    static func getPayBoocFont(size : CGFloat) -> UIFont{
        if let font = UIFont(name: "payboocOTFBold", size: size){
            return font
        }else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}
