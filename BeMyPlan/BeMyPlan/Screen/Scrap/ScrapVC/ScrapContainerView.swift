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
  
  var scrapDataList: [PlanContent] = [] { didSet { contentCV.reloadData() } }
  var postId: Int = 0
  var scrapBtnData: Bool = true

  @IBOutlet private var contentCV: UICollectionView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    setDelegate()
    registerCells()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setDelegate()
    registerCells()
  }
  
  @IBAction func filterBtn(_ sender: Any) {
    postObserverAction(.filterBottomSheet)
  }
  
  private func registerCells() {
    ScrapContainerCVC.register(target: contentCV)
  }
  
  private func setDelegate() {
    contentCV.dataSource = self
    contentCV.delegate = self
    contentCV.isSkeletonable = true
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
    return cell
  }
}

extension ScrapContainerView: SkeletonCollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickTravelPlan(source: .scrapView,
                                                                    postIdx:  String(scrapDataList[indexPath.row].planID)))
    postObserverAction(.movePlanPreview,object: scrapDataList[indexPath.row].planID)
  }
}

extension ScrapContainerView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellHeight = screenWidth * (206/375)
    let cellWidth = screenWidth * (156/375)
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
     
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
}
