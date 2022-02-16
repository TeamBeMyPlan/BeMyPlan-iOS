//
//  BaseVC + Notification.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

enum BaseNotiList : String{
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
  
  case moveHomeToPlanList
  case moveNicknamePlanList
  
  case showNetworkError
  case showIndicator
  case hideIndicator
  
  case indicatorComplete
  
  //filter
  case filterBottomSheet
  
  //PlanDetail
  case detailFoldComplete
  case planDetailButtonClicked
  case foldStateChanged
  
  static func makeNotiName(list : BaseNotiList) -> NSNotification.Name{
    return Notification.Name(String(describing: list))
  }
  
}

extension BaseVC{
  func addObservers(){
    addObserverAction(.showIndicator) { _ in
      let indicatorVC = self.factory.instantiateIndicatorVC()
      self.present(indicatorVC, animated: true, completion: nil)
    }
    
    addObserverAction(.hideIndicator) { _ in
      self.postObserverAction(.indicatorComplete, object: nil)
    }
    
    addObserverAction(.showNetworkError) { _ in
      self.makeAlert(alertCase: .simpleAlert, title: I18N.Alert.error, content: I18N.Alert.networkError)
    }
    
    addObserverAction(.showNotInstallKakaomap) { _ in
      self.makeAlert(alertCase: .simpleAlert, title: I18N.Alert.alarm, content: I18N.Alert.notInstallKakaomap)
    }
    
    addObserverAction(.copyComplete) { noti in
      self.makeAlert(alertCase: .simpleAlert, title: I18N.Alert.alarm, content: I18N.Alert.copyComplete)
    }
    
    addObserverAction(.moveSettingView) { _ in
      let settingVC = self.factory.instantiateMyPlanSettingVC()
      self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    addObserverAction(.moveSettingWithdrawView) { _ in
      let withdrawVC = self.factory.instantiateMyPlanWithdrawVC()
      self.navigationController?.pushViewController(withdrawVC, animated: true)
    }
    
    // Home
    
    addObserverAction(.movePlanPreview) { noti in
      guard let previewVC = UIStoryboard.list(.planPreview).instantiateViewController(withIdentifier: PlanPreviewVC.className) as? PlanPreviewVC else {return}
      if let index = noti.object as? Int{
        previewVC.idx = index
      }
      self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    addObserverAction(.movePlanDetail) { noti in
      guard let previewVC = UIStoryboard.list(.planDetail).instantiateViewController(withIdentifier: PlanDetailVC.className) as? PlanDetailVC else {return}
      if let index = noti.object as? Int{
        previewVC.postIdx = index
      }
      self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
    addObserverAction(.moveHomeToPlanList) { noti in
      if let viewCase = noti.object as? TravelSpotDetailType{
        guard let spotlistVC = UIStoryboard.list(.travelSpot).instantiateViewController(withIdentifier: TravelSpotDetailVC.className) as? TravelSpotDetailVC else {return}
        spotlistVC.type = viewCase
        self.navigationController?.pushViewController(spotlistVC, animated: true)
      }
    }
    
    addObserverAction(.moveNicknamePlanList) { noti in
      if let authData = noti.object as? PlanWriterDataModel{
        guard let spotlistVC = UIStoryboard.list(.travelSpot).instantiateViewController(withIdentifier: TravelSpotDetailVC.className) as? TravelSpotDetailVC else {return}
        spotlistVC.nickname = authData.authorName
        spotlistVC.userId = authData.authorID
        spotlistVC.type = .nickname
        self.navigationController?.pushViewController(spotlistVC, animated: true)
      }
    }
    addObserverAction(.movePlanList) { noti in
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
    
    addObserverAction(.moveHomeTab) { _ in
      self.tabClicked(index: .home)
    }
    
  }
}
