//
//  MyPlanCVUserResuableView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class MyPlanCVUserResuableView: UICollectionReusableView {
    
  @IBOutlet var profileImageView: UIImageView!
  @IBOutlet var nicknameLabel: UILabel!
  @IBOutlet var buyCountLabel: UILabel!
  
  func setData(nickName : String, buyCount : Int){
    buyCountLabel.text = String(buyCount)
    nicknameLabel.text = nickName
  }
}
