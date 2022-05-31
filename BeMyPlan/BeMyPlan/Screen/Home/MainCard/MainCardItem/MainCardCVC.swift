//
//  MainCardCVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit
import Kingfisher
import SkeletonView

class MainCardCVC: UICollectionViewCell {
 
  @IBOutlet var mainCardImageLayer: UIView!{
    didSet{
      mainCardImageLayer.alpha = 0
    }
  }
  @IBOutlet var mainCardImageView: UIImageView!
  @IBOutlet var mainCardCategory: UILabel!
  @IBOutlet var mainCardTitle: UILabel!
  
  // MARK: - Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setSkeletonView()
    self.setUI()

  }
  
  
  // MARK: - Custom Method
  private func setSkeletonView() {
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    mainCardImageView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    mainCardTitle.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey05,secondaryColor: .grey07), animation: animation)
  }
  
  private func setUI(){
    contentView.layer.masksToBounds = false
    contentView.layer.cornerRadius = 5
    mainCardImageLayer.layer.cornerRadius = 5
  }
  
  func setData(appData: HomeListDataGettable.Item) {
    
    mainCardTitle.text = appData.title
    mainCardTitle.hideSkeleton()
    mainCardCategory.hideSkeleton()
    
    mainCardImageView.setImage(with: appData.thumbnailURL) { _ in
      self.mainCardImageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.75))
      self.mainCardImageView.layer.cornerRadius = 5
      self.mainCardImageView.layoutIfNeeded()
    }
  }
}
