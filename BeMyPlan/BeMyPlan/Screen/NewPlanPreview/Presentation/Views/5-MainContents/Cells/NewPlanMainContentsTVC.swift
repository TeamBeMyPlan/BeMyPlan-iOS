//
//  NewPlanMainContentsTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/07/04.
//

import UIKit

class NewPlanMainContentsTVC: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
  var viewModel: NewPlanMainContentsCellViewModel! {didSet {configureUI()}}
  
  @IBOutlet var imageSlideShowView: ImageSlideShow!
  @IBOutlet var contentTextView: UITextView!
}

extension NewPlanMainContentsTVC {
  private func configureUI() {
    contentTextView.removeMargin()
    imageSlideShowView.viewModel = .init(imgList: self.viewModel.imgURLs)
    
    contentTextView.setTextWithLineHeight(text: self.viewModel.contents, lineHeightMultiple: 1.31)
    contentTextView.font = .systemFont(ofSize: 14)
    contentTextView.textColor = .grey01
    contentTextView.textContainer.lineBreakMode = .byWordWrapping
    contentTextView.text = self.viewModel.contents
  }
}

struct NewPlanMainContentsCellViewModel {
  let imgURLs: [String]
  let contents: String
}
