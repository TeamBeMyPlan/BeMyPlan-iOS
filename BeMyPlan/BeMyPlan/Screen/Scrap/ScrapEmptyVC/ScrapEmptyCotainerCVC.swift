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
  @IBOutlet var titleLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUIs()
  }
  
  private func setUIs() {
    contentImage.contentMode = .scaleAspectFill
    contentImage.layer.cornerRadius = 5
  }
  
  public func setData(data: ScrapEmptyDataGettable) {
    contentImage.setImage(with: data.thumbnailURL)
    titleLabel.text = data.title
  }
  
}
