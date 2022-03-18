//
//  PlanPreviewUseCase.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/10.
//

import RxSwift
import ImageIO
import Accelerate


struct ImageHeightProcessResult {
  var value: CGFloat
  var `case`: ProcessResult
  
  enum ProcessResult{
    case empty
    case valueExist
    case invalidURL
    case calculateHeightFail
  }
  
  init(case: ProcessResult = .valueExist, value: CGFloat = 0) {
    self.value = value
    self.case = `case`
  }
}

protocol PlanPreviewUseCase{
  func fetchPlanPreviewData()
  var contentData: PublishSubject<PlanPreview.ContentData> { get set }
  var imageHeightData: PublishSubject<[ImageHeightProcessResult]> { get set }
}

final class DefaultPlanPreviewUseCase {
  
  private let repository: PlanPreviewRepository
  private let postIdx: Int
  private let disposeBag = DisposeBag()
  private let imageSizeFetcher = ImageSizeFetcher()
  
  var contentData = PublishSubject<PlanPreview.ContentData>()
  var imageHeightData = PublishSubject<[ImageHeightProcessResult]>()
  
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
    var count = 0 {
      didSet{
        if count == bodyData.photos.count * 2 {
          print("KKKK")
          dump(heightList)
          self.imageHeightData.onNext(heightList)
        }
      }
    }
    var heightList = [ImageHeightProcessResult](repeating: .init(case: .empty), count: bodyData.photos.count)
                                            
    let imageViewWidth = screenWidth - 48
    
    _ = bodyData.photos.enumerated().map { index,imageUrls -> Void in
      guard let url = URL(string: imageUrls.photoUrl) else { return }
      self.imageSizeFetcher.sizeFor(atURL: url) { err, result in
        
        print("==========RESULT",result)
        print("=========err",err)
        if let error = err as? ImageParserErrors {
          switch(error){
            case .unsupportedFormat:
              if heightList[index].case != .valueExist {
                heightList[index] = .init(case: .calculateHeightFail)
              }
              default:
              if heightList[index].case != .valueExist {
                heightList[index] = .init(case: .calculateHeightFail)
              }
          }
        } else {
          if let result = result {
            let ratio = result.size.width / result.size.height
            let heightForDevice = imageViewWidth / ratio
            heightList[index] = .init(value: heightForDevice)
          }else{
            if heightList[index].case != .valueExist {
              heightList[index] = .init(case: .invalidURL)
            }
          }
        }
        count += 1
      }
    }
  }
  
  func sizeOfImageAt(url: URL) -> CGSize? {
      // with CGImageSource we avoid loading the whole image into memory
      guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
          return nil
      }
      
      let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
      guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
          return nil
      }
      
      if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
         let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
          return CGSize(width: width, height: height)
      } else {
          return nil
      }
  }

}
