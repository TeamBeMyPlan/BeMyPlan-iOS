//
//  PlanDetailSpotDataModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/13.
//

import Foundation



extension PlanDetailData{
  struct SpotData{
    var locationTitle : String
    var address : String
    var imagerUrls :[String]
    var textContent : String
    var nextLocationData : PlanDetailData.Summary?
  }
}
