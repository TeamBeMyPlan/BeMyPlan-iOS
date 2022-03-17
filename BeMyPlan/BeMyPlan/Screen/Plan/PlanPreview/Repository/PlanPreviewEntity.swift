//
//  PlanPreviewEntity.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation


struct PlanPreviewEntity :Codable{
  struct Body :Codable{
    let datumDescription: String
    let photoUrls: [String]
    
    enum CodingKeys: String, CodingKey {
      case datumDescription = "description"
      case photoUrls = "photo_urls"
    }
  }
  
  struct Header: Codable {
      let title, dataDescription: String
      let price: Int
      let tagTheme: String
      let tagCountSpot, tagCountDay, tagCountRestaurant: Int
      let tagPartner, tagMoney, tagMobility: String
      let tagMonth: Int
      let author: String
      let authorID: Int

      enum CodingKeys: String, CodingKey {
          case title
          case dataDescription = "description"
          case price
          case tagTheme = "tag_theme"
          case tagCountSpot = "tag_count_spot"
          case tagCountDay = "tag_count_day"
          case tagCountRestaurant = "tag_count_restaurant"
          case tagPartner = "tag_partner"
          case tagMoney = "tag_money"
          case tagMobility = "tag_mobility"
          case tagMonth = "tag_month"
          case author
          case authorID = "author_id"
      }
  }

}

extension PlanPreviewEntity.Header {
  func toHeaderDomain() -> PlanPreview.HeaderData? {
    return .init(authorID: authorID,
                 writer: author,
                 title: title,
                 descriptionContent:dataDescription,
                 summary: PlanPreview.IconData.init(theme: tagTheme,
                                        spotCount: String(tagCountSpot),
                                        restaurantCount: String(tagCountRestaurant),
                                        dayCount: String(tagCountDay),
                                        peopleCase: tagPartner,
                                        budget: tagMoney,
                                        transport: tagMobility,
                                        month: String(tagMonth)),
                 price: String(price))
  }
}

extension PlanPreviewEntity {
  static func toBodyDomain(body: [PlanPreviewEntity.Body]?) -> PlanPreview.BodyData? {
    var photoDataList: [PlanPreview.PhotoData] = []
    if let body = body {
      for item in body {
          let photo = PlanPreview.PhotoData.init(photoUrl: item.photoUrls.first ?? "",
                                                 content: item.datumDescription)
          photoDataList.append(photo)
      }
    }
    return PlanPreview.BodyData.init(photos: photoDataList, summary: nil)
  }
}
