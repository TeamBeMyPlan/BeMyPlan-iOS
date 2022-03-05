//
//  ScrapContainerView.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit
import PanModal
import Moya
import SkeletonView

class ScrapContainerView: XibView {
  
  private var scrapDataList: [ScrapItem] = []
  var postId: Int = 0
  var scrapBtnData: Bool = true

  @IBOutlet var contentCV: UICollectionView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    setAll()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setAll()
  }
  
  @IBAction func filterBtn(_ sender: Any) {
    postObserverAction(.filterBottomSheet)
  }
  
  private func setAll() {
    setDelegate()
    registerCells()
    setSkeletonView()
    fetchScrapItemList()
  }
  
  private func registerCells() {
    ScrapContainerCVC.register(target: contentCV)
  }
  
  private func setSkeletonView(){
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    contentCV.isSkeletonable = true
    contentCV.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation, transition: .crossDissolve(1.0))
  }
  
  private func setDelegate() {
    contentCV.dataSource = self
    contentCV.delegate = self
  }
  
  private func fetchScrapItemList() {
    BaseService.default.getScrapList(page: 0, pageSize: 5, sort: "created_at") { result in
      result.success { [weak self] data in
        self?.scrapDataList = []
        if let testedData = data {
          self?.scrapDataList = testedData.items
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 0.5){
              self?.contentCV.alpha = 0
            }
            self?.contentCV.hideSkeleton(reloadDataAfter:true, transition: .crossDissolve(1.0))
            self?.contentCV.reloadData()
            UIView.animate(withDuration: 1.0,delay: 0.1) {
              self?.contentCV.alpha = 1
            }
          }

        }
      }.catch { error in
        if let _ = error as? MoyaError {
        }
      }
    }
  }
  
  private func scrapBtnAPI() {
    BaseService.default.postScrapBtnTapped(postId: postId) { result in
      result.success { data in
        if let testedData = data {
          self.scrapBtnData = testedData.scrapped
        }
      }.catch { error in
        if let err = error as? MoyaError {
          dump(err)
        }
      }
    }
  }
}

extension ScrapContainerView: SkeletonCollectionViewDataSource {
  
  func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return ScrapContainerCVC.className
  }
  
  func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return scrapDataList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrapContainerCVC.className, for: indexPath) as? ScrapContainerCVC else {return UICollectionViewCell()
    }
    cell.setData(data: scrapDataList[indexPath.row])
    cell.scrapBtnClicked = { [weak self] post in
      self?.postId = post
      self?.scrapBtnAPI()
    }
    return cell
  }
}

extension ScrapContainerView: SkeletonCollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickTravelPlan(source: .scrapView,
                                                                    postIdx:  String(scrapDataList[indexPath.row].postID)))
    postObserverAction(.movePlanPreview,object: scrapDataList[indexPath.row].postID)
  }
}

extension ScrapContainerView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellHeight = screenWidth * (206/375)
    let cellWidth = screenWidth * (156/375)
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//    let inset = screenWidth * (24/375)
    return UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
     
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
}
