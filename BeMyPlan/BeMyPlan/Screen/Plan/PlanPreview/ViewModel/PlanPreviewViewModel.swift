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

//protocol PlanPreviewViewModelType : ViewModelType{
//
//  // Inputs
//  func viewDidLoad()
//  func clickScrap()
//  func clickBuyButton()
//  func clickPreviewButton()
//  func clickPreviewImage(index : Int)
//  func showContentPage()
//
//  // Outputs
//  var didFetchDataStart: (() -> Void)? { get set }
//  var didFetchDataFinished: (() -> Void)? { get set }
//  var didUpdatePriceData : ((String) -> Void)? { get set }
//  var successScrap: (() -> Void)? { get set }
//  var networkError: (() -> Void)? { get set }
//  var unexpectedError: (() -> Void)? { get set }
//  var movePaymentView: (() -> Void)? { get set }
//  var movePreviewDetailView: (( ) -> Void)? { get set }
//}

final class PlanPreviewViewModel : ViewModelType{

  private let previewUseCase: PlanPreviewUseCase
  private let disposeBag = DisposeBag()

  // MARK: - Inputs

  struct Input {
    let viewDidLoadEvent: Observable<Void>
//    let buyButtonDidTapEvent: Observable<Void>
//    let backButtonDidTapEvent: Observable<Void>
//    let viewPreviewButtonDidTapEvent: Observable<Void>
  }

  // MARK: - Outputs

  struct Output {
    var didFetchDataFinished = BehaviorRelay<Bool>(value: false)
    var contentData = PublishRelay<PlanPreview.ContentData>()
    var contentlistData = PublishRelay<[PlanPreview.ContentList]>()
    var heightList = PublishRelay<[CGFloat]>()
    var priceData = BehaviorRelay<String>(value: "")
  }
  
  init(useCase: PlanPreviewUseCase){
    self.previewUseCase = useCase
  }

}

extension PlanPreviewViewModel{
  
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    
    print("transForm")
    input.viewDidLoadEvent
      .subscribe(onNext: { [weak self] in
        print("viewDidLoadEventLoad")
        self?.previewUseCase.fetchPlanPreviewData()
      })
      .disposed(by: disposeBag)

    return output
  }
  
  private func bindOutput(output: Output,
                          disposeBag: DisposeBag) {
    let contentDataRelay = previewUseCase.contentData
    let contentDataIndexRelay = previewUseCase.contentIndexListData
    let imageHeightListRelay = previewUseCase.imageHeightData
    
    Observable.combineLatest(contentDataRelay, contentDataIndexRelay,imageHeightListRelay) { (content, indexList, heightList) in
      print("ViewModel Combine Complete",content,indexList,heightList)
      output.contentData.accept(content)
      output.contentlistData.accept(indexList)
      output.heightList.accept(heightList)
    }.subscribe { _ in
      print("@@@@")
            }.disposed(by: self.disposeBag)

  }


}
