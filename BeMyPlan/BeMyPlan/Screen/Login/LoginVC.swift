//
//  LoginVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  // MARK: - UI Component Part
  @IBOutlet var searchLabel: UILabel!
  @IBOutlet var kakaoLoginBtn: UIButton!
  @IBOutlet var appleLoginBtn: UIButton!
  
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setBtnActions()
  }
  
  // MARK: - IBAction Part
  @IBAction func touchUpToGoBaseView(_ sender: Any) {
  }
  
  // MARK: - Custom Method Part
  func setBtnActions() {
    //IBAction 대용으로 만든 함수
    self.kakaoLoginBtn.press {
      self.kakaoLogin()
    }
    
    self.appleLoginBtn.press {
      
    }
  }
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
