//
//  ScrapBtnDataModel.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

//struct ScrapBtnDataGettable: Codable {
//    let scrapped: Bool
//}

struct ScrapBtnDataGettable: Codable {
//    let data: ScrapBtnData
  let scrapped: Bool
  
  enum CodingKeys: String, CodingKey {
      case scrapped
  }
}

struct ScrapBtnData: Codable {
    let scrapped: Bool
}
