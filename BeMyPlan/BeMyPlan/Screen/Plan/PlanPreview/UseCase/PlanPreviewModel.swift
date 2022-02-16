//
//  PlanPreviewModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation

struct PlanPreviewModel{ }

// MARK: - Header

extension PlanPreviewModel{
  struct Header{
    var writer : String
    var title : String
  }
}
// MARK: - Description

extension PlanPreviewModel{
  struct Description{
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
}

// MARK: - Photo

extension PlanPreviewModel{
  struct Photo{
    var photo : String
    var content : String
  }
}

// MARK: - Summary

extension PlanPreviewModel{
  struct Summary{
    var content : String
  }
}
