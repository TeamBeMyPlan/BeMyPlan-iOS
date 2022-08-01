//
//  NewPlanMainContentsTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/07/04.
//

import UIKit

class NewPlanMainContentsTVC: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
  var viewModel: NewPlanMainContentsCellViewModel!
  
  @IBOutlet var imageSlideShowView: ImageSlideShow!
  @IBOutlet var contentTextView: UITextView!
}

extension NewPlanMainContentsTVC {
  private func configureUI() {
    contentTextView.removeMargin()
    imageSlideShowView.viewModel = .init(imgList: self.viewModel.imgURLs)
  }
}

struct NewPlanMainContentsCellViewModel {
  let imgURLs: [String]
  let contents: String
}
