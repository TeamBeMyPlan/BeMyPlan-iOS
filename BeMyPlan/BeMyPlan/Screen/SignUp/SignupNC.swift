//
//  SignupNC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/06.
//

import UIKit

class SignupNC: UINavigationController {
  
  var socialType: String?
  var socialToken: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let signupNicknameVC = ModuleFactory.resolve().instantiateSignupNicknameVC()
    signupNicknameVC.socialType = socialType ?? ""
    signupNicknameVC.userToken = socialToken ?? ""
    
    self.pushViewController(signupNicknameVC, animated: false)

  }
}
