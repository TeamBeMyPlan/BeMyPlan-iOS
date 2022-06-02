//
//  PlanListService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/02.
//

import Foundation

protocol PlanListServiceType{
  
  func getRecentlyListWithPagination(lastId: Int?,
                               completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  
  func getBemyPlanListWithPagination(lastId: Int?,
                                     completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  
  func getTravelSpotListWithPagination(spot: TravelSpotList, sortCase: FilterSortCase,lastId: Int?,
                                       completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  
  func getUserPlanListWithPagination(userID: Int, sortCase: FilterSortCase,lastId: Int?,
                                     completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  
}

extension BaseService: PlanListServiceType {
  func getRecentlyListWithPagination(lastId: Int?, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getRecentlyListWithPaging(lastPlanID: lastId),
                  completion: completion)
  }
  
  func getBemyPlanListWithPagination(lastId: Int?, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getBemyPlanListWithPaging(lastPlanID: lastId),
                  completion: completion)
  }
  
  func getTravelSpotListWithPagination(spot: TravelSpotList, sortCase: FilterSortCase, lastId: Int?, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getSpotPlanListWithPaging(spotName: spot.rawValue, lastPlanID: lastId, sortCase: sortCase.rawValue),
                  completion: completion)

  }
  
  func getUserPlanListWithPagination(userID: Int, sortCase: FilterSortCase, lastId: Int?, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(.getUserPlanListWithPaging(userID: userID, lastPlanID: lastId, sortCase: sortCase.rawValue),
                  completion: completion)
  }
}
