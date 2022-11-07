//
//  PurchaseHistoryDataModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/11/08.
//

import Foundation

struct PurchaseHistoryDataModel: Codable {
  let contents: [PurchaseContent]
}

// MARK: - Content
struct PurchaseContent: Codable {
  let createdAt, updatedAt: [Int]
  let planID: Int
  let thumbnailURL: String
  let title: String
  let orderPrice: Int

  enum CodingKeys: String, CodingKey {
      case createdAt, updatedAt
      case planID = "planId"
      case thumbnailURL = "thumbnailUrl"
      case title, orderPrice
  }
}
