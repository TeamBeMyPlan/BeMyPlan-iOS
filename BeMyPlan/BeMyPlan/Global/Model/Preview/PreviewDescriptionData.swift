//
//  PreviewDescriptionData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import Foundation

extension PlanPreview{
  struct DescriptionData{
    var descriptionContent : String
    var summary : [SummaryCase] = [.theme,.spotCount,.restaurantCount,.dayCount,
                                   .peopleCase,.budget,.transport,.month]
  }
  
  enum SummaryCase{
    case theme
    case spotCount
    case restaurantCount
    case dayCount
    case peopleCase
    case budget
    case transport
    case month
  }
}


