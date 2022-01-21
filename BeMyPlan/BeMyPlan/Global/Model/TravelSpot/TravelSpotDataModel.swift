//
//  TravelSpotData.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

  struct TravelSpotDataGettable: Codable {
      let id: Int
      let name: String
      let photoURL: String
      let isActivated: Bool

      enum CodingKeys: String, CodingKey {
          case name
          case id = "area_id"
          case photoURL = "photo_url"
          case isActivated = "is_activated"
      }
  }
  
