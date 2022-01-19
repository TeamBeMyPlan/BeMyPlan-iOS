//
//  showNetworkErr + UIViewController.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import UIKit
extension UIViewController{
  func showNetworkErr(){
    self.makeAlert(alertCase: .simpleAlert, title: "오류", content: "네트워크 상태를 확인해주세요")
  }
}
