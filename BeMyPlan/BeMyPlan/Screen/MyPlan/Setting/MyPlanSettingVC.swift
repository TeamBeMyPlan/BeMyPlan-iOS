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
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addButtonActions()
    
  }
  
  // MARK: - IBAction Part
  
  
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
      
    }
  }
  
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
