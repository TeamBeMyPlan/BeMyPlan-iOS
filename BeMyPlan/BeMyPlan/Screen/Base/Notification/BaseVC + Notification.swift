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
  case changeCurrentTab
  
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
  case summaryFoldStateChanged
  
  case scrapButtonClicked
  
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
      if let state = noti.object as? PlanPreviewStateModel{
        let vc = ModuleFactory.resolve().instantiatePlanPreviewVC(postID: state.planId,
                                                                  scrapState: state.scrapState)
        self.navigationController?.pushViewController(vc, animated: true)
      }
    }
    
    addObserverAction(.movePlanDetail) { noti in
      if let index = noti.object as? Int{
        let detailVC = ModuleFactory.resolve().instantiatePlanDetailVC(postID: index)
        self.navigationController?.pushViewController(detailVC, animated: true)
      }
    }
    
    addObserverAction(.moveHomeToPlanList) { noti in
      if let viewCase = noti.object as? TravelSpotDetailType{
        guard let spotlistVC = UIStoryboard.list(.travelSpot).instantiateViewController(withIdentifier: TravelSpotDetailVC.className) as? TravelSpotDetailVC else {return}
        spotlistVC.viewType = viewCase
        self.navigationController?.pushViewController(spotlistVC, animated: true)
      }
    }
    
    addObserverAction(.moveNicknamePlanList) { noti in
      if let authData = noti.object as? PlanWriterDataModel{
        guard let spotlistVC = UIStoryboard.list(.travelSpot).instantiateViewController(withIdentifier: TravelSpotDetailVC.className) as? TravelSpotDetailVC else {return}
        let userData = UserDataRequestDTO(name: authData.authorName, userID: authData.authorID)
        spotlistVC.userData = userData
        spotlistVC.viewType = .nickname
        self.navigationController?.pushViewController(spotlistVC, animated: true)
      }
    }
    addObserverAction(.movePlanList) { noti in
      guard let spotlistVC = UIStoryboard.list(.travelSpot).instantiateViewController(withIdentifier: TravelSpotDetailVC.className) as? TravelSpotDetailVC else {return}
      if let spot = noti.object as? TravelSpotList {
        spotlistVC.travelSpot = spot
      }
      self.navigationController?.pushViewController(spotlistVC, animated: true)
    }
    
    addObserverAction(.scrapButtonClicked) { noti in
      if let scrapObject = noti.object as? ScrapRequestDTO {
        if scrapObject.scrapState {
          self.deleteScrapAction(planID: scrapObject.planID)
        } else {
          self.postScrapAction(planID: scrapObject.planID)
        }
      }
    }

    
    addObserverAction(.moveHomeTab) { _ in
      self.tabClicked(index: .home)
    }
    
    NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification,
                                           object: nil,
                                           queue: nil) { _ in
      AppLog.log(at: FirebaseAnalyticsProvider.self, .enterBackGround)
    }
    
    NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                           object: nil,
                                           queue: nil) { _ in
      AppLog.log(at: FirebaseAnalyticsProvider.self, .enterForeGround)
    }
    
  }
  
  private func postScrapAction(planID: Int) {
    BaseService.default.postScrap(postId: planID) { result in
      result.success { _ in }
        .catch { _ in
          print("스크랩 실패")
        }
    }
  }
  
  private func deleteScrapAction(planID: Int) {
    BaseService.default.deleteScrap(postId: planID) { result in
      result.success { _ in }
        .catch { _ in
          print("스크랩 취소 실패")
        }
    }
  }
  
}

