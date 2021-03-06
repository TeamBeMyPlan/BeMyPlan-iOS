//
//  TravelSpotDetailService.swift
//  BeMyPlan
//
//  Created by ์กฐ์์ on 2022/01/18.
//

import Foundation

protocol TravelSpotDetailService {
  func getTravelSpotDetailList(area: Int, page: Int, pageSize : Int, sort : String, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  func getNicknameDetailList(userId: Int, page: Int, pageSize: Int, sort: String, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
}
