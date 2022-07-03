//
//  ImageSlideShowCVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/07/04.
//

import UIKit

class ImageSlideShowCVC: UICollectionViewCell, UICollectionViewRegisterable {
  static var isFromNib: Bool = true
  var imageURL: String! { didSet{ setImage() }}
  @IBOutlet var contentImageView: UIImageView!
}

extension ImageSlideShowCVC {
  func setImage() {
    contentImageView.setImage(with: imageURL)
  }
}
