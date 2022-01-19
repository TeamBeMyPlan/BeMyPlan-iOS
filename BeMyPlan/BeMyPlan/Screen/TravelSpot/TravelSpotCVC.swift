//
//  TravelSpotCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/07.
//

import UIKit

class TravelSpotCVC: UICollectionViewCell {
  
  static let identifier = "TravelSpotCVC"
  
  @IBOutlet var locationImageView: UIImageView!
  @IBOutlet var lockImageView: UIImageView!
  @IBOutlet var locationLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUIs()
  }
  
  private func setUIs() {
    locationImageView.layer.cornerRadius = 5
    lockImageView.layer.cornerRadius = 5
    locationImageView.contentMode = .scaleAspectFill
  }
  
  public func setData(data: TravelSpotDataGettable){
    locationImageView.setImage(with: data.photoURL)
    locationLabel.text = data.name
  }
  
}

