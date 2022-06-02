//
//  TravelSpotDetailTVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/07.
//

import UIKit
import Moya
import SkeletonView
import Kingfisher

class TravelSpotDetailTVC: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
  private var postId: Int?
  private var userId:Int = 1
  private var scrapState: Bool = false { didSet { setScrapImageState() }}

  @IBOutlet var contentImage: UIImageView!
  @IBOutlet private var nickNameLabel: UILabel!
  @IBOutlet private var titleTextView: UITextView!
  @IBOutlet private var scrapBtn: UIButton!
  @IBOutlet private var scrapImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    contentImage.image = nil
    setUIs()
    configureSkeleton()
  }
  
  override func prepareForReuse() {
    contentImage.image = nil
    contentImage.kf.cancelDownloadTask() // first, cancel currenct download task
    contentImage.setImage(with: "")
    configureSkeleton()
  }
  
  
  @IBAction func scrapButtonClicked(_ sender: Any) {
    makeVibrate()
    postScrapAction()
    scrapState.toggle()
  }
  
  private func setUIs() {
    titleTextView.textContainer.maximumNumberOfLines = 2
    titleTextView.textContainerInset = .zero
    titleTextView.textContainer.lineFragmentPadding = .zero
    titleTextView.textContainer.lineBreakMode = .byTruncatingTail
    contentImage.layer.cornerRadius = 5
  }
  
  private func setScrapImageState() {
    scrapImage.image = scrapState ? ImageLiterals.Scrap.scrapFIconFilled : ImageLiterals.Scrap.scrapIconNotFilled
  }
  
  private func postScrapAction() {
    guard let postId = postId else { return }
    let dto = ScrapRequestDTO(planID: postId,
                              scrapState: scrapState)
    postObserverAction(.scrapButtonClicked, object: dto)
  }
  
  private func configureSkeleton() {
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    contentImage
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    nickNameLabel
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
    titleTextView
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
  }
  
  public func setData(data: HomeListDataGettable.Item){
    contentImage.image = nil
    titleTextView.text = data.title
    nickNameLabel.text = data.user.nickname
    postId = data.planID
    scrapState = data.scrapStatus
    
    titleTextView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.75))
    nickNameLabel.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.75))
    
    contentImage.setImage(with: data.thumbnailURL) { _ in
      self.contentImage.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0))
      self.contentImage.layer.cornerRadius = 5
      self.contentImage.layoutIfNeeded()
    }
  }
}

