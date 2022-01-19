//
//  PreviewDetailDataGettable.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation

extension PlanPreview{
  struct DetailDataGettable: Codable {
      let photoURL, description: String
    
      enum CodingKeys: String, CodingKey {
          case photoURL = "photo_url"
          case description = "description"
      }
  }
}
