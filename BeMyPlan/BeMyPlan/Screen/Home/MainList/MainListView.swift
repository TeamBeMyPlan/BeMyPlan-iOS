//
//  MainListView.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit
import Moya
import SkeletonView

enum MainListViewType{
  case editorRecommend
  case recently
}

class MainListView: UIView {
  
  // MARK: - Vars & Lets Part
  var mainListDataList: [HomeListDataGettable.Item] = []
  
  var type : MainListViewType = .recently {
    didSet {
      setTitle()
      type == .recently ? getRecentlyListData() : getSuggestListData()
    }
  }
  
  private var currentIndex : CGFloat = 0
  private var listIndex = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
    registerCVC()
    setTitle()
    setMainListCV()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
    registerCVC()
    setTitle()
    setMainListCV()
  }
  
  // MARK: - UI Component Part
  @IBOutlet private var mainListCategotyLabel: UILabel!
  @IBOutlet private var mainListCV: UICollectionView!
  
  @IBOutlet private var mainListCVCHeightConstraint: NSLayoutConstraint!{
    didSet {
      let screenWidth = UIScreen.main.bounds.width
      let cellWidth = screenWidth * (160/375)
      let cellHeight = cellWidth * (208/160)
      mainListCVCHeightConstraint.constant = cellHeight
    }
  }
  
  // MARK: - @IBAction
  @IBAction private func touchUpToGoGallery(_ sender: Any) {
    
  }
  
  @IBAction private func touchUpToPlanList(_ sender: Any) {
    var detailCase : TravelSpotDetailType = .recently
    if type == .recently {
      detailCase = .recently
      AppLog.log(at: FirebaseAnalyticsProvider.self, .clickHomeRecentPlanList)
    }else {
      detailCase = .bemyPlanRecommend
      AppLog.log(at: FirebaseAnalyticsProvider.self, .clickHomeRecommendPlanList)
    }
    postObserverAction(.moveHomeToPlanList,object: detailCase)
  }
  
  // MARK: - Custom Method Part
  
  private func setTitle(){
    mainListCategotyLabel.text = (type == .recently ? "최신 여행 일정" : "비마플 추천 여행 일정")
  }
  
  private func setMainListCV(){
    
    let cellWidth = 160
    let cellHeight = 208
    let insetX : CGFloat = 24
    
    let layout = mainListCV.collectionViewLayout as! UICollectionViewFlowLayout
    
    layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    layout.minimumLineSpacing = 12
    layout.minimumInteritemSpacing = 12
    
    layout.scrollDirection = .horizontal
    mainListCV.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX + CGFloat(cellWidth))
    mainListCV.decelerationRate = .fast
    
  }
  
  private func registerCVC() {
    mainListCV.dataSource = self
    mainListCV.delegate = self
    mainListCV.isSkeletonable = true
    MainListCVC.register(target: mainListCV)
  }
  
  private func setSkeletonOption() {
    mainListCV.isSkeletonable = true
  }
  
  private func getRecentlyListData(){
    BaseService.default.getHomeRecentSortList { result in
      result.success { [weak self] list in
        guard let list = list else { return }
        self?.mainListDataList = list.contents
        self?.mainListCV.reloadData()
      }.catch { error in
        self.postObserverAction(.showNetworkError,object: nil)
      }
    }
  }

  private func getSuggestListData(){
    BaseService.default.getHomeBemyPlanSortList{ result in
      result.success { [weak self] list in
        guard let list = list else { return }
        self?.mainListDataList = list.contents
        self?.mainListCV.reloadData()
      }.catch { error in
        self.postObserverAction(.showNetworkError,object: nil)
      }
    }
  }
  
}

// MARK: - Extension Part

extension MainListView : SkeletonCollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickTravelPlan(source: .homeView,
                                                                    postIdx:  String(mainListDataList[indexPath.row].planID)))
    postObserverAction(.movePlanPreview,object: mainListDataList[indexPath.row].planID)
  }
}

extension MainListView: SkeletonCollectionViewDataSource {
  func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return MainListCVC.className
  }
  
  func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mainListDataList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainListCVC.className, for: indexPath) as? MainListCVC else {return UICollectionViewCell()}
    
    cell.setData(appData: mainListDataList[indexPath.row])
    return cell
  }
}

extension MainListView: UICollectionViewDelegateFlowLayout {
}

extension MainListView : UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
  }
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    //    let page = Int(targetContentOffset.pointee.x / self.frame.width)
    //
    let layout = self.mainListCV.collectionViewLayout as! UICollectionViewFlowLayout
    let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
    var offset = targetContentOffset.pointee
    let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
    var roundedIndex = round(index)
    
    if scrollView.contentOffset.x > targetContentOffset.pointee.x {
      roundedIndex = floor(index)
    } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
      roundedIndex = ceil(index)
    } else {
      roundedIndex = round(index)
    }
    
    if currentIndex > roundedIndex {
      currentIndex -= 1
      roundedIndex = currentIndex
    } else if currentIndex < roundedIndex {
      currentIndex += 1
      roundedIndex = currentIndex
    }
    
    offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    targetContentOffset.pointee = offset
  }
}
