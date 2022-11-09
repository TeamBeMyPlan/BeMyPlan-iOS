//
//  PurchaseConfirmView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/08/31.
//

import UIKit

class PurchaseConfirmView: XibView{
  
  @IBOutlet var thumbnailImageView: UIImageView!
  @IBOutlet var creatorLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var termTextView: UITextView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUI()
  }
  
  
  private func setUI() {
    termTextView.removeMargin()
  }
  
  public func setData(_ data: PurchaseConfirmDataModel) {
    thumbnailImageView.setImage(with: data.imageURL)
    creatorLabel.text = data.creator
    titleLabel.text = data.title
    locationLabel.text = data.location
    priceLabel.text = data.price
  }
}

struct PurchaseConfirmDataModel {
  var imageURL: String = ""
  var creator: String = ""
  var title: String = ""
  var location: String = ""
  var price: String = ""
}
