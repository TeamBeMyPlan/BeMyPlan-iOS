//
//  MainListView.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit
import Moya

enum MainListViewType{
  case editorRecommend
  case recently
}

class MainListView: UIView {
  
  // MARK: - Vars & Lets Part
  var mainListDataList: [HomeListDataGettable] = [] {
    didSet {
      mainListCV.reloadData()
    }
  }
  
  var type : MainListViewType = .recently {
    didSet {
      //      setTitle()
      type == .recently ? getRecentlyListData() : getSuggestListData()
    }
  }
  
  private var currentIndex : CGFloat = 0
  private var listIndex = 1
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviewFromNib(view: self)
    registerCVC()
    setTitle()
    setMainListCV()
    //    getListData()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubviewFromNib(view: self)
    registerCVC()
    setTitle()
    setMainListCV()
    //    getListData()
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
  
  @IBAction func touchUpToPlanList(_ sender: Any) {
    NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .movePlanList), object: nil)
  }
  
  
  // MARK: - Custom Method Part
  
  private func setTitle(){
    mainListCategotyLabel.text = (type == .recently ? "최신 여행 일정" : "에디터 추천 여행 일정")
  }
  
  
  private func setMainListCV(){
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
    
    let mainListCVC = UINib(nibName: MainListCVC.className, bundle: nil)
    mainListCV.register(mainListCVC, forCellWithReuseIdentifier: MainListCVC.className)
  }
  
  
  //mainListDataList 에 넣기
  private func getRecentlyListData(){
    BaseService.default.getNewTravelList(page: listIndex) { result in
      result.success { [weak self] list in
        self?.mainListDataList.removeAll()
        if let list = list {
          self?.mainListDataList = list
        }
      }.catch{ error in
        dump(error)
      }
    }
  }
  
  
  private func getSuggestListData(){
    BaseService.default.getSuggestTravelList(page: listIndex, sort: "created_at") { result in
      result.success { [weak self] list in
        self?.mainListDataList.removeAll()
        if let list = list {
          self?.mainListDataList = list
        }
      }.catch{ error in
        dump(error)
      }
    }
  }
  
}

// MARK: - Extension Part

extension MainListView : UICollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .movePlanPreview), object: nil)
  }
}

extension MainListView: UICollectionViewDataSource {
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


