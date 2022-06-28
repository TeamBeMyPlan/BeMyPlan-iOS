//
//  NewPlanPreviewUseCase.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import RxSwift

protocol NewPlanPreviewUseCase {

}

final class DefaultNewPlanPreviewUseCase {
  
  private let repository: NewPlanPreviewRepository
  private let disposeBag = DisposeBag()
  
  init(repository: NewPlanPreviewRepository) {
    self.repository = repository
  }
}

extension DefaultNewPlanPreviewUseCase: NewPlanPreviewUseCase {
  
}
