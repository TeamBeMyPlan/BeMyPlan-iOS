//
//  PreviewData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import Foundation


struct PlanPreview{
  enum ContentList{
    case header
    case description
    case photo
    case summary
    case recommend
  }
  
  struct ContentData{
    var headerData: PlanPreview.HeaderData?
    var bodyData: PlanPreview.BodyData?
  }
}
