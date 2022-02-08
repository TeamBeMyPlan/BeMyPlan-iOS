//
//  MyPlanSettingVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit
import MessageUI

class MyPlanSettingVC: UIViewController, MFMailComposeViewControllerDelegate {
  
  // MARK: - Vars & Lets Part
  
  
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
  
  // MARK: - IBAction Part
  
  
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
      guard let url = URL(string: "https://www.notion.so/a69b7abcdb9f42399825f4ff25343bfd"), UIApplication.shared.canOpenURL(url) else { return }

      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    logoutButton.press {
      self.makeAlert(alertCase: .requestAlert, title: "로그아웃", content: "로그아웃 하시겠습니까?") {
        //실제로는 이방법이 아니라 dismiss 되었을때 completion에 새로운 escaping closure를 선언해서 파라미터로 받아와서 해야한다....!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) {
          self.makeAlert(alertCase: .simpleAlert, title: "로그아웃", content: "로그아웃 되었습니다.") {
            guard let loginVC = UIStoryboard.list(.login).instantiateViewController(withIdentifier: LoginNC.className) as? LoginNC else {return}
            loginVC
              .modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: false, completion: nil)
          }
        }
      }
    }
    
    withdrawButton.press {
      self.postObserverAction(.moveSettingWithdrawView)
    }

  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
