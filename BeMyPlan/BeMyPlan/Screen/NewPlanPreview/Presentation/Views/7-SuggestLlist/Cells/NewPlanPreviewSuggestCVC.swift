//
//  NewPlanPreviewSuggestCVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/07/10.
//

import UIKit

class NewPlanPreviewSuggestCVC: UICollectionViewCell,UICollectionViewRegisterable {
  static var isFromNib: Bool = true
  var viewModel: NewPlanPreviewSuggestCellViewModel!
  @IBOutlet var contentImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  
  @IBOutlet var addressLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    setUI()
    bindViewModel()
  }
}

extension NewPlanPreviewSuggestCVC {
  private func setUI() {
    contentImageView.layer.cornerRadius = 4
  }
  
  private func bindViewModel() {
    titleLabel.text = viewModel.title
    addressLabel.text = viewModel.address
    contentImageView.setImage(with: viewModel.imgURL)
  }
}

struct NewPlanPreviewSuggestCellViewModel {
  let title: String
  let address: String
  let imgURL: String
}

