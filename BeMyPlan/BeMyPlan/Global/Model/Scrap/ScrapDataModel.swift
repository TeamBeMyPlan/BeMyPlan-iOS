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
    let createdAt, updatedAt: String
    let planID: Int
    let thumbnailURL: String
    let title: String
    let user: User
    var scrapStatus, orderStatus: Bool

    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt
        case planID = "planId"
        case thumbnailURL = "thumbnailUrl"
        case title, user, scrapStatus, orderStatus
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
