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
      setButtonState()
    }
  }
  private var paymentList :[PaymentList] = [.kakaoPay,
                                    .toss,.naverPay]
  
  // MARK: - UI Component Part
  
  @IBOutlet var writerLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var moneyLabel: UILabel!
  @IBOutlet var paymentButtonList: [BarSelectButton]!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtonUI()
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
    present(paymentCompleteVC,animated: true)
  }
  
  private func setButtonUI(){
    for (index,item) in paymentButtonList.enumerated(){
      item.setButtonState(isSelected: false)
      item.press {
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

class BarSelectButton : UIButton{
  func setButtonState(isSelected : Bool){
    layer.cornerRadius = 5
    layer.borderWidth = 1
    layer.borderColor = isSelected ? UIColor.bemyBlue.cgColor :
    UIColor.grey04.cgColor
    titleLabel?.textColor = isSelected ? .bemyBlue : .grey04
  }
}
