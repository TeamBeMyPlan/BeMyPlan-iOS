//
//  MainCardView.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit

class MainCardView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
  }
    
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
  }

}
