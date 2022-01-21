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
  
  private func setUIs() {
    contentImage.layer.cornerRadius = 5
    contentImage.contentMode = .scaleAspectFill
  }
  
  public func setData(data: ScrapItem) {
    contentImage.setImage(with: data.thumbnailURL)
    titleLabel.text = data.title
    
    scrapBtn.setImage(UIImage(named: "icnScrapWhite"), for: .normal)
  }
  
}
