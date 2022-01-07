//
//  MainListCVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/07.
//

import UIKit

class MainListCVC: UICollectionViewCell {
  
  static let identifier = "MainListCVC"
  
  @IBOutlet var mainListImageView: UIImageView!
  @IBOutlet var mainListTitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUI()
  }
  
  // MARK: - Custom Method
  func setUI(){
    //이미지를 radius 적용안 한것을 줄 경우
    mainListImageView.layer.cornerRadius = 5
  }
  
  func setData(appData: MainListData){
    mainListImageView.image = appData.makeItemImage()
    mainListTitle.text = appData.title
  }
  
}
