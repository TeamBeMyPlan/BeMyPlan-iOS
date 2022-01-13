//
//  BarSelectButton.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class BarSelectButton : UIButton{
  func setButtonState(isSelected : Bool){
    layer.cornerRadius = 5
    layer.borderWidth = 1
    layer.borderColor = isSelected ? UIColor.bemyBlue.cgColor :
    UIColor.grey04.cgColor
    titleLabel?.textColor = isSelected ? .bemyBlue : .grey04
  }
}

