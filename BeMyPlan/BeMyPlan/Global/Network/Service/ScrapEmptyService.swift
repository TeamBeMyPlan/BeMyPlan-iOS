//
//  ScrapEmptyService.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/21.
//

import Foundation

protocol ScrapEmptyService {
  func getScrapEmptyList(userId: Int, completion: @escaping (Result<[ScrapEmptyDataGettable]?, Error>) -> Void)
}

extension BaseService: ScrapEmptyService {
  func getScrapEmptyList(userId: Int, completion: @escaping (Result<[ScrapEmptyDataGettable]?, Error>) -> Void) {
    requestObject(.getScrapEmptyList(userId: userId), completion: completion)
  }
}
