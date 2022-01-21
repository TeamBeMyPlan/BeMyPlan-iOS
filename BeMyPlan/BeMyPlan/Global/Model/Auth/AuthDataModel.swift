//
//  AuthDataModel.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/21.
//

import Foundation

struct AuthDataGettable : Codable{
  let nickname : String
  let accessToken : String?
  let possible: Bool?
  
  enum CodingKeys: String, CodingKey {
    case nickname, possible
    case accessToken = "access_token"
    
  }
}
