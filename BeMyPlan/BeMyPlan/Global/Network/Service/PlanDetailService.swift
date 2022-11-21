//
//  PlanDetailService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation

protocol PlanDetailServiceType{
  func getPlanDetailData(idx : Int, isPreview: Bool, completion: @escaping (Result<PlanDetailDataEntity?, Error>) -> Void)
  func getPlanTransportData(idx: Int, isPreview: Bool, completion: @escaping (Result<[PlanDetailTransportEntity]?, Error>) -> Void)
}

extension BaseService : PlanDetailServiceType{
  func getPlanDetailData(idx: Int, isPreview: Bool = false, completion: @escaping (Result<PlanDetailDataEntity?, Error>) -> Void) {
    if !isPreview {
      requestObject(.getPlanDetailData(idx: idx), completion: completion)
    } else {
      requestObject(.getPlanDetailDataInPreviewMode, completion: completion)
    }
  }
  func getPlanTransportData(idx: Int, isPreview: Bool = false, completion: @escaping (Result<[PlanDetailTransportEntity]?, Error>) -> Void) {
    if !isPreview {
      requestObject(.getPlanDetailTransportData(idx: idx), completion: completion)
    } else {
      requestObject(.getPlanDetailTransportDataInPreviewMode, completion: completion)
    }
  }
}

