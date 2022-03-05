//
//  PaymentSelectVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/10.
//

import UIKit

class PaymentSelectVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  var writer : String?
  var planTitle : String?
  var imgURL : String?
  var postIdx = 0
  private var selectedIndex : Int = -1{
    didSet{
      if selectedIndex == -1{
        paymentButton.tintColor = .grey04
      }else{
        setPaymentLog()
        paymentButton.backgroundColor = .bemyBlue
      }
      setButtonState()
    }
  }
  
  var price : String?
  private var paymentList :[PaymentList] = [.kakaoPay,
                                    .toss,.naverPay]

  // MARK: - UI Component Part
  
  @IBOutlet var planImageView: UIImageView!
  @IBOutlet var infoContentView: UIView!
  @IBOutlet var writerLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var moneyLabel: UILabel!
  @IBOutlet var paymentButtonList: [BarSelectButton]!
  
  @IBOutlet var paymentButton: UIButton!
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButtonUI()
    setContainerUI()
    setButtonState()
    setPriceLabel()
    setContainerInfo()
  }
  
  // MARK: - Custom Method Part

  @IBAction func backButtonClicked(_ sender: Any) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .closePaymentView)
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func paymentButtonClicked(_ sender: Any) {
    if selectedIndex != -1{
      AppLog.log(at: FirebaseAnalyticsProvider.self, .clickPaymentButton(postIdx: String(postIdx)))
      showEventPopup()
    }
 
  }
  
  private func setContainerUI(){
    infoContentView.layer.cornerRadius = 5
    infoContentView.layer.borderWidth = 1
    infoContentView.layer.borderColor = UIColor.grey04.cgColor
  }
  
  private func setContainerInfo(){
    titleLabel.text = planTitle
    writerLabel.text = writer
    planImageView.layer.cornerRadius = 5
    planImageView.setImage(with: imgURL ?? "")
    
  }
  
  private func showPaymentComplete(){
    guard let paymentCompleteVC = self.storyboard?.instantiateViewController(withIdentifier: PaymentCompleteVC.className) as? PaymentCompleteVC else {return}
    paymentCompleteVC.modalTransitionStyle = .coverVertical
    paymentCompleteVC.modalPresentationStyle = .fullScreen
    paymentCompleteVC.delegate = self
    paymentCompleteVC.price = price ?? ""
    paymentCompleteVC.paymentType = paymentList[selectedIndex]
    paymentCompleteVC.planTitle = planTitle ?? ""
    paymentCompleteVC.writer = writer ?? ""
    paymentCompleteVC.postIdx = postIdx
    present(paymentCompleteVC,animated: true)
  }
  
  private func showEventPopup(){
    let eventPopupVC = ModuleFactory.resolve().instantiatePaymentEventPopupVC()
    eventPopupVC.modalTransitionStyle = .crossDissolve
    eventPopupVC.modalPresentationStyle = .overCurrentContext
    eventPopupVC.delegate = self
    eventPopupVC.postIdx = postIdx
    present(eventPopupVC,animated: true)
  }
  
  private func setPaymentLog(){
    let paymentSource :LogEventType.PaymentSource
    switch(selectedIndex) {
      case 0: paymentSource = .kakaoPay
      case 1: paymentSource = .toss
      default: paymentSource = .naverPay
    }
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickPaymentMethod(source: paymentSource))
  }
  
  private func setPriceLabel(){
    moneyLabel.text = price
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
    paymentButtonList = nil
  }
}
enum PaymentList : String{
  case kakaoPay = "카카오페이"
  case toss = "토스"
  case naverPay = "네이버페이"
}

extension PaymentSelectVC : PaymentCompleteDelegate{
  func completeButtonClicked() {
    let detailVC = ModuleFactory.resolve().instantiatePlanDetailVC(postID: postIdx)
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
}
