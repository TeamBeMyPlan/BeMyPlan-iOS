//
//  planDetailTransportEntity.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/03.
//

import Foundation

struct PlanDetailTransportEntity: Codable {
    let day: Int
    let infos: [TransportInfo]
}

// MARK: - Info
struct TransportInfo: Codable {
    let fromSpotID, toSpotID: Int
    let mobility: String
    let spentMinute: Int

    enum CodingKeys: String, CodingKey {
        case fromSpotID = "fromSpotId"
        case toSpotID = "toSpotId"
        case mobility, spentMinute
    }
}

