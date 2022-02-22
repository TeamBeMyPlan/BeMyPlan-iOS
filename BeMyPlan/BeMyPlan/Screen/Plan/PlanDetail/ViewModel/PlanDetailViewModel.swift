//
//  PlanDetailViewModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/02/22.
//

import Foundation

protocol PlanDetailViewModelType: ViewModelType {
  
  // Inputs
  
  func viewDidLoad()
  func 
  
  // Outputs
  
}

class PlanDetailViewModel: PlanDetailViewModelType {

  // MARK: - Outputs
  
  // MARK: - DI
  private let repository: PlanDetailRepositoryInterface
  let postID: Int
  
  init(postId: Int,repository: PlanDetailRepositoryInterface){
    self.postID = postId
    self.repository = repository
  }
}


// MARK: - Logics
extension PlanDetailViewModel {
  
  
}
