//
//  MapBallonView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/19.
//

import UIKit

class MapBallonView: XibView {

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var iconImageView: UIImageView!
  
  @IBOutlet var arrowLeadingConstraint: NSLayoutConstraint!
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUIs()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUIs()
  }
  
  private func setUIs(){
    layer.cornerRadius = 5
    layer.borderColor = UIColor.grey04.cgColor
    layer.borderWidth = 1
    clipsToBounds = true
  }

  func setLabel(title : String){
    titleLabel.text = title
    titleLabel.sizeToFit()
    arrowLeadingConstraint.constant = titleLabel.frame.width + 12
    layoutIfNeeded()
  }
  
}
