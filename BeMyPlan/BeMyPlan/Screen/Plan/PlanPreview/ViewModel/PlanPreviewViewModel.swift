//
//  PlanPreviewViewModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/29.
//

import Foundation
import Moya

protocol PlanPreviewViewModelType : ViewModelType{
  
  // Inputs
  func viewDidLoad()
  func clickScrap()
  func clickBuyButton()
  func clickPreviewButton()
  func clickPreviewImage(index : Int)
  func showContentPage()

  // Outputs
  var didFetchDataStart: (() -> Void)? { get set }
  var didFetchDataFinished: (() -> Void)? { get set }
  var didUpdatePriceData : ((String) -> Void)? { get set }
  var successScrap: (() -> Void)? { get set }
  var networkError: (() -> Void)? { get set }
  var unexpectedError: (() -> Void)? { get set }
  var movePaymentView: (() -> Void)? { get set }
  var movePreviewDetailView: (( ) -> Void)? { get set }
}

class PlanPreviewViewModel : PlanPreviewViewModelType{
  
  // MARK: - Outputs
  var didFetchDataStart: (() -> Void)?
  var didFetchDataFinished: (() -> Void)?
  var didUpdatePriceData: ((String) -> Void)?
  var successScrap: (() -> Void)?
  var networkError: (() -> Void)?
  var unexpectedError: (() -> Void)?
  var movePaymentView: (() -> Void)?
  var movePreviewDetailView: (( ) -> Void)?
  
  // MARK: - Models
  
  var headerData : PlanPreview.HeaderData?
  var descriptionData : PlanPreview.DescriptionData?
  var photoData : [PlanPreview.PhotoData]?
  var summaryData : PlanPreview.SummaryData?
  var recommendData : PlanPreview.RecommendData?
  var contentList : [PlanPreview.ContentList] = []
  var authID : Int = 0
  
  // MARK: - Dependency 주입
  private var repository: PlanPreviewRepositoryInterface
  let postId: Int
  
  init(postId: Int,repository: PlanPreviewRepositoryInterface){
    self.postId = postId
    self.repository = repository
  }
}

extension PlanPreviewViewModel{
  func viewDidLoad() {
    didFetchDataStart?()
    fetchData()
    bindRepository()
  }
  
  func clickScrap() {
     
  }
  
  func clickBuyButton() {
     movePaymentView?()
  }
  
  func clickPreviewButton() {
     movePreviewDetailView?()
  }
  
  func clickPreviewImage(index: Int) {
     
  }
  
  func showContentPage() {
     
  }
}

// MARK: - Logics
extension PlanPreviewViewModel {
  func fetchData(){
    didFetchDataStart?()
    let group = DispatchGroup()
    group.enter()
    fetchHeaderData() { group.leave() }
    group.enter()
    fetchBodyData() { group.leave() }
    
    group.notify(queue: .main){
      self.setContentList()
      self.didFetchDataFinished?()
    }
  }
  
  func bindRepository(){
    repository.networkError = { [weak self] err in
      if let error = err as? MoyaError{
        if error.response?.statusCode == 500{
          self?.networkError?()
        }else{
          self?.unexpectedError?()
        }
      }
    }
  }
  
  private func fetchHeaderData(completion: @escaping () -> (Void)) {
    repository.fetchHeaderData(idx: postId) { [weak self] header, description, price, authID in
      self?.headerData = header
      self?.descriptionData = description
      let priceString = String(price) + "원"
      self?.didUpdatePriceData?(priceString)
      self?.authID = authID
      completion()
    }
  }
  
  private func fetchBodyData(completion: @escaping () -> (Void)){
    repository.fetchBodyData(idx: postId)
    { [weak self] photoList, summary in
      self?.photoData = photoList
      self?.summaryData = summary
      completion()
    }
  }
  
  private func setContentList(){
    contentList.removeAll()
    if let _ = headerData { contentList.append(.header) }
    if let _ = descriptionData{ contentList.append(.description) }
    if let photo = photoData{
      for (_,_) in photo.enumerated(){
        contentList.append(.photo)
      }
    }
    if let _ = summaryData  { contentList.append(.summary) }
    contentList.append(.recommend)
//    if let _ = recommendData { contentList.append(.recommend) }
    print("contentLIST",contentList)
  }
  
}
