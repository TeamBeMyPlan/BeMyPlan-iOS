//
//  PlanPreviewRepository.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation
import RxSwift
import RxRelay

protocol PlanPreviewRepository {
  func fetchPreviewData(idx: Int) -> Observable<(PlanPreview.HeaderData?,PlanPreview.BodyData?)>
}

final class DefaultPlanPreviewRepository {
  
  private let networkService: PlanPreviewServiceType
  private let disposeBag = DisposeBag()
  
  init(service : PlanPreviewServiceType){
    self.networkService = service
  }
}

extension DefaultPlanPreviewRepository: PlanPreviewRepository {
  func fetchPreviewData(idx: Int) -> Observable<(PlanPreview.HeaderData?,PlanPreview.BodyData?)>{
    return .create { observer in
      self.networkService.fetchPlanPreviewData(idx: idx)
        .subscribe(onNext: { entity in
          guard let entity = entity else {return observer.onCompleted()}
          let headerDataModel = entity.toHeaderDomain()
          let bodyDataModel = PlanPreviewEntity.toBodyDomain(body: entity.previewContents)

          observer.onNext((headerDataModel,bodyDataModel))
        }, onError: { err in
          observer.onError(err)
        })
        .disposed(by: self.disposeBag)
      return Disposables.create()
    }
  }

}
