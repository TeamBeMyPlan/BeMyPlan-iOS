//
//  NewPlanPreviewHeader.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class NewPlanPreviewHeader: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
  var viewModel: NewPlanPreviewHeaderViewModel!
  var currentIndex = 0 { didSet{ setImageContainerViewUI() }}
  
  @IBOutlet var imageContainerView: ImageContainerView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var addressLabel: UILabel!
  @IBOutlet var hashtagContainerView: HashtagContainerView!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var iconContainerView: PreviewIconContainerView!
  @IBOutlet var informationButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    addButtonAction()
  }
}

extension NewPlanPreviewHeader {
  internal func setHeaderData() {
    configureUI()
    setImageContainerViewUI()
  }
  
  private func configureUI() {
    titleLabel.text = viewModel.title
    addressLabel.text = viewModel.address
    hashtagContainerView.viewModel = .init(hashtagList: viewModel.hashtag)

    priceLabel.text = viewModel.price
    iconContainerView.setIconData(iconData: viewModel.iconData)
    iconContainerView.layer.cornerRadius = 5
    iconContainerView.layer.borderColor = UIColor.grey04.cgColor
    iconContainerView.layer.borderWidth = 1
  }
  
  private func setImageContainerViewUI() {
    imageContainerView.viewModel = .init(imgList: viewModel.imgList)
  }
  
  private func addButtonAction() {
    informationButton.press {
      self.postObserverAction(.informationButtonClicked)
    }
  }
}

struct NewPlanPreviewHeaderViewModel {
  let imgList: [String]
  let title: String
  let address: String
  let hashtag: [String]
  let price: String
  let iconData: PlanPreview.IconData
}
