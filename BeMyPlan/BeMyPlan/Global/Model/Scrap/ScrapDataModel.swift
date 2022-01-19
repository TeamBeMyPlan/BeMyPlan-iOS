//
//  ScrapDataModel.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

struct ScrapDataGettable: Codable {
    let id: Int
    let thumbnailURL: String
    let title, nickname: String

    enum CodingKeys: String, CodingKey {
        case id
        case thumbnailURL = "thumbnail_url"
        case title, nickname
    }
}
