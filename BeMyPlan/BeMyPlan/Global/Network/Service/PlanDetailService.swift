//
//  PlanDetailService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation

protocol PlanDetailServiceType{
  func getPlanDetailData(idx : Int,completion: @escaping (Result<PlanDetailDataEntity?, Error>) -> Void)
  func getPlanTransportData(idx: Int,completion: @escaping (Result<[PlanDetailTransportEntity]?, Error>) -> Void)
}

extension BaseService : PlanDetailServiceType{
  func getPlanDetailData(idx: Int, completion: @escaping (Result<PlanDetailDataEntity?, Error>) -> Void) {
    requestObject(.getPlanDetailData(idx: idx), completion: completion)
  }
  func getPlanTransportData(idx: Int,completion: @escaping (Result<[PlanDetailTransportEntity]?, Error>) -> Void) {
    requestObject(.getPlanDetailTransportData(idx: idx), completion: completion)
  }

}

