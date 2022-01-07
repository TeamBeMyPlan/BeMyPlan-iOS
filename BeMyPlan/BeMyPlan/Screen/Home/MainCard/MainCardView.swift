//
//  MainCardView.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit

class MainCardView: UIView {
  
  // MARK: - Vars & Lets Part
  private var currentIndex : CGFloat = 0
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

    let screenWidth = UIScreen.main.bounds.width
    let cellWidth = (327/375) * screenWidth
    let cellHeight = cellWidth * (435/327)

    let insetX = (20/375) * screenWidth
    let layout = mainCardCV.collectionViewLayout as! UICollectionViewFlowLayout

    layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    layout.minimumLineSpacing = 12

    layout.scrollDirection = .horizontal
    mainCardCV.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
    mainCardCV.decelerationRate = .fast

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
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let screenWidth = UIScreen.main.bounds.width
//    let cellWidth = screenWidth * (327/375)
//    let cellHeight = cellWidth * (435/327)
//    return CGSize(width: cellWidth, height: cellHeight)
    return CGSize(width:327, height:435)
  }
  
  //주석
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    12
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    12
  }
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
