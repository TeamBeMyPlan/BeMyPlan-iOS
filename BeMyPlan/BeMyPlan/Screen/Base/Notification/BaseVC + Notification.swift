//
//  BaseVC + Notification.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

enum BaseNotiList{
  case copyComplete
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
  
  case showNetworkError
  case showIndicator
  case hideIndicator
  
  static func makeNotiName(list : BaseNotiList) -> NSNotification.Name{
    return Notification.Name(String(describing: list))
  }
  
}

extension BaseVC{
  func addObservers(){
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .showIndicator)) { _ in
      
      guard let indicatorVC = UIStoryboard.list(.indicator).instantiateViewController(withIdentifier: IndicatorVC.className) as? IndicatorVC else {return}
      indicatorVC.modalTransitionStyle = .crossDissolve
      indicatorVC.modalPresentationStyle = .overCurrentContext
      self.present(indicatorVC, animated: true, completion: nil)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .hideIndicator)) { _ in
      NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "indicatorComplete"), object: nil)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .showNetworkError)) { _ in
      self.makeAlert(alertCase: .simpleAlert, title: I18N.Alert.error, content: I18N.Alert.networkError)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .showNotInstallKakaomap)) { _ in
      self.makeAlert(alertCase: .simpleAlert, title: I18N.Alert.alarm, content: I18N.Alert.notInstallKakaomap)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .copyComplete)) { noti in
      self.makeAlert(alertCase: .simpleAlert, title: I18N.Alert.alarm, content: I18N.Alert.copyComplete)
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
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .movePlanPreview)) { noti in
      guard let previewVC = UIStoryboard.list(.planPreview).instantiateViewController(withIdentifier: PlanPreviewVC.className) as? PlanPreviewVC else {return}
      if let index = noti.object as? Int{
        previewVC.idx = index
      }
      self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .movePlanDetail)) { noti in
      guard let previewVC = UIStoryboard.list(.planDetail).instantiateViewController(withIdentifier: PlanDetailVC.className) as? PlanDetailVC else {return}
      if let index = noti.object as? Int{
        previewVC.postIdx = index
      }
      self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .movePlanList)) { noti in
      guard let spotlistVC = UIStoryboard.list(.travelSpot).instantiateViewController(withIdentifier: TravelSpotDetailVC.className) as? TravelSpotDetailVC else {return}
      if let notiIndex = noti.object as? Int {
        spotlistVC.areaId = notiIndex
      }
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
