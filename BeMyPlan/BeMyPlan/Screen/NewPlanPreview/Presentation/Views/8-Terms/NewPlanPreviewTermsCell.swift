//
//  NewPlanPreviewTermsCell.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/08/02.
//

import UIKit

class NewPlanPreviewTermsCell: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
  
  var viewModel: TermDataModel!
  private var type: NewPlanPreviewViewCase = .usingTerm
  
  @IBOutlet var termImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var arrowButton: UIButton!
  @IBOutlet var contentTextView: UITextView!
  @IBOutlet var expandButton: UIButton!
  
  @IBOutlet var purchaseRestoreButton: UIButton!
  override func awakeFromNib() {
    super.awakeFromNib()
    configureUI()
    addButtonActions()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

extension NewPlanPreviewTermsCell {
  internal func setFoldState(isFold: Bool) {
    let image = isFold ? UIImage(named: "dropdown_inactive") : UIImage(named: "dropdown_active")
    arrowButton.setBackgroundImage(image, for: .normal)
  }
  
  internal func setTermType(_ type: NewPlanPreviewViewCase) {
    self.type = type
    switch(type) {
      case .usingTerm:
        termImageView.image = UIImage(named: "usingTerms")
        titleLabel.text = "이용안내"
        purchaseRestoreButton.isHidden = true
        
      case .purhcaseTerm:
        termImageView.image = UIImage(named: "purchaseTerms")
        titleLabel.text = "결제안내"
        purchaseRestoreButton.isHidden = false

      case .question:
        termImageView.image = UIImage(named: "questionEmail")
        titleLabel.text = "문의사항"
        purchaseRestoreButton.isHidden = true

      default: break
    }
  }
  
  private func configureUI() {
    contentTextView.removeMargin()
  }
  
  private func addButtonActions() {
    expandButton.press {
      self.postObserverAction(.newPlanPreviewTermFoldClicked,object: self.type)
    }
    
    purchaseRestoreButton.press {
      self.postObserverAction(.restoreButtonClicked)
    }
  }
}

struct TermDataModel {
  let title: String
  let content: String
}
