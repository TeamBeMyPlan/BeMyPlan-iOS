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
  private var isInitial = true
  var buyContentList : [PlanContent] = []{
    didSet{
      setEmptyView()
      mainContentCV.reloadData()
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
    registerObserverActions()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    isInitial = false
  }
  
  // MARK: - Custom Method Part
  
  private func setUI(){
    emptyView.isHidden = true
    mainContentCV.alpha = 1
  }
  
  private func setButtonAction(){
    settingButton.press {
      self.postObserverAction(.moveSettingView)
    }
  }
  
  private func setSkeletonOptions(){
    mainContentCV.isSkeletonable = true
  }
  
  private func fetchBuyList(){
    BaseService.default.getOrderList{ result in
      result.success { [weak self] entity in
        guard let entity = entity else { return }
        self?.buyContentList = entity.contents
        self?.mainContentCV.reloadData()
      }.catch { error in
        self.buyContentList.removeAll()
        dump(error)
      }
    }
  }
  
  private func setEmptyView(){
    emptyViewHeightConstraint.constant = mainContentCV.bounds.height - 224
    emptyView.isHidden = !buyContentList.isEmpty
  }
  
  private func registerObserverActions() {
    addObserverAction(.changeCurrentTab) { [weak self] noti in
      if let index = noti.object as? TabList {
        if index == .myPlan  && self?.isInitial == false {
          self?.fetchBuyList()
        }
      }
    }
    
    addObserverAction(.loginButtonClickedInMyPlan) { _ in
      self.makeAlert(alertCase: .requestAlert, title: "알림", content: "로그인 페이지로 돌아가시겠습니까?") {
        UserDefaults.standard.removeObject(forKey: "userSessionID")
        guard let loginVC = UIStoryboard.list(.login).instantiateViewController(withIdentifier: LoginNC.className) as? LoginNC else {return}
        loginVC.modalPresentationStyle = .fullScreen
        AppLog.log(at: FirebaseAnalyticsProvider.self, .logout)
        self.present(loginVC, animated: false, completion: nil)
      }
    }

  }
}
// MARK: - Extension Part
extension MyPlanVC: SkeletonCollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    makeVibrate()
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickTravelPlan(source: .myPlanView,
                                                                    postIdx:  String(buyContentList[indexPath.row].planID)))
    postObserverAction(.movePlanDetail,object: buyContentList[indexPath.row].planID)
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
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyPlanCVUserResuableView.className, for: indexPath) as?
                MyPlanCVUserResuableView else{ return UICollectionReusableView() }
        if let _ = UserDefaults.standard.string(forKey: "userSessionID") {
          guard let nickname = UserDefaults.standard.string(forKey: "userNickname") else { return headerView }
          headerView.setData(nickName: nickname, buyCount: buyContentList.count) // 이후 수정필요
        } else {
          headerView.setData(nickName: "", buyCount: 0,isGuestMode: true) // 이후 수정필요
        }
        return headerView
      default :
        return UICollectionReusableView()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPlanBuyContentCVC.className
                                                               , for: indexPath) as? MyPlanBuyContentCVC else {return UICollectionViewCell() }
    contentCell.setData(data: buyContentList[indexPath.row])
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
