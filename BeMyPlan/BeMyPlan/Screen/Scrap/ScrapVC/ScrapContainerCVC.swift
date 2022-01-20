//
//  ScrapContainerCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit

class ScrapContainerCVC: UICollectionViewCell, UICollectionViewRegisterable {
  static var isFromNib: Bool = true

  @IBOutlet var contentImage: UIImageView!
  @IBOutlet var scrapBtn: UIButton!
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
  
  public func setData(data: ScrapDataGettable) {
    contentImage.setImage(with: data.thumbnailURL)
    titleLabel.text = data.title
  }
  
}
