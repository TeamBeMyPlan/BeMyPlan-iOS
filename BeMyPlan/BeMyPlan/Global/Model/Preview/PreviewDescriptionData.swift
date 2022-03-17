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
    var summary : IconData
  }
  
  struct IconData{
    var theme : String
    var spotCount : String
    var restaurantCount : String
    var dayCount : String
    var peopleCase : String
    var budget : String
    var transport : String
    var month : String
    
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
