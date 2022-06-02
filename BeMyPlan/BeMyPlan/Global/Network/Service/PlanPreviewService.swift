//
//  PlanPreviewService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation
import RxSwift

protocol PlanPreviewServiceType{
  func fetchPlanPreviewData(idx: Int) -> Observable<PlanPreviewEntity?>
}

extension BaseService : PlanPreviewServiceType{
  func fetchPlanPreviewData(idx: Int) -> Observable<PlanPreviewEntity?> {
    return requestObjectInRx(.getPlanPreviewData(idx: idx))
  }
}
