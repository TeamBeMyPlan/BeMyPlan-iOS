//
//  PurhcaseHistoryTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/08/07.
//

import UIKit

class PurhcaseHistoryTVC: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
  
  @IBOutlet var containerView: UIView!
  @IBOutlet var thumnailImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUI()
  }
  
  func setDataModel(_ dateModel: PurchaseHistoryContentModel) {
    titleLabel.text = dateModel.title
    priceLabel.text = dateModel.price
  }
}

extension PurhcaseHistoryTVC {
  private func setUI() {
    containerView.layer.cornerRadius = 5
    containerView.layer.borderColor = UIColor.grey06.cgColor
    containerView.layer.borderWidth = 1
    thumnailImageView.layer.cornerRadius = 5
    titleLabel.font = .getSpooqaMediumFont(size: 14)
  }
}
