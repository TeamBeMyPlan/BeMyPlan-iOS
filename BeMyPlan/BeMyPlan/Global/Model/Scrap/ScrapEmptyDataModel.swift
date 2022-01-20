//
//  ScrapEmptyDataModel.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/21.
//

import Foundation


struct ScrapEmptyDataGettable: Codable {
      let postID: Int
      let title: String
      let thumbnailURL: String
      let price: Int
      let isPurchased: Bool

      enum CodingKeys: String, CodingKey {
          case postID = "post_id"
          case title
          case thumbnailURL = "thumbnail_url"
          case price
          case isPurchased = "is_purchased"
  }
  
}
