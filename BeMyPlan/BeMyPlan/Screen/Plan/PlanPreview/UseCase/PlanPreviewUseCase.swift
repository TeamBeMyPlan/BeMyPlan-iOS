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
  var imageHeightData: PublishSubject<[CGFloat]> { get set }
}

final class DefaultPlanPreviewUseCase {
  
  private let repository: PlanPreviewRepository
  private let postIdx: Int
  private let disposeBag = DisposeBag()
  private let imageSizeFetcher = ImageSizeFetcher()
  
  var contentData = PublishSubject<PlanPreview.ContentData>()
  var imageHeightData = PublishSubject<[CGFloat]>()
  
  init(repository: PlanPreviewRepository,postIdx: Int){
    self.repository = repository
    self.postIdx = postIdx
  }
}

extension DefaultPlanPreviewUseCase: PlanPreviewUseCase {
  func fetchPlanPreviewData() {
    print("fetchPlanPreviewData")
    let header = self.repository.fetchHeaderData(idx: self.postIdx)
    let body = self.repository.fetchBodyData(idx: self.postIdx)
    
    Observable.combineLatest(header,
                             body, resultSelector: { (headerData,bodyData) -> PlanPreview.ContentData in
      self.calculateImageHeight(bodyData: bodyData)
      return PlanPreview.ContentData.init(headerData: headerData,
                                   bodyData: bodyData)
    }).subscribe { result in
      if let content = result.element{
        print("CHECKUSECASE - content",content)
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
      guard let url = URL(string: imageUrls.photoUrl) else { return }
      self.imageSizeFetcher.sizeFor(atURL: url) { err, result in
        print("INDEX:",index)
        print("=====================")
        print("ERR",err)
        print("=====================")
        print("result",result)
        print("=====================")
        if let result = result {
          let ratio = result.size.width / result.size.height
          let heightForDevice = imageViewWidth / ratio
          heightList[index] = heightForDevice
          count += 1
        }
        if count == bodyData.photos.count {
          print("CHECKUSECASE - HEIGHT",heightList)
          self.imageHeightData.onNext(heightList)
        }

      }
    }
  }

}
