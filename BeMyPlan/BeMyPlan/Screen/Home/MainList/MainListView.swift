//
//  MainListView.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit

enum MainListViewType{
  case editorRecommend
  case recently
  
}

class MainListView: UIView {

  // MARK: - Vars & Lets Part
  var mainListDataList: [MainListData] = []
  var type : MainListViewType = .recently
  private var currentIndex : CGFloat = 0

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
    initMainListDataList()
    registerCVC()
    setTitle()
    setMainListCV()
  }
    
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
    initMainListDataList()
    registerCVC()
    setTitle()
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
  
  private func setTitle(){
    mainListCategotyLabel.text = (type == .recently ? "최신~" : "에디터~")
  }
  
  
  private func setMainListCV(){

    let screenWidth = UIScreen.main.bounds.width
//    let cellWidth = (160/375) * screenWidth
//    let cellHeight = cellWidth * (208/160)
//
//    let insetX = (20/375) * screenWidth
    
    let cellWidth = 160
    let cellHeight = 208
    let insetX : CGFloat = 24
    
    let layout = mainListCV.collectionViewLayout as! UICollectionViewFlowLayout

    layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    layout.minimumLineSpacing = 12
    layout.minimumInteritemSpacing = 12

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
      MainListData(image: "mainlist2", title: "부모님과 함께하는 3박4일 제주 서부 여행"),
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

}


extension MainListView : UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print("CURRENt SCROLl pOINT",scrollView.contentOffset.x)
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


