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
  
  public func setData(_ data: PurchaseConfirmDataModel) {
    thumbnailImageView.setImage(with: data.imageURL)
    creatorLabel.text = data.creator
    titleLabel.text = data.title
    locationLabel.text = data.location
    priceLabel.text = data.price
  }
}

struct PurchaseConfirmDataModel {
  let imageURL: String
  let creator: String
  let title: String
  let location: String
  let price: String
}
