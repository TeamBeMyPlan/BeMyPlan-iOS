//
//  PlanDetailEntity.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/02/22.
//

import Foundation

struct PlanDetailDataEntity: Codable {
    let createdAt, updatedAt: String
    let planID: Int
    let title: String
    let user: User
    let contents: [Content]

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt
        case planID = "planId"
        case title, user, contents
    }
}

// MARK: - Content
struct Content: Codable {
    let spots: [Spot]
}

// MARK: - Spot
struct Spot: Codable {
    let createdAt, updatedAt: String
    let name: String
    let latitude, longitude: Double
    let tip, review: String?
    let images: [PlanDetailImage]
}


// MARK: - Image
struct PlanDetailImage: Codable {
    let createdAt, updatedAt: String
    let imageID: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt
        case imageID = "imageId"
        case url
    }
}

