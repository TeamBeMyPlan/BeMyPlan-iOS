//
//  PurchaseHistoryDateCell.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/08/08.
//

import UIKit

class PurchaseHistoryDateCell: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true

  @IBOutlet var dateLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func setLabel(_ date: String) {
    dateLabel.text = date
  }
    
}
