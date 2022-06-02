//
//  PlanPreviewEntity.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation

struct PlanPreviewEntity: Codable {
    let createdAt, updatedAt: String
    let previewInfo: PreviewInfo
    let previewContents: [PreviewContent]
}

// MARK: - PreviewContent
struct PreviewContent: Codable {
    let type: String
    let value: String
}

// MARK: - PreviewInfo
struct PreviewInfo: Codable {
    let planID: Int
    let title, previewInfoDescription: String
    let spotCnt, rstrnCnt, price: Int
    let budget: Budget
    let month, totalDay: Int
    let theme, partner, mobility, nickname: String

    enum CodingKeys: String, CodingKey {
        case planID = "planId"
        case title
        case previewInfoDescription = "description"
        case spotCnt, rstrnCnt, price, budget, month, totalDay, theme, partner, mobility, nickname
    }
}

struct Budget: Codable {
    let amount: Int
}

extension PlanPreviewEntity {
  func toHeaderDomain() -> PlanPreview.HeaderData? {
    return .init(authorID: -1,
                 writer: previewInfo.nickname,
                 title: previewInfo.title,
                 descriptionContent:previewInfo.previewInfoDescription,
                 summary: PlanPreview.IconData.init(theme: themeToString(previewInfo.theme),
                                                    spotCount: String(previewInfo.spotCnt),
                                                    restaurantCount: String(previewInfo.rstrnCnt),
                                                    dayCount: String(previewInfo.totalDay),
                                                    peopleCase: partnerToString(previewInfo.partner),
                                                    budget: makeBudgetString(previewInfo.budget.amount),
                                                    transport: mobilityToString(previewInfo.mobility),
                                                    month: String(previewInfo.month)),
                 price: String(previewInfo.price))
  }
  
  private func themeToString(_ tag: String) -> String {
    switch(tag) {
      case "ACTIVITY"   : return I18N.PlanPreview.Theme.activity
      case "CAMPING"    : return I18N.PlanPreview.Theme.camping
      case "EATING"     : return I18N.PlanPreview.Theme.eating
      case "HEALING"    : return I18N.PlanPreview.Theme.healing
      case "HOTPLACING" : return I18N.PlanPreview.Theme.hotplacing
      case "LIFESHOT"   : return I18N.PlanPreview.Theme.lifeshot
      case "LOCAL"      : return I18N.PlanPreview.Theme.local
      default           : return I18N.PlanPreview.Theme.activity
    }
  }
  
  private func makeBudgetString(_ budget: Int) -> String {
    if budget >= 10000 {
      return String(budget/10000) + "만원"
    } else {
      return String(budget) + "원"
    }
  }
  
  private func partnerToString(_ partner: String) -> String {
    switch(partner) {
      case "COUPLE"    : return I18N.PlanPreview.Partner.couple
      case "FAMILY"    : return I18N.PlanPreview.Partner.family
      case "FRIEND"    : return I18N.PlanPreview.Partner.friend
      case "SOLO"      : return I18N.PlanPreview.Partner.solo
      default          : return I18N.PlanPreview.Partner.couple
    }
  }
  
  private func mobilityToString(_ mobility: String) -> String {
    switch(mobility) {
      case "BICYCLE"  : return I18N.PlanPreview.Mobility.bicycle
      case "CAR"      : return I18N.PlanPreview.Mobility.car
      case "PUBLIC"   : return I18N.PlanPreview.Mobility.public
      case "WALK"     : return I18N.PlanPreview.Mobility.walk
      default         : return I18N.PlanPreview.Mobility.bicycle
    }
  }
}

extension PlanPreviewEntity {
  static func toBodyDomain(body: [PreviewContent]) -> PlanPreview.BodyData? {
    var photoDataList: [PlanPreview.PhotoData] = []
    
    for (index,_) in body.enumerated() {
      if body.count == index + 1 { break }
      guard body.count > index + 1 else { return nil }
      if index % 2 == 1 { continue }
      
      let photo = PlanPreview.PhotoData.init(photoUrl: body[index].value.trimmingCharacters(in: .whitespacesAndNewlines),
                                             content: body[index+1].value,
                                               height: .init())
        photoDataList.append(photo)
      
    }
    
    return PlanPreview.BodyData.init(photos: photoDataList, summary: nil)
  }
}
