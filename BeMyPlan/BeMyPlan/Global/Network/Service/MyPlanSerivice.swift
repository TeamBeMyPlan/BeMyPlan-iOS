//
//  MyPlanSerivice.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation

protocol MyPlanServiceType{
  func getOrderList(userID : Int,completion: @escaping (Result<[MyPlanData.BuyListDataGettable]?, Error>) -> Void)
  func deleteUserWithdraw(completion: @escaping (Result<String?, Error>) -> Void)
}

extension BaseService : MyPlanServiceType{
  func deleteUserWithdraw(completion: @escaping (Result<String?, Error>) -> Void) {
    requestObject(.deleteUserWithdraw, completion: completion)
  }
  
  func getOrderList(userID: Int, completion: @escaping (Result<[MyPlanData.BuyListDataGettable]?, Error>) -> Void) {
    requestObject(.getBuyList(userID: userID), completion: completion)
  }
}
