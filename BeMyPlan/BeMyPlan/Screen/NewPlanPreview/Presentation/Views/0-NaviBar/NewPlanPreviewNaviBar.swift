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
    configureUI()
    bindButtonAction()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureUI()
    bindButtonAction()
  }
  
  private func configureUI() {
    backButtonCircleView.layer.cornerRadius = 18
    shareButtonCircleView.layer.cornerRadius = 18
    backgroundView.alpha = 0
    backgroundView.backgroundColor = .white
    backButtonCircleView.alpha = 1
    shareButtonCircleView.alpha = 1
    backButtonCircleView.backgroundColor = .white
    shareButtonCircleView.backgroundColor = .white
    layoutIfNeeded()
  }
  
  private func bindButtonAction() {
    backButton.press {
      self.postObserverAction(.navigationPop)
    }
  }
}
