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
  func fetchPlanDetailData(idx: Int,onCompleted: @escaping (AuthorName,AuthorID,Title,TotalDays, [[PlanDetailDataGettable.SpotData?]]) -> Void)
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
  func fetchPlanDetailData(idx: Int, onCompleted: @escaping (AuthorName,AuthorID,Title,TotalDays,[[PlanDetailDataGettable.SpotData?]]) -> Void) {
    networkService.getPlanDetailData(idx: idx) { [weak self] result in
      guard let self = self else {return}
      result.success { entity in
        guard let entity = entity else {return}
        let writer = entity.user.nickname
        let authorID = entity.user.userID
        let title = entity.title
        let totalDays = entity.contents.count
        self.networkService.getPlanTransportData(idx: idx) { transportResult in
          transportResult.success { transportEntity in
            guard let transportEntity = transportEntity else { return }
            let spots = self.getPlanDetailSpotData(entity, transportEntity)
            onCompleted(writer,authorID,title,totalDays,spots)
          }.catch { err in self.networkError?(err) }
        }
      }.catch { error in
        self.networkError?(error)
      }
    }
  }
  
  private func getPlanDetailSpotData(_ detailEntity: PlanDetailDataEntity,
                                     _ transportEntity: [PlanDetailTransportEntity]) -> [[PlanDetailDataGettable.SpotData?]] {
    let detailContents = detailEntity.contents
    guard detailContents.count == transportEntity.count else { return [] }
    var result: [[PlanDetailDataGettable.SpotData?]] = []
    
    for (contentIndex,content) in detailContents.enumerated() {
      var spotDataList: [PlanDetailDataGettable.SpotData?] = []
      
      for (spotIndex,spot) in content.spots.enumerated() {
        let spot = PlanDetailDataGettable.SpotData.init(title: spot.name,
                                                        spotDescription: makeDescription(tip: spot.tip, review: spot.review),
                                                        photoUrls: spot.images.map { return $0.url.replacingOccurrences(of: "\r", with: "") },
                                                        address: "",
                                                        latitude: spot.latitude,
                                                        longitude: spot.longitude,
                                                        nextSpotMobility: makeNextSpotMobility(spotIndex: spotIndex,
                                                                                               transportInfo: transportEntity[contentIndex].infos),
                                                 nextSpotRequiredTime: makeNextSpotRequiredTime(spotIndex: spotIndex,
                                                                                            transportInfo: transportEntity[contentIndex].infos))
        spotDataList.append(spot)
      }
      result.append(spotDataList)
    }
    return result
  }
  
  private func makeDescription(tip: String, review: String) -> String {
    return tip.replacingOccurrences(of: "\\n", with: "")
    + "\n\n"
    + review.replacingOccurrences(of: "\\n", with: "")
  }
                                                                                                              
  private func makeNextSpotMobility(spotIndex: Int,transportInfo: [TransportInfo]) -> String {
    if spotIndex == transportInfo.count { return "" }
    else { return transportInfo[spotIndex].mobility}
  }
  
  private func makeNextSpotRequiredTime(spotIndex: Int, transportInfo: [TransportInfo]) -> String {
    if spotIndex == transportInfo.count { return "" }
    else { return String(transportInfo[spotIndex].spentMinute) }
  }
}
