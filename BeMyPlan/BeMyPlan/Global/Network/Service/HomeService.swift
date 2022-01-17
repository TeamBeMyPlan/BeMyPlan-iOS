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
  func getPopularTravelList(completion: @escaping (Result<HomeData.PopularList?, Error>) -> Void)
  func getNewTravelList(completion: @escaping (Result<HomeData.NewList?, Error>) -> Void)
  func getSuggestTravelList(completion: @escaping (Result<HomeData.SuggestList?, Error>) -> Void)
}

extension BaseService : HomeServiceType {
  func getPopularTravelList(completion: @escaping (Result<HomeData.PopularList?, Error>) -> Void) {
    requestObject(.getPopularTravelList, completion: completion)
  }
  func getNewTravelList(completion: @escaping (Result<HomeData.NewList?, Error>) -> Void) {
    requestObject(.getNewTravelList, completion: completion)
  }
  func getSuggestTravelList(completion: @escaping (Result<HomeData.SuggestList?, Error>) -> Void) {
    requestObject(.getSuggestTravelList, completion: completion)
  }
}
