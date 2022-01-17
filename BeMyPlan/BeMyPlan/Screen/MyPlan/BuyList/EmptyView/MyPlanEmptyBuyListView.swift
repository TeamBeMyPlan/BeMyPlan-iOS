//
//  MyPlanEmptyBuyListView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class MyPlanEmptyBuyListView: XibView {
  @IBAction func clickedLookAroundButton(_ sender: Any) {
    NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .moveHomeTab), object: nil)
  }
}
