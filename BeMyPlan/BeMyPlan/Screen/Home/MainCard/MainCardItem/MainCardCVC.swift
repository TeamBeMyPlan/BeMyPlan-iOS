//
//  MainCardCVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/06.
//

import UIKit
import Kingfisher

class MainCardCVC: UICollectionViewCell {
 
  @IBOutlet var mainCardImageLayer: UIView!
  @IBOutlet var mainCardImageView: UIImageView!
  @IBOutlet var mainCardCategory: UILabel!
  @IBOutlet var mainCardTitle: UILabel!
  
  // MARK: - Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setUI()
  }
  
  // MARK: - Custom Method
  func setUI(){
    contentView.layer.masksToBounds = true
    contentView.layer.cornerRadius = 5
    mainCardImageLayer.layer.cornerRadius = 5
    //이미지를 radius 적용안 한것을 줄 경우
    mainCardImageView.layer.cornerRadius = 5
    
    
  }
  
  func setData(appData: HomeListDataGettable.Item){
//    mainCardImageView.image = appData.makeItemImage()
    mainCardImageView.setImage(with: appData.thumbnailURL)
//    mainCardCategory.text = appData.category
    mainCardTitle.text = appData.title
  }
}
