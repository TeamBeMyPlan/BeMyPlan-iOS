//
//  PlanPreviewService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation
import RxSwift

protocol PlanPreviewServiceType{
  func getPlanPreviewHeaderData(idx : Int,completion: @escaping (Result<PlanPreviewEntity.Header?, Error>) -> Void)
  func getPlanPreviewDetailData(idx : Int,completion: @escaping (Result<[PlanPreviewEntity.Body]?, Error>) -> Void)
  func fetchPlanPreviewHeaderData(idx: Int) -> Observable<PlanPreviewEntity.Header?>
}

extension BaseService : PlanPreviewServiceType{
  
  func fetchPlanPreviewHeaderData(idx: Int) -> Observable<PlanPreviewEntity.Header?> {
    
    return .create { observer in
      requestObjectInRx(.getPlanPreviewHeaderData(idx: idx))
        .subscribe { on
          <#code#>
        } onFailure: { err in
          observer(.error(err))
        }


    }
    


  }
  func getPlanPreviewHeaderData(idx: Int, completion: @escaping (Result<PlanPreviewEntity.Header?, Error>) -> Void) {
    requestObject(.getPlanPreviewHeaderData(idx: idx), completion: completion)
  }
  
  func getPlanPreviewDetailData(idx: Int, completion: @escaping (Result<[PlanPreviewEntity.Body]?, Error>) -> Void) {
    requestObject(.getPlanPreviewData(idx: idx), completion: completion)
  }
}
