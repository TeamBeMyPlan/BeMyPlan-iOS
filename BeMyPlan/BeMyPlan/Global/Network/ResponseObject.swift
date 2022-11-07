//
//  ResponseObject.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/17.
//

import Foundation

struct ResponseObject<T> {
  let code: Int?
  let msg: String?
  let success: Bool?
  let data: T?
  
  enum CodingKeys: String, CodingKey {
    case resultCode
    case message
    case data
    case success
  }
}

extension ResponseObject: Decodable where T: Decodable  {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try? container.decode(Int.self, forKey: .resultCode)
    msg = try? container.decode(String.self, forKey: .message)
    success = try? container.decode(Bool.self, forKey: .success)
    data = try? container.decode(T.self, forKey: .data)
  }
}
