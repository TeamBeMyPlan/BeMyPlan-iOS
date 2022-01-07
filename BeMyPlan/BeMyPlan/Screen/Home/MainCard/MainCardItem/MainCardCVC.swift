//
//  MainCardCVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit

class MainCardCVC: UICollectionViewCell {
  
  static let identifier = "MainCardCVC"
  
  @IBOutlet var mainCardImageView: UIImageView!
  @IBOutlet var mainCardCategory: UILabel!
  @IBOutlet var mainCardTitle: UILabel!
  
  // MARK: - Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - Custom Method
  func setData(appData: MainCardData){
    mainCardImageView.image = appData.makeItemImage()
    mainCardCategory.text = appData.category
    mainCardTitle.text = appData.title
  }
}
