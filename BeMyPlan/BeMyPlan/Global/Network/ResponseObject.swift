//
//  ResponseObject.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/17.
//

import Foundation

struct ResponseObject<T> {
  let status: Int?
  let message: String?
  let data: T?
  
  enum CodingKeys: String, CodingKey {
    case status
    case message
    case data
  }
}

extension ResponseObject: Decodable where T: Decodable  {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try? container.decode(Int.self, forKey: .status)
    message = try? container.decode(String.self, forKey: .message)
    data = try? container.decode(T.self, forKey: .data)
  }
}
