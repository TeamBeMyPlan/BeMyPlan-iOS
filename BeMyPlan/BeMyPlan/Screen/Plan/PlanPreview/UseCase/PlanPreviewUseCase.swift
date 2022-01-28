//
//  PlanPreviewUseCase.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation

final class PlanPreviewUseCase{
  let repository = BaseService.default
  
  
  var headerData : PlanPreview.HeaderData?
  var descriptionData : PlanPreview.DescriptionData?
  var photoData : [PlanPreview.PhotoData]?
  var summaryData : PlanPreview.SummaryData?
  var recommendData : PlanPreview.RecommendData?
  
  func fetchBodyData(idx: Int){
    repository.getPlanPreviewDetailData(idx: idx) { result in
      result.success { list in
        
      }.catch { error in
        
      }
    }
  }
}
