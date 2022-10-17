//
//  PurchaseProductModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/12.
//

import Foundation
import StoreKit

struct PurchaseProductModel {
  let productID: String
  
  var iapService: IAPService {
    IAPService(productIDs: Set<String>([self.productID]))
  }
  
  init(productID: String) {
    self.productID = productID
  }

  static func getResourceProductName(_ id: String) -> String? {
    id.components(separatedBy: ".").last
  }
}
