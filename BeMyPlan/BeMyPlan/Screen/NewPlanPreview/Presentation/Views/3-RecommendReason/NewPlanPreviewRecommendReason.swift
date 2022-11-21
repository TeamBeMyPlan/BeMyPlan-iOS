//
//  NewPlanPreviewRecommendReason.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

final class NewPlanPreviewRecommendReason: XibView{
  var viewModel: NewPlanPreviewRecommendViewModel! {
    didSet{ configureUI() }}
  
  @IBOutlet var containerList: [UIView]!
  @IBOutlet var recommendIconList: [UILabel]!
  @IBOutlet var recommendLabelList: [UILabel]!
  
  deinit {
    recommendLabelList = nil
    recommendIconList = nil
    containerList = nil;
  }
}

extension NewPlanPreviewRecommendReason {
  private func configureUI() {
    for (index,reason) in viewModel.reasonList.enumerated() {
      containerList[index].layer.cornerRadius = 5
      recommendLabelList[index].font = .getSpooqaMediumFont(size: 14)
      recommendLabelList[index].textColor = .grey01
      
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
