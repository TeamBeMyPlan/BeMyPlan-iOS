//
//  showNetworkAlert.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit

extension UIViewController{
  func showNetworkErrorAlert(){
    makeAlert(title: I18N.Alert.error, message: I18N.Alert.networkError)
  }
}
