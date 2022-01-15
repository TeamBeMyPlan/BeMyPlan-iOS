//
//  LoginVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

class LoginVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  // MARK: - UI Component Part
  
  
  @IBOutlet var mainIcon: UIImageView!{
    didSet{ mainIcon.alpha = 0}
  }
  @IBOutlet var searchLabel: UILabel!{
    didSet{ searchLabel.alpha = 0}
  }
  @IBOutlet var kakaoLoginBtn: UIButton!{
    didSet{ kakaoLoginBtn.alpha = 0}
  }
  @IBOutlet var appleLoginBtn: UIButton!{
    didSet{ appleLoginBtn.alpha = 0}
  }
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setBtnActions()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    showAnimation()
  }
  // MARK: - IBAction Part
  @IBAction func touchUpToGoBaseView(_ sender: Any) {
  }
  
  // MARK: - Custom Method Part
  
  private func showAnimation(){
    UIView.animate(withDuration: 0.8) {
      self.mainIcon.alpha = 1
      self.kakaoLoginBtn.alpha = 1
      self.appleLoginBtn.alpha = 1
      self.searchLabel.alpha = 1
    }
  }
  func setBtnActions() {
    //IBAction 대용으로 만든 함수
    self.kakaoLoginBtn.press {
      self.kakaoLogin()
    }
    
    self.appleLoginBtn.press {
      self.appleLogin()
    }
  }
  
  func moveSignup(){
    guard let signupVC = UIStoryboard.list(.base).instantiateViewController(withIdentifier: SignUpVC.className) as? SignUpVC else {return}
    signupVC.modalPresentationStyle = .overFullScreen
    self.present(signupVC, animated: true, completion: nil)
  }
  
   func moveBaseVC(){
    guard let baseVC = UIStoryboard.list(.base).instantiateViewController(withIdentifier: BaseVC.className) as? BaseVC else {return}
    self.navigationController?.pushViewController(baseVC, animated: true)
  }
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
