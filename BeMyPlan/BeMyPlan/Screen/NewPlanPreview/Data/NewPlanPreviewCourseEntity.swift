//
//  NewPlanPreviewCourse.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/03.
//

import Foundation

struct NewPlanPreviewCourseEntity: Codable {
    let createdAt, updatedAt: [Int]
    let planID: Int
    let title, dataDescription: String
    let thumbnail: [String]
    let regionCategory, region: String
    let hashtag: [String]
    let theme: String
    let spotCount, restaurantCount, totalDay: Int
    let travelPartner: String
    let budget: Budget
    let travelMobility: String
    let month, price: Int
    let recommendTarget: [String]

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt
        case planID = "planId"
        case title
        case dataDescription = "description"
        case thumbnail, regionCategory, region, hashtag, theme, spotCount, restaurantCount, totalDay, travelPartner, budget, travelMobility, month, price, recommendTarget
    }
}
