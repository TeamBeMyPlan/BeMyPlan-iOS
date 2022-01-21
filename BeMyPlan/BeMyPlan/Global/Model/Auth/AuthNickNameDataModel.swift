//
//  AuthNickNameDataModel.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/21.
//

import Foundation


struct AuthNickNameDataGettable: Codable {
  let duplicated: Bool
  
  enum CodingKeys: String, CodingKey {
    case duplicated
  }
}
