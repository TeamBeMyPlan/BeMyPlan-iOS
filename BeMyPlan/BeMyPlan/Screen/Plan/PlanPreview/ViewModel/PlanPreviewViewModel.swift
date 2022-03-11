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

  // MARK: - Inputs

  struct Input {
    let viewDidLoadEvent: Observable<Void>
    let buyButtonDidTapEvent: Observable<Void>
    let viewPreviewButtonDidTapEvent: Observable<Void>
  }

  // MARK: - Outputs

  struct Output {
    var didFetchDataStart: Driver<Void>
    var didFetchDataFinished = PublishRelay<Void>()
    var didUpdatePriceData = PublishRelay<String>()
    var successScrap = PublishRelay<Void>()
    var networkError = PublishRelay<Void>()
    var unexpectedError = PublishRelay<Void>()
    var movePaymentView = PublishRelay<Void>()
    var movePreviewDetailView = PublishRelay<Void>()
  }

  var disposeBag = DisposeBag()
//  let input: Input?
//  let output: Output?

  // MARK: - Outputs


  // MARK: - Models


  var headerData : PlanPreview.HeaderData?
  var descriptionData : PlanPreview.DescriptionData?
  var photoData : [PlanPreview.PhotoData]?
  var summaryData : PlanPreview.SummaryData?
  var recommendData : PlanPreview.RecommendData?
  var contentList : [PlanPreview.ContentList] = []
  var photoList:[UIImage] = []
  var heightList:[CGFloat] = []
  var authID : Int = 0

  // MARK: - Dependency 주입

  private var repository: PlanPreviewRepository
  let postId: Int

  init(repository: PlanPreviewRepository,postId: Int){
    self.repository = repository
    self.postId = postId
  }
}

extension PlanPreviewViewModel{

//  func transform(input: Input) -> Output {
////    let output = Output()
//
//    input.viewDidLoadEvent
//      .subscribe(onNext: { [weak self] in
//        output.didFetchDataStart
//      })
//      .disposed(by: disposeBag)
//
//  }

  func viewDidLoad() {
//    output.didFetchDataStart?()
//    fetchData()
//    bindRepository()
  }

  func clickScrap() {

  }

  func clickBuyButton() {
//    output.movePaymentView?()
  }

  func clickPreviewButton() {
//    output.movePreviewDetailView?()
  }

  func clickPreviewImage(index: Int) {

  }

  func showContentPage() {

  }
}

// MARK: - Logics
extension PlanPreviewViewModel {
//  func fetchData(){
////    output.didFetchDataStart?()
//
//    let group = DispatchGroup()
//    group.enter()
//    fetchHeaderData() { group.leave() }
//    group.enter()
//    fetchBodyData() { group.leave() }
//    group.notify(queue: .main){
//      self.setContentList()
////      self.output.didFetchDataFinished?()
//    }
//  }
//
//  func bindRepository(){
//    repository.networkError = { [weak self] err in
//      if let error = err as? MoyaError{
//        if error.response?.statusCode == 500{
////          self?.output.networkError?()
//        }else{
////          self?.output.unexpectedError?()
//        }
//      }
//    }
//  }
//
//  private func fetchHeaderData(completion: @escaping () -> (Void)) {
//    repository.fetchHeaderData(idx: postId) { [weak self] header, description, price, authID in
//      self?.headerData = header
//      self?.descriptionData = description
//      let priceString = String(price) + "원"
//      self?.output.didUpdatePriceData?(priceString)
//      self?.authID = authID
//      completion()
//    }
//  }
//
//  private func fetchBodyData(completion: @escaping () -> (Void)){
//    repository.fetchBodyData(idx: postId)
//    { [weak self] photoList, summary in
//      guard let self = self else {return}
//      self.photoData = photoList
//      self.summaryData = summary
//      if let photoList = photoList {
//        self.generateImages(photoData: photoList) { imgList in
//          self.photoList = imgList
//          self.makeImageHeight(images: imgList) { heightList in
//            self.heightList = heightList
//            completion()
//          }
//        }
//      }
//    }
//  }
//
//  private func setContentList(){
//    contentList.removeAll()
//    if let _ = headerData { contentList.append(.header) }
//    if let _ = descriptionData{ contentList.append(.description) }
//    if let photo = photoData{
//      for (_,_) in photo.enumerated(){
//        contentList.append(.photo)
//      }
//    }
//    if let _ = summaryData  { contentList.append(.summary) }
//    contentList.append(.recommend)
//  }
//
//  private func generateImages(photoData:[PlanPreview.PhotoData],
//                              completion: @escaping ([UIImage]) -> Void){
//    var imgCount = 0 {didSet{
//      if imgCount == photoData.count {completion(imageContainer) }}
//    }
//    var imageContainer = Array(repeating: UIImage(), count: photoData.count)
//    _ = photoData.enumerated().map { (index,data) in
//      let imgView = UIImageView()
//      imgView.setImage(with: data.photo) { image in
//        imageContainer[index] = image ?? UIImage()
//        imgCount += 1
//      }
//    }
//  }
//
//  private func makeImageHeight(images: [UIImage], completion: @escaping ([CGFloat]) -> Void){
//    let imageViewWidth = screenWidth - 48
//    var heightList:[CGFloat] = [] {didSet{
//      if heightList.count == images.count {
//        completion(heightList) }
//    }}
//    for (_,img) in images.enumerated(){
//      let ratio = img.size.width / img.size.height
//      let newHeight = imageViewWidth / ratio
//      heightList.append(newHeight)
//    }
//
//  }
}
