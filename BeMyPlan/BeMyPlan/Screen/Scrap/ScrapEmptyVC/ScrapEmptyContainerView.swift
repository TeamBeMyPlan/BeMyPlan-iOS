//
//  ScrapEmptyContainerView.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit
import Moya
import SkeletonView

class ScrapEmptyContainerView: XibView {
  
  var contentDataList: [HomeListDataGettable.Item] = [] {
    didSet{
      contentCV.reloadData()
    }
  }
  private var userId: Int = 3
  
  @IBOutlet var emptyImage: UIImageView!
  @IBOutlet var emptyLabel: UILabel!
  @IBOutlet var contentCV: UICollectionView!
  
  @IBOutlet var emptyViewWidth: NSLayoutConstraint!
  @IBOutlet var emptyViewHeight: NSLayoutConstraint!
  @IBOutlet var collectionViewHeight: NSLayoutConstraint!
  @IBOutlet var collectionViewBottom: NSLayoutConstraint!
  @IBOutlet var titleLabelLeft: NSLayoutConstraint!
  @IBOutlet var emptyImageY: NSLayoutConstraint!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUIs()
    registerCells()
    setDelegate()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUIs()
    registerCells()
    setDelegate()
  }
  
  private func registerCells() {
    ScrapEmptyCotainerCVC.register(target: contentCV)
  }
  
  private func setUIs() {
    let width = screenWidth * (88/375)
    emptyViewWidth.constant = width
    emptyViewHeight.constant = width

    let collectionViewHeightValue = screenWidth * (212/375)
    collectionViewHeight.constant = collectionViewHeightValue
    
    let collectionViewBottomValue = screenHeight * (30/812)
    collectionViewBottom.constant = collectionViewBottomValue
    
    let titleLabelLeftValue = screenWidth * (24/375)
    titleLabelLeft.constant = titleLabelLeftValue
  
    let emptyImageYValue = screenHeight * (-37/812)
    emptyImageY.constant = emptyImageYValue
  }
  
  private func setDelegate() {
    contentCV.dataSource = self
    contentCV.delegate = self
    contentCV.isSkeletonable = true
  }
  
}

extension ScrapEmptyContainerView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return contentDataList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrapEmptyCotainerCVC.className, for: indexPath) as? ScrapEmptyCotainerCVC else {return UICollectionViewCell()}
    cell.setData(data: contentDataList[indexPath.row])
    
    return cell
  }
}

extension ScrapEmptyContainerView : UICollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickTravelPlan(source: .scrapRecommendView,
                                                                    postIdx:  String(contentDataList[indexPath.row].planID)))
    let stateModel = PlanPreviewStateModel(scrapState: contentDataList[indexPath.row].scrapStatus,
                                           planId: contentDataList[indexPath.row].planID,
                                           isPurchased: contentDataList[indexPath.row].orderStatus)
    postObserverAction(.movePlanPreview,object: stateModel)
  }
}

extension ScrapEmptyContainerView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = screenWidth * (160/375)
    let cellHeight = screenWidth * (212/375)
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let inset = screenWidth * (24/375)
    return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 12
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 12
  }
}
