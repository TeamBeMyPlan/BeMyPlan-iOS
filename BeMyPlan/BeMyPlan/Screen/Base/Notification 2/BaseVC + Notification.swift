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
  case moveSettingWithdrawView
  
  static func makeNotiName(list : BaseNotiList) -> NSNotification.Name{
    return Notification.Name(String(describing: list))
  }
  
}

extension BaseVC{
  func addObservers(){
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .moveSettingView)) { _ in
      guard let settingVC = UIStoryboard.list(.myPlan).instantiateViewController(withIdentifier: MyPlanSettingVC.className) as? MyPlanSettingVC else {return}
      self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    addObserverAction(keyName: BaseNotiList.makeNotiName(list: .moveSettingWithdrawView)) { _ in
      guard let withdrawVC = UIStoryboard.list(.myPlan).instantiateViewController(withIdentifier: MyPlanWithdrawVC.className) as? MyPlanWithdrawVC else {return}
      self.navigationController?.pushViewController(withdrawVC, animated: true)
    }
  }
}
