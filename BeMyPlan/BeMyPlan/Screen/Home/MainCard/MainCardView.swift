//
//  MainCardView.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit
import Moya
import ListPlaceholder
import SkeletonView

class MainCardView: UIView {
  
  // MARK: - Vars & Lets Part
  private var mainCardDataList: [MainCardData] = []
  var popularList: [HomeListDataGettable.Item] = []
  
  // MARK: - Life Cycle Part
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
//    initMainCardDataList()
    registerCVC()
    setSkeletonAnimation()
    setMainCardCV()
    getCardData()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
//    initMainCardDataList()
    registerCVC()
    setSkeletonAnimation()
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
    
//    let centerItemWidthScale: CGFloat = (327/375) * screenWidth
//    let centerItemHeightScale: CGFloat = 1
    let insetX : CGFloat = 24
    
//    layout.itemSize = CGSize(width: mainCardCV.frame.size.width*centerItemWidthScale, height: mainCardCV.frame.size.height*centerItemHeightScale)
    
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
  
  private func setSkeletonAnimation(){
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)

    self.mainCardCV.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation, transition: .crossDissolve(0.5))
    mainCardCV.showSkeleton()
  }

  private func getCardData(){
    
    BaseService.default.getPopularTravelList { result in
      result.success { list in
        self.popularList = []
        if let popular = list {
          self.popularList = popular
          self.mainCardCV.reloadData()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {

          self.mainCardCV.hideSkeleton(transition: .crossDissolve(2))
        }
 
      }.catch{ error in
          NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .showNetworkError), object: nil)
      }
    }
  }
  
  private func setDuumy(){
    popularList.append(contentsOf: [
      HomeListDataGettable.Item.init(id: 0,
                                     thumbnailURL: "",
                                     title: "",
                                     nickname: ""),
      
      HomeListDataGettable.Item.init(id: 0,
                                     thumbnailURL: "",
                                     title: "",
                                     nickname: ""),
      
      HomeListDataGettable.Item.init(id: 0,
                                     thumbnailURL: "",
                                     title: "",
                                     nickname: ""),
      
      HomeListDataGettable.Item.init(id: 0,
                                     thumbnailURL: "",
                                     title: "",
                                     nickname: "")
    ])
  }
  
//  var id : Int
//  var title : String
//  var photo : String

//  private func fetchEventItemList(){
//    BaseService.default.getEventBannerList { result in
//      result.success{ list in
//        self.imageList = []
//
//        if let banner = list{
//          self.imgList.append(contentsOf: [
//            banner.eventImage1,
//            banner.eventImage2,
//            banner.eventImage3
//          ])
//          print("Banner List",self.imgList)
//          self.eventCV.reloadData()
//        }
//      }.catch{ error in
//        //                dump(error)
//      }
//    }
//  }
  
}

// MARK: - Extension Part

extension MainCardView : SkeletonCollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .movePlanPreview), object: popularList[indexPath.row].id)
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
    cell.layer.masksToBounds = true
    cell.setData(appData: popularList[indexPath.row])
    return cell
  }
}

extension MainCardView: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let screenWidth = UIScreen.main.bounds.width
//    let cellWidth = screenWidth * (327/375)
//    let cellHeight = cellWidth * (435/327)
//    return CGSize(width: cellWidth, height: cellHeight)
//
//  }
//
//  //주석
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//    return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    12
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//    0
//  }
}


extension MainCardView : UIScrollViewDelegate {
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//    let page = Int(targetContentOffset.pointee.x / self.frame.width)
    let layout = mainCardCV.collectionViewLayout as! UICollectionViewFlowLayout
    let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
    
    var offSet = targetContentOffset.pointee
    let index = (offSet.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
    let roundedIndex = round(index)
    
    
    offSet = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
                     y: -scrollView.contentInset.top)
    targetContentOffset.pointee = offSet
//    self.pageControl.currentPage = Int(roundedIndex)
  }
  
}
