//
//  PaymentEventPopupVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/05.
//

import UIKit

class PaymentEventPopupVC: UIViewController {

  // MARK: - Vars & Lets Part
  var postIdx: Int = 0
  var delegate : PaymentCompleteDelegate?
  
  // MARK: - Life Cycle Part
  
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
  // MARK: - IBAction Part

  @IBAction func okButtonClicked(_ sender: Any) {
    dismiss(animated: true) {
      self.delegate?.completeButtonClicked()
    }
  
  }
}
