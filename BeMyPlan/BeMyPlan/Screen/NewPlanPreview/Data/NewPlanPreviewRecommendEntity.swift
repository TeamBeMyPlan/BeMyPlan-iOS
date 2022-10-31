//
//  NewPlanPreviewRecommendModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/03.
//

import Foundation

struct NewPlanPreviewRecommendEntity: Codable {
    let region: Region?
    let title: String?
    let thumbnailURL: String?
    let planID: Int?
    let regionCategory: RegionCategory?

    enum CodingKeys: String, CodingKey {
        case region, title
        case thumbnailURL = "thumbnailUrl"
        case planID = "planId"
        case regionCategory
    }
}

enum Region: String, Codable {
    case jejuall = "JEJUALL"
}

enum RegionCategory: String, Codable {
    case jeju = "JEJU"
}
