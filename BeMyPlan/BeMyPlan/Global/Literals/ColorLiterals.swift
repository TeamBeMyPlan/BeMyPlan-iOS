//
//  ColorLiterals.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import Foundation
import UIKit

extension UIColor {
  @nonobjc class var mainBlue: UIColor {
    return UIColor(red: 66 / 255, green: 133 / 255, blue: 244 / 255, alpha: 1)
  }
  
  @nonobjc class var lightGray: UIColor{
    return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
  }
  
  @nonobjc class var gray: UIColor{
    return UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
  }
  
  @nonobjc class var darkGray: UIColor{
    return UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
  }
  
  @nonobjc class var palerGray: UIColor{
    return UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
  }
  
  @nonobjc class var borderColor: UIColor{
    return UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
  }
}
