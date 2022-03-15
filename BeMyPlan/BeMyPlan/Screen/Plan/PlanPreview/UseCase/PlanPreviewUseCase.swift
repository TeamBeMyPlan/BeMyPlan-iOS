//
//  PlanPreviewUseCase.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/10.
//

import RxSwift

protocol PlanPreviewUseCase{
  func fetchPlanPreviewData()

  var contentData: PublishSubject<PlanPreview.ContentData> { get set }
  var contentIndexListData: PublishSubject<[PlanPreview.ContentList]> { get set }
  var imageHeightData: PublishSubject<[CGFloat]> { get set }
}

final class DefaultPlanPreviewUseCase {
  
  private let repository: PlanPreviewRepository
  private let postIdx: Int
  private let disposeBag = DisposeBag()
  private let imageSizeFetcher = ImageSizeFetcher()
  
  var contentData = PublishSubject<PlanPreview.ContentData>()
  var contentIndexListData = PublishSubject<[PlanPreview.ContentList]>()
  var imageHeightData = PublishSubject<[CGFloat]>()
  
  init(repository: PlanPreviewRepository,postIdx: Int){
    self.repository = repository
    self.postIdx = postIdx
  }
}

extension DefaultPlanPreviewUseCase: PlanPreviewUseCase {
  func fetchPlanPreviewData() {
    let header = self.repository.fetchHeaderData(idx: self.postIdx)
    let body = self.repository.fetchBodyData(idx: self.postIdx)
    
    Observable.combineLatest(header,
                             body, resultSelector: { (headerData,bodyData) -> PlanPreview.ContentData in
      self.calculateImageHeight(bodyData: bodyData)
      return PlanPreview.ContentData.init(headerData: headerData,
                                   bodyData: bodyData)
    }).subscribe { result in
      if let content = result.element{
        self.setContentIndexList(contentData: content)
        self.contentData.onNext(content)
      }
    }.disposed(by: self.disposeBag)

  }

  private func calculateImageHeight(bodyData: PlanPreview.BodyData?) {
    guard let bodyData = bodyData else {
      self.imageHeightData.onCompleted()
      return
    }
    
    var heightList = [CGFloat](repeating: 0, count: bodyData.photos.count)
    var count = 0
    let imageViewWidth = screenWidth - 48
    _ = bodyData.photos.enumerated().map { index,imageUrls -> Void in
      guard let url = URL(string: imageUrls.photo) else { return }
      self.imageSizeFetcher.sizeFor(atURL: url) { err, result in
        guard let _ = err else { return }
        guard let result = result else { return}
        let ratio = result.size.width / result.size.height
        let heightForDevice = imageViewWidth / ratio
        heightList[index] = heightForDevice
        count += 1
        if count == bodyData.photos.count {
          self.imageHeightData.onNext(heightList)
        }
      }
    }
  }
  
  private func setContentIndexList(contentData: PlanPreview.ContentData) {
    var contentList: [PlanPreview.ContentList] = []
    if let _ = contentData.headerData {
      contentList.append(.header)
      contentList.append(.description)
    }
    
    if let body = contentData.bodyData{
      for _ in body.photos {
        contentList.append(.photo)
      }
      
      if let _ = body.summary {
        contentList.append(.summary)
      }
    }
    contentIndexListData.onNext(contentList)
  }
  
}
