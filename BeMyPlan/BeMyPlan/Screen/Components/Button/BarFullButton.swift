//
//  BarFullButton.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class BarFullButton : UIButton{
  func setButtonState(isSelected : Bool,title : String){
    layer.cornerRadius = 5
    titleLabel?.textColor = .white
    backgroundColor = isSelected ? UIColor.bemyBlue : UIColor.white
    titleLabel?.textColor = .white
    titleLabel?.text = title
  }
}

