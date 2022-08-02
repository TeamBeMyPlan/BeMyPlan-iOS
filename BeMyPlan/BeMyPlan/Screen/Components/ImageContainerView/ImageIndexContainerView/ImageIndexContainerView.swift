//
//  ImageIndexContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/29.
//

import UIKit

class ImageIndexContainerView: XibView{
  var viewModel: ImageIndexContainerViewModel? {
    didSet { setLabelIndex() }
  }
  @IBOutlet var backgroundContentView: UIView!
  @IBOutlet var currentIndexLabel: UILabel!
  @IBOutlet var totalIndexLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureUI()
  }
}

extension ImageIndexContainerView {
  private func configureUI() {
    backgroundContentView.layer.cornerRadius = 100
    if viewModel == nil { return }
    self.isHidden = viewModel!.totalIndex == 1
  }
  
  private func setLabelIndex() {
    if viewModel == nil { return }
    currentIndexLabel.text = String(viewModel!.currentIndex + 1)
    totalIndexLabel.text = String(viewModel!.totalIndex + 1)
  }
}

struct ImageIndexContainerViewModel {
  var currentIndex: Int
  let totalIndex: Int
}
