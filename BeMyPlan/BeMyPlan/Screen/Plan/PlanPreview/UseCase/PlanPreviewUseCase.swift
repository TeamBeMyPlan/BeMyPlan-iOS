//
//  PlanPreviewUseCase.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation

protocol PlanPreviewUseCaseType{
  var networkError: ((Error) -> Void)? { get set }
  func fetchHeaderData(idx: Int,onCompleted: @escaping (PlanPreview.HeaderData?,PlanPreview.DescriptionData?) -> Void)
  func fetchBodyData(idx: Int,onCompleted: @escaping ([PlanPreview.PhotoData]?,PlanPreview.SummaryData?) -> Void)
}

final class PlanPreviewUseCase: PlanPreviewUseCaseType{

  // MARK: - Outputs
  var networkError: ((Error) -> Void)?
  
  // MARK: - Dependency
  private let networkService: PlanPreviewServiceType = BaseService.default
  
  // MARK: - Methods
  
  func fetchHeaderData(idx: Int,onCompleted: @escaping (PlanPreview.HeaderData?,PlanPreview.DescriptionData?) -> Void){
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
        onCompleted(headerData,descriptionData)
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
