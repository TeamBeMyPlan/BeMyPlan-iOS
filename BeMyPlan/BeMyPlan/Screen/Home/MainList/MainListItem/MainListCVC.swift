//
//  MainListCVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/07.
//

import UIKit
import Kingfisher
import SkeletonView

class MainListCVC: UICollectionViewCell,UICollectionViewRegisterable {
  static var isFromNib: Bool = true
  @IBOutlet private var mainListImageView: UIImageView!
  @IBOutlet private var mainListTitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureSkeleton()
    setUI()
  }
  
  // MARK: - Custom Method
  private func configureSkeleton() {
    
    mainListTitle.layer.masksToBounds = true
    mainListTitle.skeletonCornerRadius = 5

    mainListImageView.layer.masksToBounds = true
    mainListImageView.skeletonCornerRadius = 5
    
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    mainListImageView
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    mainListTitle
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
  }
  
  private func setUI(){
    mainListImageView.layer.cornerRadius = 5
  }
  
  func setData(appData: HomeListDataGettable.Item){
    mainListTitle.text = appData.title
    mainListTitle.hideSkeleton()
    
    mainListImageView.setImage(with: appData.thumbnailURL) { _ in
      self.mainListImageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.75))
      self.mainListImageView.layer.cornerRadius = 5
      self.mainListImageView.layoutIfNeeded()
    
    }

    }
  
}
