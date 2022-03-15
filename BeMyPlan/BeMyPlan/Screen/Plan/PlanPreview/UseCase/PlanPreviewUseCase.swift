//
//  PlanPreviewUseCase.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/10.
//

import RxSwift

protocol PlanPreviewUseCase{
  
}

final class DefaultPlanPreviewUseCase {
  
  private let repository: PlanPreviewRepository
  private let postIdx: Int
  private let disposeBag = DisposeBag()
  
  var contentData = PublishSubject<PlanPreview.ContentData>()
  var imageData = PublishSubject<[PlanPreview.UIImageData]>()
  
  init(repository: PlanPreviewRepository,postIdx: Int){
    self.repository = repository
    self.postIdx = postIdx
  }
}

extension DefaultPlanPreviewUseCase: PlanPreviewUseCase {
  func fetchPlanPreviewData() {
    let header = self.repository.fetchHeaderData(idx: self.postIdx)
    let body = self.repository.fetchBodyData(idx: self.postIdx)
    
    body.map { bodyData in
      let imageList = bodyData.photos.map { imageUrls in
        UIImageView().setImage(with: <#T##String#>, placeholder: <#T##String?#>, completion: <#T##((UIImage?) -> Void)?##((UIImage?) -> Void)?##(UIImage?) -> Void#>)
      }
      UIImageView().setImage(with: bodyData.,  completion: <#T##((UIImage?) -> Void)?##((UIImage?) -> Void)?##(UIImage?) -> Void#>)
    }
    
    Observable.combineLatest(header,
                             body, resultSelector: { (headerData,bodyData) in
      PlanPreview.ContentData.init(headerData: headerData,
                                   bodyData: bodyData)
    }).map { contentData in
      <#code#>
    }
  }
  
}
