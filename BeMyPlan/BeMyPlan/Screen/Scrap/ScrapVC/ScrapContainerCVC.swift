//
//  ScrapContainerCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit

class ScrapContainerCVC: UICollectionViewCell, UICollectionViewRegisterable {
  static var isFromNib: Bool = true  
  @IBOutlet var titleLabel: UILabel! {
    didSet {
      self.titleLabel.text = "어디로 여행을 떠나볼까아아아아아아"
    }
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
