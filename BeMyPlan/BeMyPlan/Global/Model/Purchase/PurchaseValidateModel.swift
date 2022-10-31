//
//  PurchaseValidateModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/20.
//

import Foundation

struct PurchaseValidateModel: Codable {
  let id: Int
  let status: String
  let transactionId: String
  let success: Bool
}
