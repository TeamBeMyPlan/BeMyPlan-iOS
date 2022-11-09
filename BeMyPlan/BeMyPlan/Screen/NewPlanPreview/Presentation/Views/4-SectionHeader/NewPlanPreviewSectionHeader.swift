//
//  NewPlanPreviewSectionHeader.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/05.
//

import UIKit

final class NewPlanPreviewSectionHeader: XibView{
  
  @IBOutlet var mainContentTitleLabel: UILabel!
  @IBOutlet var purchaseGuideTitleLabel: UILabel!
  @IBOutlet var recommendTitleLabel: UILabel!
  
  @IBOutlet var mainContentLineView: UIView!
  @IBOutlet var purchaseGuideLineView: UIView!
  @IBOutlet var recommendLineView: UIView!
  
  @IBOutlet var mainContentButton: UIButton!
  @IBOutlet var purchaseGuideButton: UIButton!
  @IBOutlet var recommendButton: UIButton!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUI()
    bindButton()
    addObserver()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUI()
    bindButton()
    addObserver()
  }
}

extension NewPlanPreviewSectionHeader {
  internal func setIndex(_ index: Int) {
    
    mainContentLineView.isHidden = true
    purchaseGuideLineView.isHidden = true
    recommendLineView.isHidden = true
    
    mainContentTitleLabel.textColor = .grey03
    purchaseGuideTitleLabel.textColor = .grey03
    recommendTitleLabel.textColor = .grey03
    
    if index == 0 {
      mainContentLineView.isHidden = false
      mainContentTitleLabel.textColor = .grey01
    } else if index == 1 {
      purchaseGuideLineView.isHidden = false
      purchaseGuideTitleLabel.textColor = .grey01
    } else {
      recommendLineView.isHidden = false
      recommendTitleLabel.textColor = .grey01
    }
  }
  
  private func setUI() {
    mainContentTitleLabel.text = "미리보기"
    purchaseGuideTitleLabel.text = "구매안내"
    recommendTitleLabel.text = "추천"
    
    mainContentTitleLabel.font = .boldSystemFont(ofSize: 14)
    purchaseGuideTitleLabel.font = .boldSystemFont(ofSize: 14)
    recommendTitleLabel.font = .boldSystemFont(ofSize: 14)
  }
  
  private func bindButton() {
    mainContentButton.press {
      self.postObserverAction(.newPlanPreviewSectionHeaderClicked,object: 0)
    }
    
    purchaseGuideButton.press {
      self.postObserverAction(.newPlanPreviewSectionHeaderClicked,object: 1)
    }
    
    recommendButton.press {
      self.postObserverAction(.newPlanPreviewSectionHeaderClicked,object: 2)
    }
  }
  
  private func addObserver() {
    addObserverAction(.newPlanPreviewScrollIndexChanged) { noti in
      if let index = noti.object as? Int {
        self.setIndex(index)
      }
    }
  }
}
