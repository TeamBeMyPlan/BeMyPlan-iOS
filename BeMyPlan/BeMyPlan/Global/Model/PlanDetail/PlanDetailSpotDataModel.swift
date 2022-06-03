//
//  PlanDetailSpotDataModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/13.
//

import Foundation

extension PlanDetail{
  struct SpotData{
    let locationTitle : String
    let address: String
    var latitude : Double? = nil
    var longtitude: Double? = nil
    let imagerUrls :[String]
    let textContent : String
    let nextLocationData : PlanDetail.Summary?
  }
}
