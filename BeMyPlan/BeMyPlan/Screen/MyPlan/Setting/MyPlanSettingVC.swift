//
//  MyPlanSettingVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit
import MessageUI

class MyPlanSettingVC: UIViewController, MFMailComposeViewControllerDelegate {
  
  // MARK: - UI Component Part
  
  @IBOutlet var uploadButton: UIButton!
  @IBOutlet var askButton: UIButton!
  @IBOutlet var serviceTermButton: UIButton!
  @IBOutlet var logoutButton: UIButton!
  @IBOutlet var withdrawButton: UIButton!
  @IBOutlet var headerTopConstraint: NSLayoutConstraint!{
    didSet{
      headerTopConstraint.constant = calculateTopInset()
    }
  }
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addButtonActions()
  }
  
  // MARK: - Custom Method Part
  
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  private func addButtonActions(){
    uploadButton.press {
      guard let uploadVC = self.storyboard?.instantiateViewController(withIdentifier: MyPlanApplicationVC.className) as? MyPlanApplicationVC else {return}
      self.navigationController?.pushViewController(uploadVC, animated: true)
    }
    
    askButton.press {
      
      if MFMailComposeViewController.canSendMail() {
        
        let compseVC = MFMailComposeViewController()
        compseVC.mailComposeDelegate = self
        
        compseVC.setToRecipients(["bemyplan@gmail.com"])
        compseVC.setSubject("비마이플랜에게 문의하기")
        compseVC.setMessageBody("", isHTML: false)
        
        self.present(compseVC, animated: true, completion: nil)
      }else{
        guard let url = URL(string: "https://www.notion.so/a69b7abcdb9f42399825f4ff25343bfd"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }

    }
    
    serviceTermButton.press {
      guard let url = URL(string: "https://boggy-snowstorm-fdb.notion.site/a69b7abcdb9f42399825f4ff25343bfd"), UIApplication.shared.canOpenURL(url) else { return }
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    logoutButton.press {
      if let _ = UserDefaults.standard.string(forKey: "userSessionID") {
        self.logoutAction()
      } else {
        self.makeAlert(alertCase: .requestAlert, title: "알림", content: "로그인 페이지로 돌아가시겠습니까?") {
          self.presentLoginVC()
        }
      }
    }
    
    withdrawButton.press {
      self.postObserverAction(.moveSettingWithdrawView)
    }
  }
  
  private func logoutAction() {
    self.makeAlert(alertCase: .requestAlert, title: "로그아웃", content: "로그아웃 하시겠습니까?") {
      BaseService.default.postUserLogout { _ in
        self.makeAlert(alertCase: .simpleAlert, title: "로그아웃", content: "로그아웃 되었습니다.") {
          self.presentLoginVC()
        }
      }
    }
  }
  
  private func presentLoginVC() {
    UserDefaults.standard.removeObject(forKey: "userSessionID")
    guard let loginVC = UIStoryboard.list(.login).instantiateViewController(withIdentifier: LoginNC.className) as? LoginNC else {return}
    loginVC.modalPresentationStyle = .fullScreen
    AppLog.log(at: FirebaseAnalyticsProvider.self, .logout)
    self.present(loginVC, animated: false, completion: nil)
  }
    
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
