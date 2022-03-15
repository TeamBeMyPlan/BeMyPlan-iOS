//
//  PlanPreviewRepository.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import Foundation
import RxSwift

protocol PlanPreviewRepository {
  func fetchHeaderData(idx: Int) -> Observable<PlanPreview.HeaderData>
  func fetchBodyData(idx: Int) -> Observable<PlanPreview.BodyData>
}

final class DefaultPlanPreviewRepository {
  
  private let networkService: PlanPreviewServiceType
  private let disposeBag = DisposeBag()
  
  init(service : PlanPreviewServiceType){
    self.networkService = service
  }
}

extension DefaultPlanPreviewRepository: PlanPreviewRepository {
  func fetchHeaderData(idx: Int) -> Observable<PlanPreview.HeaderData>{
    return .create { observer in
      self.networkService.fetchPlanPreviewHeaderData(idx: idx)
        .subscribe(onNext: { entity in
          guard let entity = entity else {return observer.onCompleted()}
          let dto = entity.toDomain()
          observer.onNext(dto)
          observer.onCompleted()
        }, onError: { err in
          observer.onError(err)
        })
        .disposed(by: self.disposeBag)
      return Disposables.create()
    }
  }
  
  func fetchBodyData(idx: Int) -> Observable<PlanPreview.BodyData> {
    return .create { observer in
      self.networkService.fetchPlanPreviewBodyData(idx: idx)
        .subscribe(onNext: { entity in
          guard let entity = entity else {return observer.onCompleted()}
          let dto = entity.toDomain()
          observer.onNext(dto)
          observer.onCompleted()
        }, onError: { err in
          observer.onError(err)
        })
        .disposed(by: self.disposeBag)
      return Disposables.create()
    }
  }
}
