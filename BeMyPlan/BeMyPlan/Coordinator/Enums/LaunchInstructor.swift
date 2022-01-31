//
//  LaunchInstructor.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/31.
//

import Foundation

enum LaunchInstructor {
  case signing
  case main
  
  static func configure(_ isAuthorized: Bool = false) -> LaunchInstructor {
    switch isAuthorized {
      case false: return .signing
      case true: return .main
    }
  }
}
