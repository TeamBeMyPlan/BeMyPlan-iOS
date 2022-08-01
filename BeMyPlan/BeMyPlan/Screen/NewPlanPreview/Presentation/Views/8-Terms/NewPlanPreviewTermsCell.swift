//
//  NewPlanPreviewTermsCell.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/08/02.
//

import UIKit

class NewPlanPreviewTermsCell: UITableViewCell {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var arrowButton: UIButton!
  @IBOutlet var contentTextView: UITextView!
  @IBOutlet var expandButton: UIButton!
  
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
  private func configureUI() {
    contentTextView.removeMargin()
  }
  
  private func addButtonActions() {
    expandButton.press {
      
    }
  }
}
