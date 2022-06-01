//
//  ScrapService.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

protocol ScrapService {
  func getScrapList(lastId: Int?, sort: FilterSortCase, completion: @escaping (Result<ScrapDataGettable?, Error>) -> Void)
  func postScrapBtnTapped(postId: Int, completion: @escaping (Result<ScrapBtnDataGettable?, Error>) -> Void)

}

extension BaseService: ScrapService {
  func getScrapList(lastId: Int? = nil, sort: FilterSortCase, completion: @escaping (Result<ScrapDataGettable?, Error>) -> Void) {
    requestObject(.getScrapList(lastScrapId: lastId, sort: sort.rawValue),completion: completion)
  }
  
  func postScrapBtnTapped(postId: Int, completion: @escaping (Result<ScrapBtnDataGettable?, Error>) -> Void) {
    requestObject(.postScrapBtn(postId: postId), completion: completion)
  }
}

