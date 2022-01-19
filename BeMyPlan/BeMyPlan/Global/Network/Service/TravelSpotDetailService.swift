//
//  TravelSpotDetailService.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/18.
//

import Foundation

protocol TravelSpotDetailService {
  func getTravelSpotDetailList(area: Int, page: Int, sort : String, completion: @escaping (Result<TravelSpotDetailDataGettable?, Error>) -> Void)
}

extension BaseService: TravelSpotDetailService {
  func getTravelSpotDetailList(area: Int, page: Int, sort : String, completion: @escaping (Result<TravelSpotDetailDataGettable?, Error>) -> Void) {
    requestObject(.getTravelSpotDetailList(area: area, page: page, sort : sort), completion: completion)
  }  
}
