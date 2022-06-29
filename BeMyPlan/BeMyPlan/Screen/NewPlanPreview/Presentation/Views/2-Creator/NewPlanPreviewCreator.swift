//
//  NewPlanPreviewCreator.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class NewPlanPreviewCreator: XibView{
  var viewModel: NewPlanPreviewCreatorViewModel!
  
  @IBOutlet var userImageView: UIImageView!
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var contentTextView: UITextView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureUI()
  }
}

extension NewPlanPreviewCreator {
  private func configureUI() {
    userImageView.layer.cornerRadius = userImageView.frame.width / 2
    authorLabel.font = .getSpooqaMediumFont(size: 14)
    contentTextView.backgroundColor = .grey06
    contentTextView.layer.cornerRadius = 5
    contentTextView.textContainerInset = UIEdgeInsets.init(top: 21, left: 21, bottom: 21, right: 21)
    
    userImageView.setImage(with: viewModel.profileImgURL)
    authorLabel.text = viewModel.authorName
    descriptionLabel.text = viewModel.authorDescription
    contentTextView.text = viewModel.creatorIntroduce
  }
}

struct NewPlanPreviewCreatorViewModel {
  let profileImgURL: String
  let authorName: String
  let authorDescription: String
  let creatorIntroduce: String
}
