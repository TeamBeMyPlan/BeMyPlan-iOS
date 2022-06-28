//
//  HashtagCVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/29.
//

import UIKit

class HashtagCVC: UICollectionViewCell,UICollectionViewRegisterable {
  
  var viewModel: HashtagCellViewModel!
  static var isFromNib: Bool = true
  
  @IBOutlet var backgroundContentView: UIView!
  @IBOutlet var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureUI()
  }
}

extension HashtagCVC {
  private func configureUI() {
    backgroundContentView.layer.cornerRadius = 2
    titleLabel.text = viewModel.title
  }
}

typealias HashtagCellViewModel = String
