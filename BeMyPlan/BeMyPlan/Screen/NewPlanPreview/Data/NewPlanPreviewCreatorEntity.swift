//
//  NewPlanPreviewCreator.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/03.
//

import Foundation

struct NewPlanPreviewCreatorEntity: Codable {
    let userID: Int
    let nickname, description: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case nickname
        case description = "description"
    }
}
