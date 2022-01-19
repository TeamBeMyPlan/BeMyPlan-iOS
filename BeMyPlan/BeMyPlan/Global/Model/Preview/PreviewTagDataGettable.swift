//
//  PreviewInfoDataGettable.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation


extension PlanPreview{
  struct HeaderGettable: Codable {
      let title: String
      let authorID: Int
      let dataDescription, tagTheme: String
      let tagCountSpot, tagCountDay, tagCountRestaurant: Int
      let tagPartner, tagMoney, tagMobility: String
      let tagMonth: Int
      let userNickname: String

      enum CodingKeys: String, CodingKey {
          case title
          case authorID = "author_id"
          case dataDescription = "description"
          case tagTheme = "tag_theme"
          case tagCountSpot = "tag_count_spot"
          case tagCountDay = "tag_count_day"
          case tagCountRestaurant = "tag_count_restaurant"
          case tagPartner = "tag_partner"
          case tagMoney = "tag_money"
          case tagMobility = "tag_mobility"
          case tagMonth = "tag_month"
          case userNickname = "user.nickname"
      }
  }

}
