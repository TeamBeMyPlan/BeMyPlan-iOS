//
//  ScrapService.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

protocol ScrapService {
  func getScrapList(userId: Int, page: Int, pageSize: Int, sort: String, completion: @escaping (Result<[ScrapDataGettable]?, Error>) -> Void)
}

extension BaseService: ScrapService {
  func getScrapList(userId: Int, page: Int, pageSize: Int, sort: String, completion: @escaping (Result<[ScrapDataGettable]?, Error>) -> Void) {
    print("아하아하아하아하")
    requestObject(.getScrapList(userId: userId, page: page, pageSize: pageSize, sort: sort), completion: completion)
  }
}
