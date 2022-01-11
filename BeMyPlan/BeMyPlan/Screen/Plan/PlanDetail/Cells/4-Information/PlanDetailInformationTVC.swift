//
//  PlanDetailInformationTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailInformationTVC: UITableViewCell,UITableViewRegisterable {
  
  static var isFromNib: Bool = true
  
  @IBOutlet var addressLabelMaxWidthConstraint: NSLayoutConstraint!{
    didSet{
      addressLabelMaxWidthConstraint.constant = screenWidth - 72
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
