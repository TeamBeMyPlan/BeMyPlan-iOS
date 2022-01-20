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
    let nickname: String?
    
    enum CodingKeys: String, CodingKey {
      case id, title, nickname, price
      case thumbnailURL = "thumbnail_url"
    }
  }


}

