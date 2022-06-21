//
//  MyPlanBuyContentCVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit
import SkeletonView
import Kingfisher

class MyPlanBuyContentCVC: UICollectionViewCell {
  
  
  private var postId: Int?
  private var scrapState: Bool = false { didSet { setScrapImageState() }}
  
  @IBOutlet var contentImageView : UIImageView!
  @IBOutlet var titleLabel : UILabel!
  @IBOutlet var scrapImageView: UIImageView!
  
  override func awakeFromNib() {
    configureSkeleton()
  }
  
  override func prepareForReuse() {
    contentImageView.kf.cancelDownloadTask()
    contentImageView.image = nil
    configureSkeleton()
  }
  
  @IBAction func scrapButtonClicked(_ sender: Any) {
    makeVibrate()
    postScrapAction()
    scrapState.toggle()
  }
  
  private func postScrapAction() {
    guard let postId = postId else { return }
    let dto = ScrapRequestDTO(planID: postId,
                              scrapState: scrapState)
    postObserverAction(.scrapButtonClicked, object: dto)
  }
  
  private func setScrapImageState() {
    scrapImageView.image = scrapState ? ImageLiterals.Scrap.scrapFIconFilled : ImageLiterals.Scrap.scrapIconNotFilled
  }
  
  private func configureSkeleton() {
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    scrapImageView
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    contentImageView
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    titleLabel
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
  }

  func setData(data: PlanContent) {
    titleLabel.text = data.title
    titleLabel.hideSkeleton()
    postId = data.planID
    scrapState = data.scrapStatus
    contentImageView.setImage(with: data.thumbnailURL) { _ in
      self.contentImageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.75))
      self.scrapImageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.75))
      self.contentImageView.layer.cornerRadius = 5
      self.contentImageView.layoutIfNeeded()
    }
  }
}
