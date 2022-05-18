//
//  TravelSpotCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/07.
//

import UIKit
import SkeletonView

class TravelSpotCVC: UICollectionViewCell {
  
  static let identifier = "TravelSpotCVC"
  
  @IBOutlet var locationImageView: UIImageView!
  @IBOutlet var lockImageView: UIImageView!{didSet{
    lockImageView.alpha = 0
  }}
  @IBOutlet var locationLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureSkeletonAnimation()
    setUIs()
  }
  
  private func configureSkeletonAnimation() {
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    locationImageView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    lockImageView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey05,secondaryColor: .grey07), animation: animation)
  }
  
  private func setUIs() {
    locationImageView.layer.cornerRadius = 5
    lockImageView.layer.cornerRadius = 5
    locationImageView.contentMode = .scaleAspectFill
  }
  
  public func setData(data: TravelSpotDataGettable){
    locationImageView.setImage(with: data.photoURL) { _ in
      self.locationImageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
      self.lockImageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
      UIView.animate(withDuration: 0.5) {
        if data.isActivated == false{
          self.lockImageView.alpha = 1
        }
      }
    }
    locationLabel.text = data.name
  }
  
}
