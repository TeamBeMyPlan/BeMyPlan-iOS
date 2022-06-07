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
  let factory: ModuleFactoryProtocol = ModuleFactory.resolve()

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
    addObserver()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    showAnimation()
  }
  
  // MARK: - IBAction Part
  
  @IBAction func touchUpToGoBaseView(_ sender: Any) {
    UserDefaults.standard.removeObject(forKey: "userSessionID")
    self.makeVibrate()
    self.moveBaseVC()
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
    self.kakaoLoginBtn.press(animated: true) {
      self.kakaoLogin()
    }

    self.appleLoginBtn.press(animated: true) {
      self.appleLogin()
    }
  }
  
  func moveSignup(){
    let signupNicknameVC = factory.instantiateSignupNicknameVC()
    signupNicknameVC.modalPresentationStyle = .overFullScreen
    self.present(signupNicknameVC, animated: true, completion: nil)
  }
  
   func moveBaseVC(){
     let baseVC = factory.instantiateBaseNC()
     baseVC.modalPresentationStyle = .fullScreen
     self.present(baseVC, animated: false, completion: nil)
  }
  
  private func addObserver() {
    addObserverAction(.signupComplete) { _ in
      self.moveBaseVC()
    }
  }
}

extension LoginVC : SignupDelegate{
  func loginComplete() {
    moveBaseVC()
  }
}
