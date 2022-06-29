//
//  NewPlanPreviewRecommendReason.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class NewPlanPreviewRecommendReason: XibView{
  var viewModel: NewPlanPreviewRecommendViewModel! {
    didSet{ configureUI() }}
  
  @IBOutlet var recommendIconList: [UILabel]!
  @IBOutlet var recommendLabelList: [UILabel]!
  
  deinit {
    recommendLabelList = nil;
    recommendIconList = nil;
  }
}

extension NewPlanPreviewRecommendReason {
  private func configureUI() {
    for (index,reason) in viewModel.reasonList.enumerated() {
      recommendIconList[index].text = reason.icon
      recommendLabelList[index].text = reason.reason
    }
  }
}


struct NewPlanPreviewRecommendViewModel{
  let reasonList: [RecommendData]
  
  struct RecommendData{
    let icon: String
    let reason: String
  }
}
