//
//  TravelSpotData.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

struct TravelSpotDataGettable: Codable {
  let region: String
  let name: String
  let photoURL: String
  let isActivated: Bool
  
  enum CodingKeys: String, CodingKey {
    case name
    case region = "region"
    case photoURL = "thumbnailUrl"
    case isActivated = "locked"
  }
}
