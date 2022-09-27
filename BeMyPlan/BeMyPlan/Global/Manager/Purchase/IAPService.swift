
import StoreKit

typealias ProductsRequestCompletion = (_ success: Bool, _ products: [SKProduct]?) -> Void

protocol IAPServiceType {
  var canMakePayments: Bool { get }
  
  func getProducts(completion: @escaping ProductsRequestCompletion)
  func buyProduct(_ product: SKProduct)
  func isProductPurchased(_ productID: String) -> Bool
  func restorePurchases()
}

final class IAPService: NSObject, IAPServiceType {
  private let productIDs: Set<String>
  private var purchasedProductIDs: Set<String>
  private var productsRequest: SKProductsRequest?
  private var productsCompletion: ProductsRequestCompletion?
  
  var canMakePayments: Bool {
    SKPaymentQueue.canMakePayments()
  }
  
  init(productIDs: Set<String>) {
    self.productIDs = productIDs
    self.purchasedProductIDs = productIDs
      .filter { UserDefaults.standard.bool(forKey: $0) == true }
    
    super.init()
    SKPaymentQueue.default().add(self)
  }
  
  func getProducts(completion: @escaping ProductsRequestCompletion) {
    self.productsRequest?.cancel()
    self.productsCompletion = completion
    self.productsRequest = SKProductsRequest(productIdentifiers: self.productIDs)
    self.productsRequest?.delegate = self
    self.productsRequest?.start()
  }
  func buyProduct(_ product: SKProduct) {
    print("buyProduct")
    SKPaymentQueue.default().add(SKPayment(product: product))
  }
  func isProductPurchased(_ productID: String) -> Bool {
    self.purchasedProductIDs.contains(productID)
  }
  func restorePurchases() {
    print("restorePurchase")
          
    SKPaymentQueue.default().restoreCompletedTransactions()
  }
}

extension IAPService: SKProductsRequestDelegate {
  // didReceive
  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    let products = response.products
    self.productsCompletion?(true, products)
    self.clearRequestAndHandler()
    
    products.forEach { print("Found product: \($0.productIdentifier) \($0.localizedTitle) \($0.price.floatValue)") }
  }
  
  // failed
  func request(_ request: SKRequest, didFailWithError error: Error) {
    print("Erorr: \(error.localizedDescription)")
    self.productsCompletion?(false, nil)
    self.clearRequestAndHandler()
  }
  
  private func clearRequestAndHandler() {
    self.productsRequest = nil
    self.productsCompletion = nil
  }
}

extension IAPService: SKPaymentTransactionObserver {
  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

    transactions.forEach {
      switch $0.transactionState {
      case .purchased:
        print("completed purchased")
        self.deliverPurchaseNotificationFor(id: $0.original?.payment.productIdentifier)
          NotificationCenter.default.post(
            name: BaseNotiList.makeNotiName(list: .purchaseComplete),
            object: getReceiptData()!
          )
      case .failed:
        if let transactionError = $0.error as NSError?,
           let description = $0.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
          print("Transaction erorr: \(description)")
        }
        SKPaymentQueue.default().finishTransaction($0)
      case .restored:
        print("===========restored transaction")
        self.deliverPurchaseNotificationFor(id: $0.original?.payment.productIdentifier)
          NotificationCenter.default.post(
            name: BaseNotiList.makeNotiName(list: .restoreComplete),
            object: getReceiptData()!
          )

        SKPaymentQueue.default().finishTransaction($0)
      case .deferred:
        print("deferred")
      case .purchasing:
        print("purchasing")
      default:
        print("unknown")
      }
    }
  }
  
  func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {

    for item in queue.transactions {
      self.deliverPurchaseNotificationFor(id: item.original?.payment.productIdentifier)
        NotificationCenter.default.post(
          name: BaseNotiList.makeNotiName(list: .restoreComplete),
          object: getReceiptData()!
        )
    }
  }
  
  
  private func deliverPurchaseNotificationFor(id: String?) {
    print("현재 IDsss",id)

    guard let id = id else { return }
  
    self.purchasedProductIDs.insert(id)
    UserDefaults.standard.set(true, forKey: id)
    NotificationCenter.default.post(
      name: BaseNotiList.makeNotiName(list: .IAPServicePurchaseNotification),
      object: id
    )
  }
}

extension IAPService {
  
    // 구매이력 영수증 가져오기 - 검증용
    public func getReceiptData() -> String? {
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                let receiptString = receiptData.base64EncodedString(options: [])
                return receiptString
            }
            catch {
                print("Couldn't read receipt data with error: " + error.localizedDescription)
                return nil
            }
        }
        return nil
    }
}
