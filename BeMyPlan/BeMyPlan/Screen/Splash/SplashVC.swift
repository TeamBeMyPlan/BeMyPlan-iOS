//
//  SplashVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit

class SplashVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  var isLoginComplete = false
  private let factory: ModuleFactoryProtocol = ModuleFactory.resolve()
  
  // MARK: - UI Component Part
  
  @IBOutlet var splashIconNoTitle: UIImageView!
  @IBOutlet var splashIcon: UIImageView!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UserDefaults.standard.setValue(100, forKey: "userIdx")
    AppLog.setFirebaseUserProperty()
    startSplash()
  }
  
  // MARK: - Custom Method Part
  
  private func startSplash(){
    UIView.animateKeyframes(withDuration: 2.5, delay: 0, options: .allowUserInteraction) {
      UIView.addKeyframe(withRelativeStartTime: 1/6,
                         relativeDuration: 1/3) {
        self.splashIcon.alpha = 1
      }
      UIView.addKeyframe(withRelativeStartTime: 5/6,
                         relativeDuration: 1/6) {
        self.splashIcon.alpha = 0
        self.splashIconNoTitle.alpha = 0
      }
    } completion: { _ in
      self.isLoginComplete ? self.moveBaseVC() : self.moveLoginVC()
    }
  }
  
  private func moveBaseVC(){
    let baseNC = factory.instantiateBaseNC()
    baseNC.modalPresentationStyle = .fullScreen
    self.present(baseNC, animated: false, completion: nil)
  }
  
  private func moveLoginVC(){
    let loginVC = factory.instantiateLoginVC()
    loginVC.modalPresentationStyle = .fullScreen
    self.present(loginVC, animated: false, completion: nil)
  }
}
