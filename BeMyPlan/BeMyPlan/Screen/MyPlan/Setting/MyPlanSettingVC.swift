//
//  MyPlanSettingVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class MyPlanSettingVC: UIViewController {
  
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
  
  private func addButtonActions(){
    uploadButton.press {
      guard let uploadVC = self.storyboard?.instantiateViewController(withIdentifier: MyPlanApplicationVC.className) as? MyPlanApplicationVC else {return}
      self.navigationController?.pushViewController(uploadVC, animated: true)
    }
    
    askButton.press {
      guard let url = URL(string: "https://flaxen-warlock-70e.notion.site/8dd759bd71d94caf82f52f177428060d"), UIApplication.shared.canOpenURL(url) else { return }

      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    serviceTermButton.press {
      guard let url = URL(string: "https://flaxen-warlock-70e.notion.site/c66b80b220814a94a699d83def211904"), UIApplication.shared.canOpenURL(url) else { return }

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
        NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .moveSettingWithdrawView), object: nil)
    }

  }
  
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
