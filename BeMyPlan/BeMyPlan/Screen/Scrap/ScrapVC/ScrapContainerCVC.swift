//
//  ScrapContainerCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit

class ScrapContainerCVC: UICollectionViewCell, UICollectionViewRegisterable {
  @IBOutlet var scrapBtn: UIButton!
  static var isFromNib: Bool = true
  @IBOutlet var titleLabel: UILabel! {
    didSet {
      self.titleLabel.text = "어디로 여행을 어디로 여행을 어디로 여행을 어디로 여행을 어디로 여행을 어디로 여행을 어디로 여행을 어디로 여행을 어디로 여행을 "
    }
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
// setFont()
        // Initialization code
    }

  @IBAction func scrapBtnTapped(_ sender: Any) {
    scrapBtn.isSelected.toggle()
  }
  
  func setFont() {
//    setFontLabel(text: titleLabel.text ?? "", lineSpacing: 20, fontName: "SpoqaHanSansNeo-Bold", fontSize: 14, textColor: UIColor.grey01, textType: titleLabel)
  }
  
}
