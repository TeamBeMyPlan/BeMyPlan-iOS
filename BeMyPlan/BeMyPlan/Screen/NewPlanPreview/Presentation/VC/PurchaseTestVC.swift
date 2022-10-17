//
//  PurchaseTestVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/08/15.
//

import UIKit
import StoreKit

class PurchaseTestVC: UIViewController {
  
  private var productss: [SKProduct] = []
  
  private var firstProducts: [SKProduct] = []
  private var secondProducts: [SKProduct] = []
  private var thirdProducts: [SKProduct] = []

  @IBOutlet var firstButton: UIButton!
  @IBOutlet var restoreButton: UIButton!
  @IBOutlet var purchaseLogTextView: UITextView!
  @IBOutlet var receipLabel: UILabel!
  @IBOutlet var copyButton: UIButton!
  @IBOutlet var receipTextView: UITextView!
  override func viewDidLoad() {
    super.viewDidLoad()
    addToolBar(textView: purchaseLogTextView)
    addToolBar(textView: receipTextView)
    initIAP()
    touchIAP()
  }
}


extension PurchaseTestVC {
  func initIAP() {
    
    addObserverAction(.restoreComplete) { noti in
      if let data = noti.object as? String {
        self.receipLabel.text = "구매내역 복구 완료. 아래에 영수증 번호가 표기됩니다."
        self.receipTextView.text = data
      }
    }
    
    addObserverAction(.purchaseComplete) { noti in
      if let data = noti.object as? String {
        self.receipLabel.text = "구매 완료. 아래에 영수증 번호가 표기됩니다."
        self.receipTextView.text = data
      }
    }
    
    PlanPurchaseItem.iapService.getProducts { [weak self] success, products in
        print("1 load products \(products ?? [])")
        guard let self = self else { return }
        if success, let products = products {
          DispatchQueue.main.async {

            self.firstProducts = products
            self.productss.append(contentsOf: self.firstProducts)
            self.purchaseLogTextView.text.removeAll()
            let item = self.firstProducts.first!


            self.purchaseLogTextView.text += "contentVersion : \(item.contentVersion)\n"
            self.purchaseLogTextView.text += "discounts :\(item.discounts)\n"
            self.purchaseLogTextView.text += "downloadContentLengths : \(item.downloadContentLengths)\n"

            self.purchaseLogTextView.text += "isDownloadable: \(item.isDownloadable)\n"

            self.purchaseLogTextView.text += "downloadContentVersion : \(item.downloadContentVersion)\n"
            self.purchaseLogTextView.text += "isFamilyShareable: \(item.isFamilyShareable)\n"
            self.purchaseLogTextView.text += "localizedTitle :\(item.localizedTitle)\n"
            self.purchaseLogTextView.text += "localizedDescription : \(item.localizedDescription)\n"
            self.purchaseLogTextView.text += "price: \(item.price)\n"
            self.purchaseLogTextView.text += "priceLocale: \(item.priceLocale)\n"
            self.purchaseLogTextView.text += "productIdentifier : \(item.productIdentifier)\n"

            

          }
        }
    }
    
  }
  
  // 인앱 결제 버튼 눌렀을 때
  func touchIAP() {
    firstButton.press {
      if let product = self.firstProducts.first {
        PlanPurchaseItem.iapService.buyProduct(product)
      }
    }

    restoreButton.press {
      if let product = self.firstProducts.first {
        PlanPurchaseItem.iapService.restorePurchases()
      }
    }
    
    copyButton.press{
      UIPasteboard.general.string = self.receipTextView.text
      self.makeAlert(content: "복사가 완료되었습니다.")
    }
    
  }
  
  @objc private func restore() {
    MyProducts.iapService.restorePurchases()
  }
}


struct PlanPurchaseItem {
  static var productID = ""
  static var iapService: IAPServiceType = IAPService(productIDs: Set<String>([productID]))
  
  static func getResourceProductName(_ id: String) -> String? {
    id.components(separatedBy: ".").last
  }
}
