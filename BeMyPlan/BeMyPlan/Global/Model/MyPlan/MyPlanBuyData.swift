//
//  MyPlanBuyData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import Foundation

extension MyPlanData{
  struct BuyListDataGettable: Codable{
    let items: [MyPlanData.BuyListData]
    let totalCount, totalPage: Int
  }

  // MARK: - Datum
  struct BuyListData: Codable {
      let id: Int
      let thumbnailURL: String
      let title, author: String
    
      enum CodingKeys: String, CodingKey {
          case id
          case thumbnailURL = "thumbnail_url"
          case title, author
      }
  }

}


