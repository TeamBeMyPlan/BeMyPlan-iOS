//
//  NewPlanPreviewVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit
import RxSwift

class NewPlanPreviewVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: NewPlanPreviewViewModel!
  
  // MARK: - UI Component Part
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModels()
  }
}

extension NewPlanPreviewVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
    let input = NewPlanPreviewViewModel.Input()
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}
