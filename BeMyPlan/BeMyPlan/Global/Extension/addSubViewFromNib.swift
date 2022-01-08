//
//  addSubViewFromNib.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import Foundation

extension UIView{
  public func addSubviewFromNib(view : UIView){
    let view = Bundle.main.loadNibNamed(view.className, owner: self, options: nil)?.first as! UIView
    view.frame = bounds
    addSubview(view)
  }
}
