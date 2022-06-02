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
  
  func getTravelSpotListWithPagination(spot: String, sortCase: FilterSortCase,lastId: Int?,
                                       completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  
  func getUserPlanListWithPagination(userID: Int, sortCase: FilterSortCase,lastId: Int?,
                                     completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void)
  
}

extension BaseService: PlanListServiceType {
  func getRecentlyListWithPagination(lastId: Int?, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    requestObject(<#T##target: BaseAPI##BaseAPI#>, completion: <#T##(Result<Decodable?, Error>) -> Void#>)
  }
  
  func getBemyPlanListWithPagination(lastId: Int?, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    <#code#>
  }
  
  func getTravelSpotListWithPagination(spot: String, sortCase: FilterSortCase, lastId: Int?, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    <#code#>
  }
  
  func getUserPlanListWithPagination(userID: Int, sortCase: FilterSortCase, lastId: Int?, completion: @escaping (Result<HomeListDataGettable?, Error>) -> Void) {
    <#code#>
  }
  

}
