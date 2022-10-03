//
//  NewPlanPreviewRecommendModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/03.
//

import Foundation

struct NewPlanPreviewRecommendEntity: Codable {
    let planID: Int
    let thumbnailURL: String
    let title: String
    let regionCategory: RegionCategory
    let region: Region

    enum CodingKeys: String, CodingKey {
        case planID = "planId"
        case thumbnailURL = "thumbnailUrl"
        case title, regionCategory, region
    }
}

enum Region: String, Codable {
    case jejuall = "JEJUALL"
}

enum RegionCategory: String, Codable {
    case jeju = "JEJU"
}
