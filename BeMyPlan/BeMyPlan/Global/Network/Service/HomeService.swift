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
  // FIXME: - Legacy APIs
  func getPlanAllinOneList(area:Int?, userId: Int?,
                           page : Int, pageSize : Int,
                           sort : String,
                           viewCase : TravelSpotDetailType,completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  func getPopularTravelList(completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void)
  func getNewTravelList(page: Int, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  func getSuggestTravelList(page: Int, sort: String, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  
  // 새로 배포된 서버 기준 API
  func getHomeOrderSortList(completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  func getHomeRecentSortList(completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  func getHomeBemyPlanSortList(completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
}

extension BaseService : HomeServiceType ,TravelSpotDetailService{
  // area , userId,
  func getPlanAllinOneList(area:Int?, userId: Int?,
                           page : Int, pageSize : Int = 5,
                           sort : String,
                           viewCase : TravelSpotDetailType,completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
  
    switch(viewCase){
    case .travelspot:
      if let area = area {
        requestObject(.getTravelSpotDetailList(area: area, page: page, pageSize: pageSize, sort : sort), completion: completion)
      }
      
    case .nickname:
      if let userId = userId {
        requestObject(.getNicknameDetailList(userId: userId, page: page, pageSize: pageSize, sort: sort), completion: completion)
      }
      
    case .recently:
      requestObject(.getNewTravelList(page: page), completion: completion)

    case .bemyPlanRecommend:
      requestObject(.getSuggestTravelList(page: page, sort: sort), completion: completion)
    }
  }
  
  func getPopularTravelList(completion: @escaping (Result<[HomeListDataGettable.Item]?, Error>) -> Void) {
    requestObject(.getPopularTravelList, completion: completion)
  }
  func getNewTravelList(page: Int, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getNewTravelList(page: page), completion: completion)
  }
  func getSuggestTravelList(page: Int, sort: String, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getSuggestTravelList(page: page, sort: sort), completion: completion)
  }
  
  func getTravelSpotDetailList(area: Int, page: Int, pageSize : Int, sort : String, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getTravelSpotDetailList(area: area, page: page, pageSize: pageSize, sort : sort), completion: completion)
  }
  
  func getNicknameDetailList(userId: Int, page: Int, pageSize: Int, sort: String, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getNicknameDetailList(userId: userId, page: page, pageSize: pageSize, sort: sort), completion: completion)
  }
  
  func getHomeOrderSortList(completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getHomeOrderList, completion: completion)
  }
  
  func getHomeRecentSortList(completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getHomeRecentlyList, completion: completion)
  }
  
  func getHomeBemyPlanSortList(completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getHomeBemyPlanList, completion: completion)
  }

}
