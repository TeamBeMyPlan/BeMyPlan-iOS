//
//  ScrapService.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

protocol ScrapService {
  func getScrapList(lastId: Int?, sort: FilterSortCase, completion: @escaping (Result<PlanDataGettable?, Error>) -> Void)
  func postScrap(postId: Int, completion: @escaping (Result<String?, Error>) -> Void)
  func deleteScrap(postId: Int, completion: @escaping (Result<String?, Error>) -> Void)

}

extension BaseService: ScrapService {
  func getScrapList(lastId: Int? = nil, sort: FilterSortCase, completion: @escaping (Result<PlanDataGettable?, Error>) -> Void) {
    requestObject(.getScrapList(lastScrapId: lastId, sort: sort.rawValue),completion: completion)
  }
  
  func postScrap(postId: Int, completion: @escaping (Result<String?, Error>) -> Void) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .complete_scrap(id: postId))
    requestObject(.postScrap(postId: postId), completion: completion)
  }
  
  func deleteScrap(postId: Int, completion: @escaping (Result<String?, Error>) -> Void) {
    requestObject(.deleteScrap(postId: postId), completion: completion)
  }
}
