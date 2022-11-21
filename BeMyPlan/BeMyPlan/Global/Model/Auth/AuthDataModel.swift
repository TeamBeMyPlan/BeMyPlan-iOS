//
//  AuthDataModel.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/21.
//

import Foundation

struct AuthDataGettable : Codable{
  let nickname : String
  let sessionId: String
  let userId: Int
  let token: String
}
