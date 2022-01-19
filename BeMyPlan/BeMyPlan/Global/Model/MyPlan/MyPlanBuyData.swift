//
//  MyPlanBuyData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import Foundation

extension MyPlanData{

  // MARK: - Datum
  struct BuyListDataGettable: Codable {
      let id: Int
      let thumbnailURL: String
      let title, nickname: String
    
      enum CodingKeys: String, CodingKey {
          case id
          case thumbnailURL = "thumbnail_url"
          case title, nickname
      }
  }

}


