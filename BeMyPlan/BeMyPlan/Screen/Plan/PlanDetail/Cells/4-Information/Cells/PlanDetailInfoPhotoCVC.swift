//
//  PlanDetailInfoPhotoCVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/13.
//

import UIKit

class PlanDetailInfoPhotoCVC: UICollectionViewCell,UICollectionViewRegisterable {
  
  @IBOutlet var contentImageView: UIImageView!
  static var isFromNib: Bool = true
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setImage(url : String){
//    contentImageView.setImage(with: url)
  }
  
}
