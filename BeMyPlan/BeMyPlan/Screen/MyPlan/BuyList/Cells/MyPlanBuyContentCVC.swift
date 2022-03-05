//
//  MyPlanBuyContentCVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class MyPlanBuyContentCVC: UICollectionViewCell {
  @IBOutlet var contentImageView : UIImageView!
  @IBOutlet var titleLabel : UILabel!
  
  @IBOutlet var scrapImageView: UIImageView!
  var isScrap = false {
    didSet{
      setScrapImage()
    }
  }
  var postIdx: Int = 0
  
  var scrapClicked: ((Bool,Int) -> (Void))?
  
  func setContentData(title : String, imageURL: String,isScrap: Bool,postIdx: Int){
    contentImageView.layer.cornerRadius = 5
    titleLabel.text = title
    contentImageView.setImage(with: imageURL)
    self.isScrap = isScrap
    self.postIdx = postIdx
  }
  
  private func setScrapImage(){
    let image: UIImage
    isScrap ? (image = ImageLiterals.Scrap.scrapFIconFilled) : (image = ImageLiterals.Scrap.scrapIconNotFilled)
    scrapImageView.image = image
  }
  
  @IBAction func scrapButtonClicked(_ sender: Any) {
    isScrap.toggle()
    scrapClicked?(isScrap,postIdx)
  }
  
}
