//
//  ImageContainerPhotoCell.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/29.
//

import UIKit

class ImageContainerPhotoCell: UICollectionViewCell {
  var viewModel: ImageContainerPhotoCellViewModel! { didSet{ setImage() }}
  @IBOutlet var contentImageView: UIImageView!
}

extension ImageContainerPhotoCell {
  private func setImage() {
    contentImageView.setImage(with: viewModel.imgURL)
  }
}

struct ImageContainerPhotoCellViewModel {
  var imgURL: String
}
