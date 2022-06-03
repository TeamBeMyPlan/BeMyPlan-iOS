//
//  OrderService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/03.
//

import Foundation

protocol OrderServiceType{
  func postOrderPlan(planIdx: Int,completion: @escaping (Result<Bool?, Error>) -> Void)
}

extension BaseService : OrderServiceType {
  func postOrderPlan(planIdx: Int,completion: @escaping (Result<Bool?, Error>) -> Void) {
    requestObject(.postOrderPlan(postId: planIdx), completion: completion)
  }

}
