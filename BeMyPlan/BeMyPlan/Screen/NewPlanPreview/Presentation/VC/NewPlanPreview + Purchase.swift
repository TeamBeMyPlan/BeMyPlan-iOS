//
//  NewPlanPreview + Purchase.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/08/10.
//

import Foundation
import StoreKit

enum MyProducts {
  static let productID = "com.BeMyPlan.release.plan01"
  static let iapService: IAPServiceType = IAPService(productIDs: Set<String>([productID]))
  
  static func getResourceProductName(_ id: String) -> String? {
    id.components(separatedBy: ".").last
  }
}


extension NewPlanPreviewVC {
  func initIAP() {
    
    addObserverAction(.IAPServicePurchaseNotification) { noti in
      self.handlePurchaseNoti(noti)
    }

    MyProducts.iapService.getProducts { [weak self] success, products in
      print("load products \(products ?? [])")
      guard let self = self else { return }
      if success, let products = products {
        DispatchQueue.main.async {
          self.products = products
        }
      }
    }
  }

  // 인앱 결제 버튼 눌렀을 때
  func touchIAP() {
      if let product = products.first {
        MyProducts.iapService.buyProduct(product)
      }
  }
  
  @objc private func restore() {
    MyProducts.iapService.restorePurchases()
  }
  
  @objc private func handlePurchaseNoti(_ notification: Notification) {
    print("handlePurchaseNoti")
    guard
      let productID = notification.object as? String,
      let index = self.products.firstIndex(where: { $0.productIdentifier == productID })
    else { return }
    print("성공",index)
  }


}
