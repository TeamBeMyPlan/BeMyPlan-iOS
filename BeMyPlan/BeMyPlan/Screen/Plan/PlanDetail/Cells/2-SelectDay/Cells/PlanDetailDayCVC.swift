//
//  PlanDetailDayCVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailDayCVC: UICollectionViewCell,UICollectionViewRegisterable {

  static var isFromNib: Bool = true

  // MARK: - UI Component Part
  @IBOutlet var dayLabel: UILabel!
  
  // MARK: - Life Cycle Part

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  // MARK: - Custom Method Part
  func setDayState(isClicked : Bool, day : Int){
    dayLabel.text = String(day) + "일차"
    dayLabel.textColor = isClicked ? .white : .grey01
    contentView.backgroundColor = isClicked ? .bemyBlue : .grey06
    
  }
}
