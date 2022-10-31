//
//  PurchaseService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/19.
//

import Foundation

protocol PurchaseServiceType{
  func getPurchaseState(planIdx: Int,completion: @escaping (Result<Bool?, Error>) -> Void)
  func purchaseTravelPlan(price: Int, planIdx: Int,completion: @escaping (Result<PurchaseCheckModel?, Error>) -> Void)
  func validateReceipt(orderID: Int,receipt:String,completion: @escaping (Result<PurchaseValidateModel?, Error>) -> Void)
  func confirmTravelPurchase(orderID: Int,paymentId: Int, userID: Int,completion: @escaping (Result<PurchaseConfirmModel?, Error>) -> Void)
}

extension BaseService : PurchaseServiceType {
  func getPurchaseState(planIdx: Int,completion: @escaping (Result<Bool?, Error>) -> Void) {
    requestObject(.getTravelPurchaseState(idx: planIdx), completion: completion)
  }
  
  func purchaseTravelPlan(price: Int, planIdx: Int, completion: @escaping (Result<PurchaseCheckModel?, Error>) -> Void) {
    requestObject(.purchaseTravelPlan(price: price,idx: planIdx), completion: completion)
  }
  
  func validateReceipt(orderID: Int, receipt: String, completion: @escaping (Result<PurchaseValidateModel?, Error>) -> Void) {
    requestObject(.validatePurchase(idx: orderID, receipt: receipt),
                  completion: completion)
  }
  
  func confirmTravelPurchase(orderID: Int, paymentId: Int, userID: Int, completion: @escaping (Result<PurchaseConfirmModel?, Error>) -> Void) {
    requestObject(.completePurchase(idx: orderID, paymentID: paymentId, userID: userID),
                  completion: completion)
  }
}
