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
  var price : String = ""
  var paymentType : PaymentList = .kakaoPay
  // MARK: - UI Component Part
  
  @IBOutlet var writerLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var moneyLabel: UILabel!
  @IBOutlet var paymentLabel: UILabel!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setPriceLabel()
  }

  // MARK: - Custom Method Part
  
  private func setPriceLabel(){
    moneyLabel.text = price
    paymentLabel.text = paymentType.rawValue
  }

  @IBAction func closeButtonClicked(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
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
