//
//  NewPlanPreviewHeader.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class NewPlanPreviewHeader: XibView{
  var viewModel: NewPlanPreviewHeaderViewModel!
  var currentIndex = 0 { didSet{ setImageContainerViewUI() }}
  
  @IBOutlet var imageContainerView: ImageContainerView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var addressLabel: UILabel!
  @IBOutlet var hashtagContainerView: HashtagContainerView!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var iconContainerView: PreviewIconContainerView!
  @IBOutlet var informationButton: UIButton!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addButtonAction()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addButtonAction()
  }
}

extension NewPlanPreviewHeader {
  private func configureUI() {
    titleLabel.text = viewModel.title
    addressLabel.text = viewModel.address
    hashtagContainerView.viewModel = .init(hashtagList: viewModel.hashtag)
    priceLabel.text = viewModel.price
    iconContainerView.setIconData(iconData: viewModel.iconData)
  }
  
  private func setImageContainerViewUI() {
    imageContainerView.viewModel = .init(currentIndex: 0, imgList: viewModel.imgList)
  }
  
  private func addButtonAction() {
    informationButton.press {
      // FIXME: - 나중에 information 눌렸을 때 액션 처리 여기서
    }
  }
}

struct NewPlanPreviewHeaderViewModel {
  let imgList: [String] = []
  let title: String
  let address: String
  let hashtag: [String]
  let price: String
  let iconData: PlanPreview.IconData
}
