//
//  MyPlanSerivice.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation

protocol MyPlanServiceType{
  func getOrderList(completion: @escaping (Result<PlanDataGettable?, Error>) -> Void)
  func getPurchaseList(completion: @escaping (Result<PurchaseHistoryDataModel?, Error>) -> Void)
}

extension BaseService : MyPlanServiceType{

    func getOrderList( completion: @escaping (Result<PlanDataGettable?, Error>) -> Void) {
    requestObject(.getBuyList, completion: completion)
  }
  
  func getPurchaseList(completion: @escaping (Result<PurchaseHistoryDataModel?, Error>) -> Void) {
    requestObject(.getPurchaseHistory, completion: completion)
  }
}
