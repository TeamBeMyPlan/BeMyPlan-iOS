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
    locationImageView.layer.cornerRadius = 5
    lockImageView.layer.cornerRadius = 5
  }
  

  
  //    func setData(locationName: String, locationImage: UIImage?) {
  //      locationImageView.image = locationImage
  //      locationLabel.text = locationName
  //    }
  
}
