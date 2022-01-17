//
//  MyPlanBuyContentCVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class MyPlanBuyContentCVC: UICollectionViewCell {
  @IBOutlet var contentImageView : UIImageView!
  @IBOutlet var titleLabel : UILabel!
  
  func setContentata(title : String, imageURL: String){
    contentImageView.layer.cornerRadius = 5

//    titleLabel.setTextWithLineHeight(text: title, lineHeight: 1.3)
    titleLabel.text = title
    contentImageView.setImage(with: imageURL)
  }
}
