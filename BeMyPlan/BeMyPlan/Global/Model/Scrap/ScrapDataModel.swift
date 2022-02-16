//
//  ScrapDataModel.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation
// MARK: - wiData
struct ScrapDataGettable: Codable {
  let items: [ScrapItem]
    let totalPage: Int
}

// MARK: - wiItem
struct ScrapItem: Codable {
    let postID: Int
    let title: String
    let price: Int
    let thumbnailURL: String
    let isPurchased: Bool

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case title, price
        case thumbnailURL = "thumbnail_url"
        case isPurchased = "is_purchased"
    }
}
