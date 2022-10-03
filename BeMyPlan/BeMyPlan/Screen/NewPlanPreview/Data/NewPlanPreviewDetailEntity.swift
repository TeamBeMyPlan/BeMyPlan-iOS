//
//  NewPlanPreviewDetailEntity.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/04.
//

import Foundation

struct NewPlanPreviewDetailEntity: Codable {
    let previewContents: [PreviewDetailContent]
}

// MARK: - PreviewContent
struct PreviewDetailContent: Codable {
    let images: [String]
    let previewContentDescription: String

    enum CodingKeys: String, CodingKey {
        case images
        case previewContentDescription = "description"
    }
}
