//
//  MainCardView.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit

class MainCardView: UIView {
  
  // MARK: - Vars & Lets Part
  var mainCardDataList: [MainCardData] = []
  
  // MARK: - Life Cycle Part
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
    initMainCardDataList()
    registerCVC()
    setMainCardCV()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
    initMainCardDataList()
    registerCVC()
    setMainCardCV()
  }
  
  // MARK: - UI Component Part
  @IBOutlet var userMainLabel: UILabel!
  @IBOutlet var mainCardCV: UICollectionView!
  
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

    let screenWidth = UIScreen.main.bounds.width
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
    
    let mainCardCVC = UINib(nibName: MainCardCVC.identifier, bundle: nil)
    mainCardCV.register(mainCardCVC, forCellWithReuseIdentifier: MainCardCVC.identifier)
    
  }
  
  func initMainCardDataList(){
    mainCardDataList.append(contentsOf: [
      MainCardData(image: "maincard1", category: "인기여행일정", title: "제주도 & 우도 인생샷 투어"),
      MainCardData(image: "maincard2", category: "인기여행일정", title: "바다와 함께하는 산책 투어"),
      MainCardData(image: "maincard1", category: "인기여행일정", title: "제주도 & 우도 인생샷 투어"),
      MainCardData(image: "maincard2", category: "인기여행일정", title: "바다와 함께하는 산책 투어"),
      MainCardData(image: "maincard1", category: "인기여행일정", title: "제주도 & 우도 인생샷 투어"),
      MainCardData(image: "maincard2", category: "인기여행일정", title: "바다와 함께하는 산책 투어")
    ])
  }
  
}

// MARK: - Extension Part
extension MainCardView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mainCardDataList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCardCVC.identifier, for: indexPath) as? MainCardCVC else {return UICollectionViewCell()}
    
    cell.setData(appData: mainCardDataList[indexPath.row])
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
