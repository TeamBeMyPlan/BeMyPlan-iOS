//
//  ScrapEmptyCotainerCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit
import SkeletonView

class ScrapEmptyCotainerCVC: UICollectionViewCell,UICollectionViewRegisterable {
  
  static var isFromNib: Bool = true
  @IBOutlet private var contentImage: UIImageView!
  @IBOutlet private var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureSkeleton()
    setUIs()
  }
  
  private func configureSkeleton() {
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    contentImage
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    titleLabel
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
  }
  
  private func setUIs() {
    contentImage.layer.cornerRadius = 5
    titleLabel.font = .boldSystemFont(ofSize: 14)
    titleLabel.textColor = .init(red: 49/255, green: 55/255, blue: 64/255, alpha: 1)
  }
  
  public func setData(data: HomeListDataGettable.Item) {
    titleLabel.setTextWithLineHeightMultiple(text: data.title, lineHeightMultiple: 1.19)
    titleLabel.hideSkeleton()
    contentImage.setImage(with: data.thumbnailURL) { _ in
      self.contentImage.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.75))
      self.contentImage.layer.cornerRadius = 5
      self.contentImage.layoutIfNeeded()
    }
  }
}
