//
//  MyPlanSettingVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class MyPlanSettingVC: UIViewController {
  // MARK: - UI Component Part
  
  @IBOutlet var uploadButton: UIButton!
  @IBOutlet var askButton: UIButton!
  @IBOutlet var serviceTermButton: UIButton!
  
  @IBOutlet var logoutButton: UIButton!
  @IBOutlet var withdrawButton: UIButton!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addButtonActions()
  }

  // MARK: - Custom Method Part
  
  private func addButtonActions(){
    uploadButton.press {
    }
    
    askButton.press {
    }
  
    serviceTermButton.press {
      
    }
    
    logoutButton.press {
      
    }
    
    withdrawButton.press {
        NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .moveSettingWithdrawView), object: nil)
    }
  }
}
