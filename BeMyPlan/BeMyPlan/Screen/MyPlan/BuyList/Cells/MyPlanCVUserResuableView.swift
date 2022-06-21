//
//  MyPlanCVUserResuableView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class MyPlanCVUserResuableView: UICollectionReusableView {
    
  @IBOutlet var guestModeView: UIView!
  @IBOutlet private var profileImageView: UIImageView!
  @IBOutlet private var nicknameLabel: UILabel!
  @IBOutlet private var buyCountLabel: UILabel!
  
  @IBAction func logoutButtonClicked(_ sender: Any) {
    postObserverAction(.loginButtonClickedInMyPlan)
  }
  
  func setData(nickName : String, buyCount : Int,isGuestMode: Bool = false){
    self.guestModeView.isHidden = !isGuestMode
    buyCountLabel.text = String(buyCount)
    nicknameLabel.text = nickName
  }
}
