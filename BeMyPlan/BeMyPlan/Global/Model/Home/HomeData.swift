//
//  HomeData.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/18.
//

import Foundation

struct HomeListDataGettable : Codable{
  let id: Int
  let thumbnailURL: String
  let title, nickname: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case thumbnailURL = "thumbnail_url"
    case title, nickname
  }
}
