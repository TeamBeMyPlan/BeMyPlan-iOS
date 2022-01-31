//
//  Presentable.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/31.
//

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
  func toPresent() -> UIViewController? {
    return self
  }
}
