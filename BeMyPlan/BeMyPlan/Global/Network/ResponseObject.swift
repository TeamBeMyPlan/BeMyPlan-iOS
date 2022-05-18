//
//  ResponseObject.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/17.
//

import Foundation

struct ResponseObject<T> {
  let resultCode: Int?
  let message: String?
  let data: T?
  
  enum CodingKeys: String, CodingKey {
    case resultCode
    case message
    case data
  }
}

extension ResponseObject: Decodable where T: Decodable  {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    resultCode = try? container.decode(Int.self, forKey: .resultCode)
    message = try? container.decode(String.self, forKey: .message)
    data = try? container.decode(T.self, forKey: .data)
  }
}
