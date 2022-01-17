//
//  PaymentCompleteVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//
import UIKit

class PaymentCompleteVC: UIViewController {
  
  // MARK: - Var,Let Parts
  var delegate : PaymentCompleteDelegate?
  
  // MARK: - UI Component Part
  
  @IBOutlet var writerLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var moneyLabel: UILabel!
  @IBOutlet var paymentLabel: UILabel!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Custom Method Part

  
  @IBAction func showContentButtonClicked(_ sender: Any) {
    dismiss(animated: true) {
      self.delegate?.completeButtonClicked()
    }
  }

}
// MARK: - Extension Part

protocol PaymentCompleteDelegate{
  func completeButtonClicked()
}
