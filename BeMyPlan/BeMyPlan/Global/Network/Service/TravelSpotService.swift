//
//  TravelSpotService.swift
//  BeMyPlan
//
//  Created by ์กฐ์์ on 2022/01/18.
//

import Foundation

protocol TravelSpotService {
  func getTravelSpotList(completion: @escaping (Result<[TravelSpotDataGettable]?, Error>) -> Void)
}

extension BaseService: TravelSpotService {
  func getTravelSpotList(completion: @escaping (Result<[TravelSpotDataGettable]?, Error>) -> Void) {
    requestObject(.getTravelSpotList, completion: completion)
  }
}
