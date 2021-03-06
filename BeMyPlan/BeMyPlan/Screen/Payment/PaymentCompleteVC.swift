//
//  PaymentCompleteVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//
import UIKit

class PaymentCompleteVC: UIViewController {
  
  // MARK: - Var,Let Parts
  
  var postIdx: Int = 0
  var writer : String = ""
  var planTitle : String = ""
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
    setInfoLabel()
    setPriceLabel()
  }

  // MARK: - Custom Method Part
  
  private func setInfoLabel(){
    writerLabel.text = writer
    titleLabel.text = planTitle
  }
  private func setPriceLabel(){
    moneyLabel.text = price
    paymentLabel.text = paymentType.rawValue
  }

  @IBAction func closeButtonClicked(_ sender: Any) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .closePaymentCompleteView)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func showContentButtonClicked(_ sender: Any) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickPlanDetailViewInPayment(postIdx: String(postIdx)))
    dismiss(animated: true) {
      self.delegate?.completeButtonClicked()
    }
  }

}
// MARK: - Extension Part

protocol PaymentCompleteDelegate{
  func completeButtonClicked()
}
