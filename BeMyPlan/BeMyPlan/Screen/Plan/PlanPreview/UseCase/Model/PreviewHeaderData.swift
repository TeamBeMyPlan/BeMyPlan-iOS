//
//  PreviewHeaderData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import Foundation

extension PlanPreview{
  struct HeaderDataModel: PlanPreviewContent {
    var `case`: PlanPreview.ContentList = .header
    var writer: String
    var title: String
  }
  
  struct HeaderData{
    var authorID: Int
    var writer: String
    var title: String
    var descriptionContent: String
    var summary: IconData
    var price: String
  }
}
