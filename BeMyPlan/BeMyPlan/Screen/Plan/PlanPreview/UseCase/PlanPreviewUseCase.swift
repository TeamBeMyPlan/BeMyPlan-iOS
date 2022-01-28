//
//  PlanPreviewUseCase.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation

class PlanPreviewUseCase{
  let repository = BaseService.default
  
  
  func fetchBodyData(idx: Int){
    repository.getPlanPreviewDetailData(idx: idx) { result in
      result.success { list in
        
      }.catch { error in
        
      }
    }
  }
}
