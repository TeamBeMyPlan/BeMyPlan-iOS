//
//  NewPlanPreviewCreator.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

final class NewPlanPreviewCreator: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
  var viewModel: NewPlanPreviewCreatorViewModel! { didSet { configureUI()}}
  
  @IBOutlet var userImageView: UIImageView!
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var contentTextView: UITextView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

extension NewPlanPreviewCreator {
  private func configureUI() {
    userImageView.layer.cornerRadius = userImageView.frame.width / 2
    authorLabel.font = .getSpooqaMediumFont(size: 14)
    contentTextView.backgroundColor = .grey06
    contentTextView.setTextWithLineHeight(text: viewModel.creatorIntroduce, lineHeightMultiple: 1.31)
    contentTextView.layer.cornerRadius = 5
    contentTextView.removeMargin()
    contentTextView.textContainerInset = UIEdgeInsets.init(top: 21, left: 21, bottom: 21, right: 21)
    contentTextView.font = .systemFont(ofSize: 14)
    contentTextView.textColor = .grey01
    contentTextView.textContainer.lineBreakMode = .byWordWrapping
    
    userImageView.setImage(with: viewModel.profileImgURL)
    authorLabel.text = viewModel.authorName
    descriptionLabel.text = viewModel.authorDescription
  }
}

struct NewPlanPreviewCreatorViewModel {
  let profileImgURL: String
  let authorName: String
  let authorDescription: String
  let creatorIntroduce: String
  let authorIdx: Int
}
