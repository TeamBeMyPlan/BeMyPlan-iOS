//
//  PlanPreviewService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation
import RxSwift

protocol PlanPreviewServiceType{
  func fetchPlanPreviewHeaderData(idx: Int) -> Observable<PlanPreviewEntity.Header?>
  func fetchPlanPreviewBodyData(idx: Int) -> Observable<PlanPreviewEntity.Body?>
}

extension BaseService : PlanPreviewServiceType{
  func fetchPlanPreviewHeaderData(idx: Int) -> Observable<PlanPreviewEntity.Header?> {
    return requestObjectInRx(.getPlanPreviewHeaderData(idx: idx))
  }
  
  func fetchPlanPreviewBodyData(idx: Int) -> Observable<PlanPreviewEntity.Body?> {
    return requestObjectInRx(.getPlanPreviewData(idx: idx))
  }
}
