//
//  ScrapEmptyCotainerCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit

class ScrapEmptyCotainerCVC: UICollectionViewCell,UICollectionViewRegisterable {
  @IBOutlet var contentImage: UIImageView!
  static var isFromNib: Bool = true
  @IBOutlet var titleLabel: UILabel! {
    didSet {
      self.titleLabel.text = "여행의 즐거움을 느끼고 싶다면."
    }
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  public func setData(data: ScrapDataGettable) {
    contentImage.setImage(with: data.thumbnailURL)
    titleLabel.text = data.title
  }

  
}
