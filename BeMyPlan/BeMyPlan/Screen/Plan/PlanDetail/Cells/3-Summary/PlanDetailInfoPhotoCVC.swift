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
  
  override func prepareForReuse() {
    contentImageView.image = nil
  }
  
  func setImage(url : String){
    if url != ""{
      contentImageView.setImage(with: url)
    }else{
      contentImageView.image = UIImage(named: "mainlist4")
    }
  }
  
}
