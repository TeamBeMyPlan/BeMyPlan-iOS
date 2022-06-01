//
//  MyPlanSerivice.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation

protocol MyPlanServiceType{
  func getOrderList(completion: @escaping (Result<PlanDataGettable?, Error>) -> Void)
  func deleteUserWithdraw(completion: @escaping (Result<String?, Error>) -> Void)
}

extension BaseService : MyPlanServiceType{
  func deleteUserWithdraw(completion: @escaping (Result<String?, Error>) -> Void) {
    requestObject(.deleteUserWithdraw, completion: completion)
  }
  
  func getOrderList( completion: @escaping (Result<PlanDataGettable?, Error>) -> Void) {
    requestObject(.getBuyList, completion: completion)
  }
}
