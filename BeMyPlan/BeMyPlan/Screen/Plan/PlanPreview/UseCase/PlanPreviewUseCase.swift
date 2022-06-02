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
  func getPaymentData()
  var contentData: PublishSubject<PlanPreview.ContentData> { get set }
  var imageHeightData: PublishSubject<[ImageHeightProcessResult]> { get set }
  var paymentContentData: PublishSubject<PaymentContentData> { get set }
}

final class DefaultPlanPreviewUseCase {
  
  private let repository: PlanPreviewRepository
  private let postIdx: Int
  private let disposeBag = DisposeBag()
  private let imageSizeFetcher = ImageSizeFetcher()
  private var paymentData = PaymentContentData()
  
  var contentData = PublishSubject<PlanPreview.ContentData>()
  var imageHeightData = PublishSubject<[ImageHeightProcessResult]>()
  var paymentContentData = PublishSubject<PaymentContentData>()
  
  init(repository: PlanPreviewRepository,postIdx: Int){
    self.repository = repository
    self.postIdx = postIdx
  }
}

extension DefaultPlanPreviewUseCase: PlanPreviewUseCase {

  func getPaymentData() {
    paymentContentData.onNext(paymentData)
  }
  
  func fetchPlanPreviewData() {
    let header = self.repository.fetchPreviewData(idx: self.postIdx)
    
    print("FETCH PREVIEW DATA")
    header.map { (headerData,bodyData) -> PlanPreview.ContentData in
      self.paymentData = .init(writer: headerData?.writer,
                               title: headerData?.title,
                               imgURL: bodyData?.photos.first?.photoUrl,
                               price: headerData?.price,
                               postIdx: self.postIdx)
           self.calculateImageHeight(bodyData: bodyData)
      return PlanPreview.ContentData.init(headerData: headerData,
                                   bodyData: bodyData)
    }.subscribe { result in
      print("FETCH result DATA")
      dump(result)

      if let content = result.element{
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
        print("COUNTCOUNT",count)
        if count == bodyData.photos.count {
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
