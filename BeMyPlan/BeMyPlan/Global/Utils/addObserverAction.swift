//
//  setObserverAction.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import Foundation

extension NSObject{

  func addObserverAction(keyName : NSNotification.Name, action : @escaping (Notification) -> ()){
    NotificationCenter.default.addObserver(forName: keyName,
                                           object: nil,
                                           queue: nil,
                                           using: action)
  }
}
