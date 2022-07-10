//
//  NewPlanPreviewPurchaseGuideTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/07/10.
//

import UIKit
import SnapKit

class NewPlanPreviewPurchaseGuideTVC: UITableViewCell,UITableViewRegisterable {
  static var isFromNib: Bool = true
  
  var viewModel: PurchaseGuideCellViewModel! {
    didSet{ bindViewModel() }}
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!
  @IBOutlet var informationContainerView: UIView!
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

extension NewPlanPreviewPurchaseGuideTVC {
  private func setUI() {
    informationContainerView.layer.cornerRadius = 5
  }
  
  private func bindViewModel() {
    titleLabel.text = viewModel.title
    subtitleLabel.text = viewModel.subtitle
  }
}

struct PurchaseGuideCellViewModel {
  let title: String
  let subtitle: String
}
