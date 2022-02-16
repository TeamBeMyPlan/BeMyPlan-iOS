//
//  PlanPreviewViewModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/29.
//

import Foundation

protocol PlanPreviewViewModelType : ViewModelType{
  
  // Inputs
  func viewDidLoad()
  func clickScrap()
  func clickBuyButton()
  func clickPreviewButton()
  func clickPreviewImage(index : Int)
  func showContentPage()

  // Outputs
  var didUpdateContentListType: (([PlanPreview.ContentList]) -> Void)? { get set }
  var didUpdateHeaderData : ((PlanPreview.HeaderData,PlanPreview.DescriptionData) -> Void)? { get set }
  var didUpdateBodyData : (([PlanPreview.PhotoData],PlanPreview.SummaryData?) -> Void)? { get set }
  var successScrap: (() -> Void)? { get set }
  var unexpactedError: (() -> Void)? { get set }
  var loadingState: ((Bool) -> Void)? { get set }
  
}

class PlanPreviewViewModel : PlanPreviewViewModelType{
  
  // MARK: - Outputs
  var didUpdateContentListType: (([PlanPreview.ContentList]) -> Void)?
  var didUpdateHeaderData: ((PlanPreview.HeaderData, PlanPreview.DescriptionData) -> Void)?
  var didUpdateBodyData: (([PlanPreview.PhotoData], PlanPreview.SummaryData?) -> Void)?
  var successScrap: (() -> Void)?
  var unexpactedError: (() -> Void)?
  var loadingState: ((Bool) -> Void)?
  
  // MARK: - Models
  
  // MARK: - Dependency 주입
  private let repository: PlanPreviewRepositoryInterface
  private let postId: Int
  
  init(postId: Int,repository: PlanPreviewRepositoryInterface){
    self.postId = postId
    self.repository = repository
  }
  
}

extension PlanPreviewViewModel{
  func viewDidLoad() {
    repository.fetchBodyData(idx: postId) { photoList, summary in
      
    }
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
