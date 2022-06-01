//
//  ScrapContainerCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit
import SkeletonView

class ScrapContainerCVC: UICollectionViewCell, UICollectionViewRegisterable {
  static var isFromNib: Bool = true
  public var scrapBtnClicked: ((Int) -> ())?
  private var postId:Int?
  
  @IBOutlet private var contentImage: UIImageView!
  @IBOutlet private var scrapBtn: UIButton!
  @IBOutlet private var scrapImage: UIImageView!
  @IBOutlet private var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUIs()
    configureSkeleton()
  }
  
  @IBAction func scrapBtnTapped(_ sender: Any) {
    guard let idx = postId else { return }
    if let scrapBtnClicked = scrapBtnClicked {
      scrapBtnClicked(idx)
      toggleScrapImage()
    }
  }
  
  private func toggleScrapImage() {
    if scrapImage.image == UIImage(named: "icnScrapWhite"){
      scrapImage.image = UIImage(named: "icnNotScrapWhite")
    } else {
      scrapImage.image = UIImage(named: "icnScrapWhite")
    }
  }
  
  private func configureSkeleton() {
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    scrapBtn
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    contentImage
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    titleLabel
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
  }
  
  private func setUIs() {
    contentImage.layer.cornerRadius = 5
    contentImage.contentMode = .scaleAspectFill
  }
  
  func setData(data: PlanContent) {
    titleLabel.text = data.title
    titleLabel.hideSkeleton()
    contentImage.setImage(with: data.thumbnailURL) { _ in
      self.contentImage.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.75))
      self.scrapBtn.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.75))
      self.contentImage.layer.cornerRadius = 5
      self.contentImage.layoutIfNeeded()
    }
  }
  
}
