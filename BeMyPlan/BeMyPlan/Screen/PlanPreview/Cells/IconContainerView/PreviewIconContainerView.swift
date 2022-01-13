//
//  PreviewIconContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/10.
//

import UIKit

class PreviewIconContainerView: XibView {
  
  @IBOutlet var themeLabel: UILabel!
  @IBOutlet var spotCountLabel: UILabel!
  @IBOutlet var restaurantCountLabel: UILabel!
  @IBOutlet var dayCountLabel: UILabel!
  @IBOutlet var peopleCaseLabel: UILabel!
  @IBOutlet var moneyLabel: UILabel!
  @IBOutlet var transportLabel: UILabel!
  @IBOutlet var monthLabel: UILabel!
  
  
  
  func setIconData(iconData : PlanPreview.IconData){
    themeLabel.text = iconData.theme
    spotCountLabel.text = iconData.spotCount
    restaurantCountLabel.text = iconData.restaurantCount
    dayCountLabel.text = iconData.dayCount
    peopleCaseLabel.text = iconData.peopleCase
    moneyLabel.text = iconData.budget
    transportLabel.text = iconData.transport
    monthLabel.text = iconData.month
  }
}
