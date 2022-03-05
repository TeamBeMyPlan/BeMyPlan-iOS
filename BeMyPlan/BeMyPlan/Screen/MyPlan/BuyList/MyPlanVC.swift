//
//  MyPlanVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/06.
//

import UIKit
import AVFoundation
import SkeletonView

class MyPlanVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  var buyContentList : [MyPlanData.BuyListData] = []{
    didSet{
      mainContentCV.reloadData()
      setEmptyView()
    }
  }
  
  // MARK: - UI Component Part
  
  @IBOutlet var settingButton: UIButton!
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
    setButtonAction()
  }
  
  override func viewDidLayoutSubviews() {
    setUI()
    setEmptyView()
    setSkeletonOptions()
    fetchBuyList()
  }
  
  // MARK: - Custom Method Part
  
  private func setUI(){
    emptyView.alpha = 0
    mainContentCV.alpha = 1
  }
  
  private func setButtonAction(){
    settingButton.press {
      self.postObserverAction(.moveSettingView)
    }
  }
  
  private func setSkeletonOptions(){
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    mainContentCV.isSkeletonable = true
    mainContentCV.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation, transition: .crossDissolve(2))
  }
  
  private func fetchBuyList(){
    BaseService.default.getOrderList{ result in
      result.success { [weak self] data in
        if let buyList = data{
          self?.buyContentList = buyList.items
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self?.mainContentCV.hideSkeleton(transition: .crossDissolve(0.7))
            UIView.animate(withDuration: 0.5) {
              if self?.buyContentList.count == 0{
                self?.emptyView.alpha = 1
              }
            }
          }
        }
      }.catch { error in
        dump(error)
      }
    }
  }
  
  
  
  private func setEmptyView(){
    emptyViewHeightConstraint.constant = mainContentCV.bounds.height - 224
    emptyView.isHidden = !buyContentList.isEmpty
  }
}
// MARK: - Extension Part
extension MyPlanVC: SkeletonCollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickTravelPlan(source: .myPlanView,
                                                                    postIdx:  String(buyContentList[indexPath.row].id)))
    postObserverAction(.movePlanDetail,object: buyContentList[indexPath.row].id)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: screenWidth, height: 224)
  }
  
}

extension MyPlanVC: SkeletonCollectionViewDataSource{
  func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
    return MyPlanCVUserResuableView.className
  }
  func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return MyPlanBuyContentCVC.className
  }
  func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
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
    contentCell.setContentData(title: buyContentList[indexPath.row].title, imageURL: buyContentList[indexPath.row].thumbnailURL,
                               isScrap: false,
                               postIdx: buyContentList[indexPath.row].id)
    contentCell.scrapClicked = { isScrap,postIdx in
      print("Clicked",isScrap,postIdx)
    }
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
