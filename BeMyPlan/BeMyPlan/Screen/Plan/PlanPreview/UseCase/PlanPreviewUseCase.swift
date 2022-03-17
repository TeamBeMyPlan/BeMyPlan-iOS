//
//  PlanPreviewUseCase.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/10.
//

import RxSwift
import ImageIO

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
    
    var heightList = [CGFloat](repeating: 0, count: bodyData.photos.count){
      didSet {
        print("heightList",heightList)
        if !heightList.contains(0){
//          if index == 3 {
//            print("@$@!!!!!",result?.size.width,result?.size.height)
//          }
         
        print("CHECKUSECASE - HEIGHT",heightList)
        self.imageHeightData.onNext(heightList)
      }
    }}
    var count = 0
    let imageViewWidth = screenWidth - 48
    
    _ = bodyData.photos.enumerated().map { index,imageUrls -> Void in
      guard let url = URL(string: imageUrls.photoUrl) else { return }
//      let data = NSData(contentsOf: url)!
//      let source = CGImageSourceCreateWithData(data as CFData, nil)!
//      let image = CGImageSourceCreateThumbnailAtIndex(source, 0, nil)!
//      print("image",image.width,image.height)
//      let metadata = CGImageSourceCopyPropertiesAtIndex(source, 0, nil)!
//      print(metadata)
      
//      let size = sizeOfImageAt(url: url)
//      print("KKKKK",size?.width,size?.height)
//
//
      print("INDEX + URL",index,imageUrls.photoUrl)
      self.imageSizeFetcher.sizeFor(atURL: url) { err, result in
        
        
        print("INDEX:",index)
        print("=====================")
        print("ERR",err)
        print("=====================")
        print("result",result)
        print("=====================")
        
        if let error = err as? ImageParserErrors {
          switch(error){
            case .unsupportedFormat:
              if let size = self.sizeOfImageAt(url: url) {
                let ratio = size.width / size.height
                let heightForDevice = imageViewWidth / ratio
                heightList[index] = heightForDevice
              }
              default:
                print("")
          }
        } else {
          if let result = result {
            let ratio = result.size.width / result.size.height
            let heightForDevice = imageViewWidth / ratio
            heightList[index] = heightForDevice
  //
            count += 1
          }

        }

        if let result = result {

        }
//        if count == bodyData.photos.count {
////          if index == 3 {
////            print("@$@!!!!!",result?.size.width,result?.size.height)
////          }
//          print("CHECKUSECASE - HEIGHT",heightList)
//          self.imageHeightData.onNext(heightList)
//        }

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
