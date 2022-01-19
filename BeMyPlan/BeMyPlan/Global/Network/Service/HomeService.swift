//
//  HomeService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/17.
//

import Foundation

/// - Note
///  진행순서
///  1. 각 화면에 맞게 ___Service.swift 파일을 만든다.
///  2. ____ServiceType 프로토콜을 만든다.
///  --> 이 프로토콜은 각각 어떤 작업이 진행될지 정의해놓는 부분입니다.
///

protocol HomeServiceType{
  func getPopularTravelList(completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void)
  func getNewTravelList(page: Int, completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void)
  func getSuggestTravelList(page: Int, sort: String, completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void)
}

extension BaseService : HomeServiceType {
  func getPopularTravelList(completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void) {
    requestObject(.getPopularTravelList, completion: completion)
  }
  func getNewTravelList(page: Int, completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void) {
    requestObject(.getNewTravelList(page: page), completion: completion)
  }
  func getSuggestTravelList(page: Int, sort: String, completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void) {
    requestObject(.getSuggestTravelList(page: page, sort: sort), completion: completion)
  }
}
