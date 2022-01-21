//
//  MyPlanApplicationVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/20.
//

import UIKit
import MessageUI

class MyPlanApplicationVC: UIViewController, MFMailComposeViewControllerDelegate {
  
  // MARK: - Vars & Lets Part
  
  
  
  // MARK: - UI Component Part
  
  @IBOutlet var applicationButton: UIButton!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addUploadButtonActions()
    
  }
  
  // MARK: - IBAction Part
  
  @IBAction func backButtonCLicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  @IBAction func uploadButtonClicked(_ sender: Any) {
  }
  
  
  // MARK: - Custom Method Part
  
  private func addUploadButtonActions(){
    applicationButton.press(animated: true) {
      if MFMailComposeViewController.canSendMail() {
        
        let compseVC = MFMailComposeViewController()
        compseVC.mailComposeDelegate = self
        
        compseVC.setToRecipients(["bemyplan@gmail.com"])
        compseVC.setSubject("비마이플랜 크리에이터 신청")
        compseVC.setMessageBody(mailTemplate, isHTML: false)
        
        self.present(compseVC, animated: true, completion: nil)
      }
      
    }
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
let mailTemplate  = """

업로드 신청 입력 양식
- 이름 :
- 닉네임 :
- 여행 일정 컨텐츠 제목 :
- 장소명 :
- 전화번호 :
- 사진 :
- 정보 (솔직 후기, 꿀팁) :


"""
