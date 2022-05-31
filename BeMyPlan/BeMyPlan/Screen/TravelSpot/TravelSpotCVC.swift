//
//  TravelSpotCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/07.
//

import UIKit
import SkeletonView

class TravelSpotCVC: UICollectionViewCell,UICollectionViewRegisterable {
    
  static var isFromNib: Bool = true
  @IBOutlet private var locationImageView: UIImageView!
  @IBOutlet var lockImageView: UIImageView!
  @IBOutlet private var locationLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureSkeletonAnimation()
    setUIs()
  }
  
  private func configureSkeletonAnimation() {
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    locationImageView.layer.masksToBounds = true
    locationImageView.clipsToBounds = true
//    locationImageView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey05,secondaryColor: .grey07), animation: animation)
  }
  
  private func setUIs() {
    locationImageView.layer.cornerRadius = 5
    lockImageView.layer.cornerRadius = 5
  }
  
  public func setData(data: TravelSpotDataGettable){

    
    
    locationImageView.setImage(with: data.photoURL) { _ in
      self.lockImageView.isHidden = !data.isActivated
      self.locationImageView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.5))
      self.lockImageView.layer.cornerRadius = 5
      self.locationImageView.layer.cornerRadius = 5
    }
    locationLabel.text = data.name
  }
  
}
