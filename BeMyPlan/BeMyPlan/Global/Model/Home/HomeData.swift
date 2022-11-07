//
//  HomeData.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/18.
//

import Foundation

struct HomeListDataGettable: Codable {
  let contents: [HomeListDataGettable.Item]
  
  struct Item : Codable{
    let createdAt, updatedAt: [Int]?
    let planID: Int
    let thumbnailURL: String
    let title: String
    let user: User
    let scrapStatus, orderStatus: Bool

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt
        case planID = "planId"
        case thumbnailURL = "thumbnailUrl"
        case title, user, scrapStatus, orderStatus
    }
  }
  
  struct User: Codable {
      let userID: Int
      let nickname: String

      enum CodingKeys: String, CodingKey {
          case userID = "userId"
          case nickname
      }
  }
}
