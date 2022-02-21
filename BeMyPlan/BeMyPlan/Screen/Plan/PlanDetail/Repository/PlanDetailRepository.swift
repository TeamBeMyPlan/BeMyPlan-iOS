//
//  PlanDetailRepository.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/02/22.
//

import Foundation

protocol PlanDetailRepositoryInterface {
  var networkError: ((Error) -> Void)? { get set }
  func fetchPlanDetailData(idx: Int,onCompleted: @escaping (String,String,Int, [[PlanDetailDataEntity.SpotData?]]) -> Void)
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
  func fetchPlanDetailData(idx: Int, onCompleted: @escaping (String,String,Int, [[PlanDetailDataEntity.SpotData?]]) -> Void) {
    networkService.getPlanDetailData(idx: idx) { [weak self] result in
      guard let self = self else {return}
      result.success { entity in
        guard let entity = entity else {return}
        let title = entity.title
        let writer = entity.author
        let totalDays = entity.totalDays
        let spots = entity.spots
        onCompleted(title,writer,totalDays,spots)
      }.catch { error in
        self.networkError?(error)
      }
    }
  }
}
