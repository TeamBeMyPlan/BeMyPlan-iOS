//
//  TravelSpotDetailDataGettable.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

//struct TravelSpotDetailDataGettable: Codable {
//    let items: [TravelSpotDetailData]
//    let totalPage: Int
//}
//
//struct TravelSpotDetailData: Codable {
//    let id: Int
//    let title: String
//    let thumbnailURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, title
//        case thumbnailURL = "thumbnail_url"
//    }
//}

struct TravelSpotDetailDataGettable: Codable {
  let items: [TravelSpotDetailDataGettable.Item]
  let totalPage: Int?
  
//  struct Item : Codable {
//    let id: Int
//    let thumbnailURL: String
//    let title : String
//    let nickname: String?
//
//    enum CodingKeys: String, CodingKey {
//      case id, title, nickname
//      case thumbnailURL = "thumbnail_url"
//    }
//  }

  struct Item : Codable {
    let postID: Int
    let title, author: String
    let price: Int
    let thumbnailURL: String
    let isPurchased, isScraped: Bool

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title, author, price
        case thumbnailURL = "thumbnail_url"
        case isPurchased = "is_purchased"
        case isScraped = "is_scraped"
    }
  }
}

