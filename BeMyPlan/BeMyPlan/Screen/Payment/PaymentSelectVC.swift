//
//  PaymentSelectVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/10.
//

import UIKit

struct PaymentContentData{
  var writer: String = ""
  var title: String = ""
  var imgURL: String = ""
  var price: String = ""
  var postIdx: Int = 0
  
  init(writer: String? = nil,title: String? = nil,imgURL:String? = nil, price:String? = nil, postIdx:Int? = nil){
    self.writer = writer ?? ""
    self.title = title ?? ""
    self.imgURL = imgURL ?? ""
    self.postIdx = postIdx ?? 0
    if let price = price{
      self.price = price + "원"
    }else {
      self.price = ""
    }
  }
}

class PaymentSelectVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
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
  private var paymentList :[PaymentList] = [.kakaoPay,
                                    .toss,.naverPay]
  var paymentData = PaymentContentData()


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
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func paymentButtonClicked(_ sender: Any) {
    if selectedIndex != -1{
      BaseService.default.postOrderPlan(planIdx: self.paymentData.postIdx) { result in
        result.success { _ in
          self.showEventPopup()
        }.catch { _ in
          self.postObserverAction(.showNetworkError)
        }
      }

    }
 
  }
  
  private func setContainerUI(){
    infoContentView.layer.cornerRadius = 5
    infoContentView.layer.borderWidth = 1
    infoContentView.layer.borderColor = UIColor.grey04.cgColor
  }
  
  private func setContainerInfo(){
    titleLabel.text = paymentData.title
    writerLabel.text = paymentData.writer
    planImageView.layer.cornerRadius = 5
    planImageView.setImage(with: paymentData.imgURL)
    
  }
  
  private func showPaymentComplete(){
    guard let paymentCompleteVC = self.storyboard?.instantiateViewController(withIdentifier: PaymentCompleteVC.className) as? PaymentCompleteVC else {return}
    paymentCompleteVC.modalTransitionStyle = .coverVertical
    paymentCompleteVC.modalPresentationStyle = .fullScreen
    paymentCompleteVC.delegate = self
    paymentCompleteVC.price = paymentData.price
    paymentCompleteVC.paymentType = paymentList[selectedIndex]
    paymentCompleteVC.planTitle = paymentData.title
    paymentCompleteVC.writer = paymentData.writer
    paymentCompleteVC.postIdx = paymentData.postIdx
    present(paymentCompleteVC,animated: true)
  }
  
  private func showEventPopup(){
    let eventPopupVC = ModuleFactory.resolve().instantiatePaymentEventPopupVC()
    eventPopupVC.modalTransitionStyle = .crossDissolve
    eventPopupVC.modalPresentationStyle = .overCurrentContext
    eventPopupVC.delegate = self
    eventPopupVC.postIdx = paymentData.postIdx
    present(eventPopupVC,animated: true)
  }
  
  private func setPaymentLog(){
    let paymentSource :LogEventType.PaymentSource
    switch(selectedIndex) {
      case 0: paymentSource = .kakaoPay
      case 1: paymentSource = .toss
      default: paymentSource = .naverPay
    }
  }
  
  private func setPriceLabel(){
    moneyLabel.text = paymentData.price
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
    let detailVC = ModuleFactory.resolve().instantiatePlanDetailVC(postID: paymentData.postIdx)
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
}
