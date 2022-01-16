//
//  PaymentSelectVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/10.
//

import UIKit

class PaymentSelectVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private var selectedIndex : Int = -1{
    didSet{
      print("SELECTINDEX",selectedIndex)
      setButtonState()
    }
  }
  private var paymentList :[PaymentList] = [.kakaoPay,
                                    .toss,.naverPay]
  
  // MARK: - UI Component Part
  
  @IBOutlet var infoContentView: UIView!
  @IBOutlet var writerLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var moneyLabel: UILabel!
  @IBOutlet var paymentButtonList: [BarSelectButton]!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtonUI()
    setContainerUI()
    setButtonState()
  }
  
  // MARK: - Custom Method Part

  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func paymentButtonClicked(_ sender: Any) {
    guard let paymentCompleteVC = self.storyboard?.instantiateViewController(withIdentifier: PaymentCompleteVC.className) as? PaymentCompleteVC else {return}
    paymentCompleteVC.modalTransitionStyle = .coverVertical
    paymentCompleteVC.modalPresentationStyle = .fullScreen
    paymentCompleteVC.delegate = self
    present(paymentCompleteVC,animated: true)
  }
  
  private func setContainerUI(){
    infoContentView.layer.cornerRadius = 5
    infoContentView.layer.borderWidth = 1
    infoContentView.layer.borderColor = UIColor.grey04.cgColor
  }
  
  private func setButtonUI(){
    for (index,item) in paymentButtonList.enumerated(){
      item.setButtonState(isSelected: false)
      item.press(animated: true) {
        self.selectedIndex = index
      }
    }
  }
  
  private func setButtonState(){
    for (index,item) in paymentButtonList.enumerated(){
      item.setButtonState(isSelected: selectedIndex == index)
      
    }
  }
  
  // MARK: - @objc Function Part
  
  deinit {
    paymentButtonList = nil;
  }
}
enum PaymentList{
  case kakaoPay
  case toss
  case naverPay
}

extension PaymentSelectVC : PaymentCompleteDelegate{
  func completeButtonClicked() {
    guard let planDetailVC =
            UIStoryboard.list(.planDetail).instantiateViewController(withIdentifier: PlanDetailVC.className) as? PlanDetailVC else {return}
    self.navigationController?.pushViewController(planDetailVC, animated: true)
  }
}
