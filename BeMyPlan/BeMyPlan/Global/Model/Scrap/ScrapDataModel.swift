//
//  ScrapDataModel.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

struct PlanDataGettable: Codable {
    let contents: [PlanContent]
    let nextCursor: Int
}

// MARK: - Content
struct PlanContent: Codable {
  let orderStatus: Bool
  let thumbnailURL: String
  let updatedAt: [Int]
  let scrapStatus: Bool
  let planID: Int
  let createdAt: [Int]
  let user: User
  let title: String

  enum CodingKeys: String, CodingKey {
      case orderStatus
      case thumbnailURL = "thumbnailUrl"
      case updatedAt, scrapStatus
      case planID = "planId"
      case createdAt, user, title
  }
}

// MARK: - User
struct User: Codable {
    let userID: Int
    let nickname: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case nickname
    }
}

struct ScrapStatusModel: Codable {
  let responseMessage: String
}
