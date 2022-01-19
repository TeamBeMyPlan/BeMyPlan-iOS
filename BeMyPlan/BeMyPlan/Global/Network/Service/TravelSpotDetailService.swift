//
//  TravelSpotDetailService.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

protocol TravelSpotDetailService {
  func getTravelSpotDetailList(area: Int, page: Int, pageSize : Int, sort : String, completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void)
  func getNicknameDetailList(userId: Int, page: Int, pageSize: Int, sort: String, completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void)
}

extension BaseService: TravelSpotDetailService {
  
  func getTravelSpotDetailList(area: Int, page: Int, pageSize : Int, sort : String, completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void) {
    requestObject(.getTravelSpotDetailList(area: area, page: page, pageSize: pageSize, sort : sort), completion: completion)
  }
  
  func getNicknameDetailList(userId: Int, page: Int, pageSize: Int, sort: String, completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void) {
    requestObject(.getNicknameDetailList(userId: userId, page: page, pageSize: pageSize, sort: sort), completion: completion)
  }
}
