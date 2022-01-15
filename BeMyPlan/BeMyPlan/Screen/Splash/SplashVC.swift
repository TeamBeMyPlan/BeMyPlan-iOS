//
//  SplashVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit

class SplashVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  // MARK: - UI Component Part
  @IBOutlet var splashIconNoTitle: UIImageView!
  @IBOutlet var splashIcon: UIImageView!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startSplash()
  }
  
  // MARK: - IBAction Part
  
  // MARK: - Custom Method Part
  
  private func startSplash(){
    UIView.animateKeyframes(withDuration: 3, delay: 0, options: .allowUserInteraction) {
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
      
    }
  }
  
  private func moveBaseVC(){
    let baseVC = UIStoryboard.list(.base).instantiateInitialViewController()!
    
    self.navigationController?.pushViewController(baseVC, animated: false)
  }
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
