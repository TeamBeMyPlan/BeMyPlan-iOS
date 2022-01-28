//
//  PlanPreviewEntity.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation

struct PlanPreviewEntity :Codable{
  struct Body :Codable{
    let datumDescription: String
    let photoUrls: [String]
    
    enum CodingKeys: String, CodingKey {
      case datumDescription = "description"
      case photoUrls = "photo_urls"
    }
  }
  
  struct Header: Codable {
      let title, dataDescription: String
      let price: Int
      let tagTheme: String
      let tagCountSpot, tagCountDay, tagCountRestaurant: Int
      let tagPartner, tagMoney, tagMobility: String
      let tagMonth: Int
      let author: String
      let authorID: Int

      enum CodingKeys: String, CodingKey {
          case title
          case dataDescription = "description"
          case price
          case tagTheme = "tag_theme"
          case tagCountSpot = "tag_count_spot"
          case tagCountDay = "tag_count_day"
          case tagCountRestaurant = "tag_count_restaurant"
          case tagPartner = "tag_partner"
          case tagMoney = "tag_money"
          case tagMobility = "tag_mobility"
          case tagMonth = "tag_month"
          case author
          case authorID = "author_id"
      }
  }

}
