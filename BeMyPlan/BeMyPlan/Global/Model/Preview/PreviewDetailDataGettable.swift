//
//  PreviewDetailDataGettable.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation

extension PlanPreview{
  struct DetailDataGettable: Codable {
      let datumDescription: String
      let photoUrls: [String]

      enum CodingKeys: String, CodingKey {
          case datumDescription = "description"
          case photoUrls = "photo_urls"
      }
  }

}
