//
//  PlanDetailRepository.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/02/22.
//

import Foundation

typealias AuthorName = String
typealias AuthorID = Int
typealias Title = String
typealias TotalDays = Int

protocol PlanDetailRepositoryInterface {
  var networkError: ((Error) -> Void)? { get set }
  func fetchPlanDetailData(idx: Int,onCompleted: @escaping (AuthorName,AuthorID,Title,TotalDays, [[PlanDetailDataEntity.SpotData?]]) -> Void)
}

final class PlanDetailRepository: PlanDetailRepositoryInterface {
  
  // MARK: - Outputs
  var networkError: ((Error) -> Void)?
  private let networkService: PlanDetailServiceType
  
  // MARK: - Dependency
  init(service: PlanDetailServiceType) {
    self.networkService = service
  }
}

// MARK: - Methods
extension PlanDetailRepository {
  func fetchPlanDetailData(idx: Int, onCompleted: @escaping (AuthorName,AuthorID,Title,TotalDays,[[PlanDetailDataEntity.SpotData?]]) -> Void) {
    networkService.getPlanDetailData(idx: idx) { [weak self] result in
      guard let self = self else {return}
      result.success { entity in
        guard let entity = entity else {return}
        
        let writer = entity.author
        let authorID = entity.authorID
        let title = entity.title
        let totalDays = entity.totalDays
        let spots = entity.spots
        onCompleted(writer,authorID,title,totalDays,spots)
      }.catch { error in
        self.networkError?(error)
      }
    }
  }
}

struct PlanDetailHeaderData{
  
}
