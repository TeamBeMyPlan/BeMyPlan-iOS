//
//  PreviewRecommendData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import Foundation

extension PlanPreview{
  struct RecommendData: PlanPreviewContent{
    var `case`: PlanPreview.ContentList = .recommend
    // 일단 고정값으로 진행
    var title = I18N.PlanPreview.Recommend.title
    var content = I18N.PlanPreview.Recommend.content
  }
}
