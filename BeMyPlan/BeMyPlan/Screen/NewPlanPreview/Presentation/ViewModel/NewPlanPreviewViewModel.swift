//
//  NewPlanPreviewViewModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import RxSwift

final class NewPlanPreviewViewModel: ViewModelType {

  private let useCase: NewPlanPreviewUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    
  }
  
  // MARK: - Outputs
  struct Output {
    
  }
  
  init(useCase: NewPlanPreviewUseCase) {
    self.useCase = useCase
  }
}

extension NewPlanPreviewViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    // input,output 상관관계 작성
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
  }
}
