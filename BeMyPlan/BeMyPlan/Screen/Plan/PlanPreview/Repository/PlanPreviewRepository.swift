//
//  PlanPreviewRepository.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation

protocol PlanPreviewRepository {
  var networkError: ((Error) -> Void)? { get set }
  func fetchHeaderData(idx: Int,onCompleted: @escaping (PlanPreview.HeaderData?,PlanPreview.DescriptionData?,Int,Int) -> Void)
  func fetchBodyData(idx: Int,onCompleted: @escaping ([PlanPreview.PhotoData]?,PlanPreview.SummaryData?) -> Void)
}

final class DefaultPlanPreviewRepository: PlanPreviewRepository {
  
  // MARK: - Outputs
  var networkError: ((Error) -> Void)?
  
  // MARK: - Dependency
  private let networkService: PlanPreviewServiceType
  
  init(service : PlanPreviewServiceType){
    self.networkService = service
  }
  
  func fetchHeaderDataInRx(idx: Int) {
    
  }
  
  func fetchHeaderData(idx: Int,onCompleted: @escaping (PlanPreview.HeaderData?,PlanPreview.DescriptionData?,Int,Int) -> Void){
    networkService.getPlanPreviewHeaderData(idx: idx) { [weak self] result in
      guard let self = self else {return}
      result.success { entity in
        guard let entity = entity else {return}
        let headerData = PlanPreview.HeaderData.init(authorID: entity.authorID,
                                                     writer: entity.author,
                                                     title: entity.title)
      
        let descriptionData = PlanPreview.DescriptionData.init(descriptionContent: entity.dataDescription,
                                                               summary: PlanPreview.IconData.init(theme: entity.tagTheme,
                                                                                                  spotCount: String(entity.tagCountSpot),
                                                                                                  restaurantCount: String(entity.tagCountRestaurant),
                                                                                                  dayCount: String(entity.tagCountDay),
                                                                                                  peopleCase: entity.tagPartner,
                                                                                                  budget: entity.tagMoney,
                                                                                                  transport: entity.tagMobility,
                                                                                                  month: String(entity.tagMonth)))
        let price = entity.price
        let authID = entity.authorID
        onCompleted(headerData,descriptionData,price,authID)
      }.catch { error in
        self.networkError?(error)
      }
    }
  }
  
  func fetchBodyData(idx: Int,onCompleted: @escaping ([PlanPreview.PhotoData]?,PlanPreview.SummaryData?) -> Void){
    networkService.getPlanPreviewDetailData(idx: idx) { [weak self] result in
      guard let self = self else {return}
      result.success { entity in
        guard let entity = entity else {return}
          var photoList : [PlanPreview.PhotoData] = []
          for (_,item) in entity.enumerated(){
            photoList.append(PlanPreview.PhotoData.init(photo: item.photoUrls.first ?? "",
                                                        content: item.datumDescription))
        }
        onCompleted(photoList,nil)
      }.catch { error in
        self.networkError?(error)
      }
    }
  }
}
