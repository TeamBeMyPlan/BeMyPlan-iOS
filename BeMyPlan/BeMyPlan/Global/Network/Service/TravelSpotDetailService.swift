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


