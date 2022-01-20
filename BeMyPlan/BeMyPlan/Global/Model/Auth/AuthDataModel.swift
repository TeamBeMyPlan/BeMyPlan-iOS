//
//  AuthDataModel.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/21.
//

import Foundation

struct AuthDataGettable : Codable{
  let created : Bool
  let nickname : String
  let accessToken : String
  
  enum CodingKeys: String, CodingKey {
    case created, nickname
    case accessToken = "access_token"
  }
}
