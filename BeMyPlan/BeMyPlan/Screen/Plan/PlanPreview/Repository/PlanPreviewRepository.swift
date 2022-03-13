//
//  PlanPreviewRepository.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation
import RxSwift

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
  
  func fetchHeaderDataInRx(idx: Int) -> Observable<PlanPreview.HeaderData>{
    return .create { observer in
      self.networkService.fetchPlanPreviewHeaderData(idx: idx)
        .subscribe(onNext: { entity in
          guard let entity = entity else {return observer.onCompleted()}
          let dto = entity.toDomain()
          observer.onNext(dto)
        }, onError: { err in
          observer.onError(err)
        })
    }
  }
  
  func fetchBodyDataInRx(idx: Int) -> Observable<PlanPreview.Body> {
    return .create { observer in
      self.networkService.fetchPlanPreviewHeaderData(idx: idx)
        .subscribe(onNext: { entity in
          guard let entity = entity else {return observer.onCompleted()}
          let dto = entity.toDomain()
          observer.onNext(dto)
        }, onError: { err in
          observer.onError(err)
        })
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
