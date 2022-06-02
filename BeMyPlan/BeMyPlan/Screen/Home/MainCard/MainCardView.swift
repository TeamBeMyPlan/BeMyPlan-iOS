//
//  MainCardView.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit
import Moya
import SkeletonView

class MainCardView: UIView {
  
  // MARK: - Vars & Lets Part
  private var mainCardDataList: [MainCardData] = []
  private var imageList : [UIImage] = []
  var popularList: [HomeListDataGettable.Item] = []
  
  // MARK: - Life Cycle Part
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
    registerCVC()
    setMainCardCV()
    getCardData()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
    registerCVC()
    setMainCardCV()
    getCardData()
  }
  
  // MARK: - UI Component Part
  @IBOutlet var userMainLabel: UILabel!
  @IBOutlet var mainCardCV: UICollectionView! { didSet{
  }}
  
  @IBOutlet var mainCardCVCHeightConstraint: NSLayoutConstraint!{
    didSet {
      let screenWidth = UIScreen.main.bounds.width
      let cellWidth = screenWidth * (327/375)
      let cellHeight = cellWidth * (435/327)
      mainCardCVCHeightConstraint.constant = cellHeight
    }
  }
  
  // MARK: - Custom Method Part
  private func setMainCardCV(){
    
    let layout = MainCardCarouselLayout()
    
    let cellWidth = (327/375) * screenWidth
    let cellHeight = cellWidth * (435/327)
    
    //sideItemScale
    layout.sideItemScale = 310/327
    layout.spacing = 6
    layout.sideItemAlpha = 0.5
    
    layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    layout.minimumInteritemSpacing = 0
    
    mainCardCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    mainCardCV.decelerationRate = .fast
    mainCardCV.collectionViewLayout = layout
  }
  
  func registerCVC() {
    mainCardCV.dataSource = self
    mainCardCV.delegate = self
    mainCardCV.isSkeletonable = true
    
    let mainCardCVC = UINib(nibName: MainCardCVC.className, bundle: nil)
    mainCardCV.register(mainCardCVC, forCellWithReuseIdentifier: MainCardCVC.className)
    
  }
  
  private func setSkeletonOptions(){
    mainCardCV.isSkeletonable = true
  }
  
  private func getCardData() {
    
    BaseService.default.getHomeOrderSortList { result in
      result.success { entity in
        guard let entity = entity else { return }
        self.popularList = entity.contents
        self.mainCardCV.reloadData()
      }
    }
  }
  
}

// MARK: - Extension Part

extension MainCardView : SkeletonCollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickTravelPlan(source: .homeView,
                                                                    postIdx:  String(popularList[indexPath.row].planID)))
    let stateModel = PlanPreviewStateModel(scrapState: popularList[indexPath.row].scrapStatus,
                                           planId: popularList[indexPath.row].planID)
    postObserverAction(.movePlanPreview,object: stateModel)
  }
}

extension MainCardView: SkeletonCollectionViewDataSource {
  func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return MainCardCVC.className
  }
  func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return popularList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard popularList.count >= indexPath.row + 1 else {return UICollectionViewCell()}
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCardCVC.className, for: indexPath) as? MainCardCVC else {return UICollectionViewCell()}
    cell.layer.cornerRadius = 5
    cell.layer.masksToBounds = false
    cell.clipsToBounds = false
    cell.setData(appData: popularList[indexPath.row])
    return cell
  }
}

extension MainCardView: UICollectionViewDelegateFlowLayout {
  
}
