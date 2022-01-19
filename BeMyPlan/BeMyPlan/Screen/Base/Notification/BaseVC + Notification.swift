//
//  BaseVC + Notification.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

enum BaseNotiList{
  case showNotInstallKakaomap
  case moveHomeTab
  case moveTravelSpotTab
  case moveScrapTab
  case moveMyPlanTab
  case moveSettingView
  case moveSettingWithdrawView
  case movePlanPreview // 미리보기 뷰
  case movePlanList // 여행지 목록
  case movePlanDetail // 구매후 뷰
  
  static func makeNotiName(list : BaseNotiList) -> NSNotification.Name{
    return Notification.Name(String(describing: list))
  }
  
}

extension BaseVC{
  func addObservers(){
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .showNotInstallKakaomap)) { _ in
      self.makeAlert(alertCase: .simpleAlert, title: "알림", content: I18N.Alert.notInstallKakaomap)
    }
    
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .moveSettingView)) { _ in
      guard let settingVC = UIStoryboard.list(.myPlan).instantiateViewController(withIdentifier: MyPlanSettingVC.className) as? MyPlanSettingVC else {return}
      self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .moveSettingWithdrawView)) { _ in
      guard let withdrawVC = UIStoryboard.list(.myPlan).instantiateViewController(withIdentifier: MyPlanWithdrawVC.className) as? MyPlanWithdrawVC else {return}
      self.navigationController?.pushViewController(withdrawVC, animated: true)
    }
    
    // Home
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .movePlanPreview)) { _ in
      guard let previewVC = UIStoryboard.list(.planPreview).instantiateViewController(withIdentifier: PlanPreviewVC.className) as? PlanPreviewVC else {return}
      self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .movePlanDetail)) { _ in
      guard let previewVC = UIStoryboard.list(.planDetail).instantiateViewController(withIdentifier: PlanDetailVC.className) as? PlanDetailVC else {return}
      self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .movePlanList)) { _ in
      guard let spotlistVC = UIStoryboard.list(.travelSpot).instantiateViewController(withIdentifier: TravelSpotDetailVC.className) as? TravelSpotDetailVC else {return}
      self.navigationController?.pushViewController(spotlistVC, animated: true)
    }
    
    /**
    hello my name is hyunju An
    whats your name???
    DDogak DDogak
     */
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .moveHomeTab)) { _ in
      self.tabClicked(index: .home)
    }
    
  }
}
