//
//  PlanPreviewViewModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/29.
//

import Foundation
import Moya
import RxSwift
import RxRelay
import RxCocoa

final class PlanPreviewViewModel: ViewModelType{
  
  private let previewUseCase: PlanPreviewUseCase
  private let disposeBag = DisposeBag()

  // MARK: - Inputs

  struct Input {
    let viewDidLoadEvent: Observable<Void>
    let buyButtonDidTapEvent: Observable<Void>
    let viewPreviewButtonDidTapEvent: Observable<Void>
  }

  // MARK: - Outputs

  struct Output {
    var didFetchDataFinished = BehaviorRelay<Bool>(value: false)
    var contentList = PublishRelay<[PlanPreviewContent]>()
    var heightList = PublishRelay<[CGFloat]>()
    var priceData = PublishRelay<String?>()
    var pushBuyView = PublishRelay<PaymentContentData>()
    var contentTitle = PublishRelay<String?>()
    var scrapState = BehaviorRelay<Bool>(value: false)
  }
  
  init(useCase: PlanPreviewUseCase){
    self.previewUseCase = useCase
  }
}

extension PlanPreviewViewModel{
  
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    
    input.viewDidLoadEvent
      .subscribe(onNext: { [weak self] in
        print("fetchPlanPreview")
        self?.previewUseCase.fetchPlanPreviewData()
      })
      .disposed(by: disposeBag)
    
    input.buyButtonDidTapEvent
      .subscribe(onNext: { [weak self] in
        self?.previewUseCase.getPaymentData()
        })
      .disposed(by: disposeBag)
      return output
  }
  
  private func bindOutput(output: Output,
                          disposeBag: DisposeBag) {
    let contentDataRelay = previewUseCase.contentData
    let imageHeightListRelay = previewUseCase.imageHeightData
    let postIdxRelay = previewUseCase.paymentContentData
    
    Observable.combineLatest(contentDataRelay,imageHeightListRelay) { [weak self] (content, heightList) in
      guard let self = self else {return}
      let contentData = self.generateContentData(contentData: content, heights: heightList)
      output.priceData.accept(content.headerData?.price)
      output.contentTitle.accept(content.headerData?.title)
      output.contentList.accept(contentData)
    }.subscribe { _ in
    }.disposed(by: self.disposeBag)
    
    postIdxRelay.bind(to: output.pushBuyView)
      .disposed(by: self.disposeBag)
  }
  
  private func generateContentData(contentData: PlanPreview.ContentData,
                                   heights: [ImageHeightProcessResult]) -> [PlanPreviewContent] {
    var contentList: [PlanPreviewContent] = []
    
    if let header = contentData.headerData {
      let headerData = PlanPreview.HeaderDataModel.init(writer: header.writer,
                                                        title: header.title,
                                                        authorID: header.authorID)
      let descriptionData = PlanPreview.DescriptionData.init(descriptionContent: header.descriptionContent,
                                                             summary: header.summary)
      
      contentList.append(headerData)
      contentList.append(descriptionData)
    }
    
    if let body = contentData.bodyData {
      for (index,photo) in body.photos.enumerated() {
        let photoData = PlanPreview.PhotoData.init(photoUrl: photo.photoUrl,
                                                   content: photo.content,
                                                   height: heights[index])
        contentList.append(photoData)
      }
      if let summary = body.summary{
        let summaryData = PlanPreview.SummaryData.init(content: summary.content)
        contentList.append(summaryData)
      }
    }
    let emptyRecommendData = PlanPreview.RecommendData()
    contentList.append(emptyRecommendData)
    return contentList
  }
}

struct PlanPreviewStateModel {
  let scrapState: Bool
  let planId: Int
}
