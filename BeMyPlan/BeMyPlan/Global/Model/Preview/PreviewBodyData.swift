//
//  PreviewBodyData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/14.
//

import Foundation

extension PlanPreview {
  struct BodyData {
    var photos: [PlanPreview.PhotoData]
    var summary: PlanPreview.SummaryData?
  }
}
