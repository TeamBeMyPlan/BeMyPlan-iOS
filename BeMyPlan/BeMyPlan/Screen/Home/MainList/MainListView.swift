//
//  MainListView.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit

class MainListView: UIView {

  // MARK: - Vars & Lets Part
  var mainListDataList: [MainListData] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
    initMainListDataList()
    registerCVC()
    setMainListCV()
  }
    
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
    initMainListDataList()
    registerCVC()
    setMainListCV()
  }

  // MARK: - UI Component Part
  @IBOutlet var mainListCategotyLabel: UILabel!
  @IBOutlet var mainListCV: UICollectionView!
  
  @IBOutlet var mainListCVCHeightConstraint: NSLayoutConstraint!{
    didSet {
      let screenWidth = UIScreen.main.bounds.width
      let cellWidth = screenWidth * (160/375)
      let cellHeight = cellWidth * (208/160)
      mainListCVCHeightConstraint.constant = cellHeight
    }
  }
  
  // MARK: - @IBAction
  @IBAction func touchUpToGoGallery(_ sender: Any) {
  }
  
  // MARK: - Custom Method Part
  private func setMainListCV(){

    let screenWidth = UIScreen.main.bounds.width
    let cellWidth = (160/375) * screenWidth
    let cellHeight = cellWidth * (208/160)

    let insetX = (20/375) * screenWidth
    let layout = mainListCV.collectionViewLayout as! UICollectionViewFlowLayout

    layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    layout.minimumLineSpacing = 12

    layout.scrollDirection = .horizontal
    mainListCV.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
    mainListCV.decelerationRate = .fast

  }
  
  func registerCVC() {
    mainListCV.dataSource = self
    mainListCV.delegate = self
    
    let mainListCVC = UINib(nibName: MainListCVC.identifier, bundle: nil)
    mainListCV.register(mainListCVC, forCellWithReuseIdentifier: MainListCVC.identifier)
  }
  
  func initMainListDataList(){
    mainListDataList.append(contentsOf: [
      MainListData(image: "mainlist1", title: "푸드파이터들을 위한 찐먹킷리스트투어"),
      MainListData(image: "mainlist2", title: "부모님과 함께하는 3박4일 제주 서부 여행"),
      MainListData(image: "mainlist1", title: "푸드파이터들을 위한 찐먹킷리스트투어"),
      MainListData(image: "mainlist2", title: "부모님과 함께하는 3박4일 제주 서부 여행")
    ])
  }
  
}

// MARK: - Extension Part
extension MainListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mainListDataList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainListCVC.identifier, for: indexPath) as? MainListCVC else {return UICollectionViewCell()}
    
    cell.setData(appData: mainListDataList[indexPath.row])
    return cell
  }
}

extension MainListView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let screenWidth = UIScreen.main.bounds.width
//    let cellWidth = screenWidth * (160/375)
//    let cellHeight = cellWidth * (208/160)
//    return CGSize(width: cellWidth, height: cellHeight)
    return CGSize(width:160, height:208)
  }
  
  //주석
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 8)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    12
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    12
  }
}


extension MainListView : UIScrollViewDelegate {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//    let page = Int(targetContentOffset.pointee.x / self.frame.width)
    
    //item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 결정
    //160, 12
    let layout = mainListCV.collectionViewLayout as! UICollectionViewFlowLayout
    let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
    
    //targetContentOffset을 이용하여 x좌표가 얼마나 이동했는지 확인
    //이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될것인지 값 설정
    var offSet = targetContentOffset.pointee
    let index = (offSet.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
    let roundedIndex = round(index)
    
    //위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
    offSet = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
                     y: -scrollView.contentInset.top)
    targetContentOffset.pointee = offSet
//    self.pageControl.currentPage = Int(roundedIndex)ㄴ
  }
  
}


