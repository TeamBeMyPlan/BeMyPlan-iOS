//
//  BaseVC + Notification.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

enum BaseNotiList{
  case moveHomeTab
  case moveTravelSpotTab
  case moveScrapTab
  case moveMyPlanTab
  case moveSettingView
  
  static func makeNotiName(list : BaseNotiList) -> NSNotification.Name{
    return Notification.Name(String(describing: list))
  }
  
}

extension BaseVC{
  private func addObservers(){
    addObserverAction(keyName: BaseNotiList.moveSettingView) { _ in
      guard let setting
    }

  }
}
