//
//  NewPlanPreviewRepository.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import RxSwift

protocol NewPlanPreviewRepository {
  
}

final class DefaultNewPlanPreviewRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultNewPlanPreviewRepository: NewPlanPreviewRepository {
  
}
