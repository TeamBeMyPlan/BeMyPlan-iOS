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
  private var postId: Int?
  private var scrapState: Bool = false { didSet { setScrapImageState() }}
  
  @IBOutlet private var contentImage: UIImageView!
  @IBOutlet private var scrapBtn: UIButton!
  @IBOutlet private var scrapImage: UIImageView!
  @IBOutlet private var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUIs()
  }
  
  @IBAction func scrapBtnTapped(_ sender: Any) {
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
    scrapImage.image = scrapState ? ImageLiterals.Scrap.scrapFIconFilled : ImageLiterals.Scrap.scrapIconNotFilled
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
    postId = data.planID
    scrapState = data.scrapStatus
    contentImage.setImage(with: data.thumbnailURL) { _ in
      self.contentImage.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.75))
      self.scrapBtn.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.75))
      self.contentImage.layer.cornerRadius = 5
      self.contentImage.layoutIfNeeded()
    }
  }
}

struct ScrapRequestDTO {
  let planID: Int
  let scrapState: Bool
}
