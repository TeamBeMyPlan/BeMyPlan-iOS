//
//  NewPlanPreviewNaviBar.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class NewPlanPreviewNaviBar: XibView{
  
  @IBOutlet private var backButton: UIButton!
  @IBOutlet var shareButton: UIButton!
  
  @IBOutlet var backgroundView: UIView!
  @IBOutlet var backButtonCircleView: UIView!
  @IBOutlet var shareButtonCircleView: UIView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func configureUI() {
    backButtonCircleView.layer.cornerRadius = 100
    shareButtonCircleView.layer.cornerRadius = 100
    backgroundView.alpha = 0
    backButtonCircleView.alpha = 1
    shareButtonCircleView.alpha = 1
  }
}
