//
//  PlanDetailDataGettable.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation
// MARK: - PlanDetailDataGettable
struct PlanDetailDataGettable: Codable {
  let author, title: String
  let spots: [[PlanDetailDataGettable.SpotData?]]
  let totalDays: Int
  let authorID : Int
  
  enum CodingKeys: String, CodingKey {
    case authorID = "author_id"
    case author, title, spots
    case totalDays = "total_days"
  }
  
  // MARK: - Spot
  struct SpotData: Codable {
    let title, spotDescription: String
    let photoUrls: [String]
    let address: String
    let latitude, longitude: Double
    let nextSpotMobility, nextSpotRequiredTime: String
    
    enum CodingKeys: String, CodingKey {
      case title
      case spotDescription = "description"
      case photoUrls = "photo_urls"
      case address, latitude, longitude
      case nextSpotMobility = "next_spot_mobility"
      case nextSpotRequiredTime = "next_spot_required_time"
    }
  }
}

