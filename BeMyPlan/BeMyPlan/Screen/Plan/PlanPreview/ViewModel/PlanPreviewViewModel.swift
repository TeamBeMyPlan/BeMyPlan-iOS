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
  var didUpdatePriceData : ((Int) -> Void)? { get set }
  var successScrap: (() -> Void)? { get set }
  var networkError: (() -> Void)? { get set }
  var unexpectedError: (() -> Void)? { get set }
  
}

class PlanPreviewViewModel : PlanPreviewViewModelType{
  
  // MARK: - Outputs
  var didFetchDataStart: (() -> Void)?
  var didFetchDataFinished: (() -> Void)?
  var didUpdatePriceData: ((Int) -> Void)?
  var successScrap: (() -> Void)?
  var networkError: (() -> Void)?
  var unexpectedError: (() -> Void)?
  
  // MARK: - Models
  
  var headerData : PlanPreview.HeaderData?
  var descriptionData : PlanPreview.DescriptionData?
  var photoData : [PlanPreview.PhotoData]?
  var summaryData : PlanPreview.SummaryData?
  var recommendData : PlanPreview.RecommendData?
  var contentList : [PlanPreview.ContentList] = []
  
  // MARK: - Dependency 주입
  private var repository: PlanPreviewRepositoryInterface
  private let postId: Int
  
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
     
  }
  
  func clickPreviewButton() {
     
  }
  
  func clickPreviewImage(index: Int) {
     
  }
  
  func showContentPage() {
     
  }
}

// MARK: - Logics
extension PlanPreviewViewModel {
  func fetchData(){
    fetchHeaderData()
    fetchBodyData()
    didFetchDataFinished?()
    
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
  
  
  func fetchHeaderData() {
    repository.fetchHeaderData(idx: postId) { [weak self] header, description, price in
      self?.headerData = header
      self?.descriptionData = description
      self?.didUpdatePriceData?(price)
    }
  }
  
  func fetchBodyData() {
    repository.fetchBodyData(idx: postId) { [weak self] photoList, summary in
      self?.photoData = photoList
      self?.summaryData = summary
    }
  }
  
}
