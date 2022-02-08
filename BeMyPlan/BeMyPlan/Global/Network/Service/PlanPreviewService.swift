//
//  PlanPreviewService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation

protocol PlanPreviewServiceType{
  func getPlanPreviewHeaderData(idx : Int,completion: @escaping (Result<PlanPreview.HeaderGettable?, Error>) -> Void)
  func getPlanPreviewDetailData(idx : Int,completion: @escaping (Result<[PlanPreview.DetailDataGettable]?, Error>) -> Void)
}

extension BaseService : PlanPreviewServiceType{
  func getPlanPreviewHeaderData(idx: Int, completion: @escaping (Result<PlanPreview.HeaderGettable?, Error>) -> Void) {
    requestObject(.getPlanPreviewHeaderData(idx: idx), completion: completion)
  }
  
  func getPlanPreviewDetailData(idx: Int, completion: @escaping (Result<[PlanPreview.DetailDataGettable]?, Error>) -> Void) {
    requestObject(.getPlanPreviewData(idx: idx), completion: completion)
  }
}
