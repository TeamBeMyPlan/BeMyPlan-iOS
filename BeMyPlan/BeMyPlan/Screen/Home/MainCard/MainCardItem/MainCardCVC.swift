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
    setUI()
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    mainCardImageView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation, transition: .crossDissolve(1))
    mainCardTitle.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey05,secondaryColor: .grey07), animation: animation, transition: .crossDissolve(1))
    mainCardCategory.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey05,secondaryColor: .grey07), animation: animation, transition: .crossDissolve(1))
  }
  
  // MARK: - Custom Method
  func setUI(){
    contentView.layer.masksToBounds = false
    contentView.layer.cornerRadius = 5
    mainCardImageLayer.layer.cornerRadius = 5
    //이미지를 radius 적용안 한것을 줄 경우
    mainCardImageView.layer.cornerRadius = 5
    
  }
  
  func setData(appData: HomeListDataGettable.Item){
    mainCardImageView.setImage(with: appData.thumbnailURL, placeholder: "") { _ in
      UIView.animate(withDuration: 0.5) {
        self.mainCardImageLayer.alpha = 1
      }
      self.mainCardImageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(1))
      self.mainCardTitle.hideSkeleton()
      self.mainCardCategory.hideSkeleton()
    }
//    mainCardCategory.text = appData.category
    mainCardTitle.text = appData.title
  }
}
