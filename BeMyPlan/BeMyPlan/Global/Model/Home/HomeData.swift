//
//  HomeData.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/18.
//

import Foundation

struct HomeListDataGettable: Codable {
  let items: [HomeListDataGettable.Item]
  let totalPage: Int?
  
  
  struct Item : Codable{
    let id: Int
    let thumbnailURL: String
    let title : String
    let price : Int?
    let nickname : String?
    let isPurchased : Bool?
    let isScraped : Bool?
    
    enum CodingKeys: String, CodingKey {
      case title, price
      case id = "post_id"
      case thumbnailURL = "thumbnail_url"
      case nickname = "author"
      case isPurchased = "is_purchased"
      case isScraped = "is_scraped"
      
    }
  }


}
