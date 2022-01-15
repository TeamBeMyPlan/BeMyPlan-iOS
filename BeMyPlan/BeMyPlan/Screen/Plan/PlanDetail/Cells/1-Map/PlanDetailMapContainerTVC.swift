//
//  PlanDetailMapContainerTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailMapContainerTVC: UITableViewCell,UITableViewRegisterable {
  
  @IBOutlet var mapContainerView: UIView!
  static var isFromNib: Bool = true
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  private func setUI(){
    mapContainerView.layer.cornerRadius = 5
  }
}
