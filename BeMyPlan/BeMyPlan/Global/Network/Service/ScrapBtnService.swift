//
//  ScrapBtnService.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation


protocol ScrapBtnService {
//  func postScrapBtnTapped(postId: Int, userId: Int, completion: @escaping (Result<[ScrapBtnDataGettable]?, Error>) -> Void)
  func postScrapBtnTapped(postId: Int, completion: @escaping (Result<[ScrapBtnDataGettable]?, Error>) -> Void)
}

extension BaseService: ScrapBtnService {
//  func postScrapBtnTapped(postId: Int, userId: Int, completion: @escaping (Result<[ScrapBtnDataGettable]?, Error>) -> Void) {
//    requestObject(.postScrapBtn(postId: postId, userId: userId), completion: completion)
//  }
  func postScrapBtnTapped(postId: Int, completion: @escaping (Result<[ScrapBtnDataGettable]?, Error>) -> Void) {
    requestObject(.postScrapBtn(postId: postId), completion: completion)
  }
}
