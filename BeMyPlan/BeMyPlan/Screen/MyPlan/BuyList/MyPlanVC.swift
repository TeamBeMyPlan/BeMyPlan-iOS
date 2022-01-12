//
//  MyPlanVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/06.
//

import UIKit

class MyPlanVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  var buyContentList : [MyPlanData.BuyList] = [
//    MyPlanData.BuyList.init(imageURL: "", title: "워케이션을 위한 카페투어asdfasdfsadfasfasdfsdafsadfsad", id: 0),
//    MyPlanData.BuyList.init(imageURL: "", title: "27년 제주 토박이의 히든 플레이스 투어 ", id: 0),
//    MyPlanData.BuyList.init(imageURL: "", title: "안녕안녕안녕 워케이션을 위한 카페투어 ", id: 0),
//    MyPlanData.BuyList.init(imageURL: "", title: "푸드파이터들을 위한 찐먹킷리스트 투어", id: 0)
  ]{
    didSet{
      mainContentCV.reloadData()
      setEmptyView()
    }
  }

  // MARK: - UI Component Part

  @IBOutlet var mainContentCV: UICollectionView!{
    didSet{
      mainContentCV.delegate = self
      mainContentCV.dataSource = self
    }
  }
  @IBOutlet var emptyView: MyPlanEmptyBuyListView!
  
  @IBOutlet var emptyViewHeightConstraint: NSLayoutConstraint!
  // MARK: - Life Cycle Part
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  override func viewDidLayoutSubviews() {
    setEmptyView()

  }
    
  // MARK: - Custom Method Part
  
  private func setEmptyView(){
    emptyViewHeightConstraint.constant = mainContentCV.bounds.height - 224
    emptyView.isHidden = !buyContentList.isEmpty
  }
}
// MARK: - Extension Part
extension MyPlanVC :UICollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      return CGSize(width: screenWidth, height: 224)
  }
  
}

extension MyPlanVC : UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return buyContentList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch(kind){
      case UICollectionView.elementKindSectionHeader:
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyPlanCVUserResuableView.className, for: indexPath) as? MyPlanCVUserResuableView else{ return UICollectionReusableView() }
        headerView.setData(nickName: "다운타운베이비", buyCount: buyContentList.count) // 이후 수정필요
        return headerView
      default :
        return UICollectionReusableView()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlanBuyContentCVC.className
                                                               , for: indexPath) as? MyPlanBuyContentCVC else {return UICollectionViewCell() }
    contentCell.setContentata(title: buyContentList[indexPath.row].title, imageURL: buyContentList[indexPath.row].imageURL)
    return contentCell
  }
  
  
}

extension MyPlanVC : UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (screenWidth - 67)/2
    let cellHeight = cellWidth + 50
    return CGSize(width: cellWidth, height: cellHeight)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    19
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    20
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
  }
}
