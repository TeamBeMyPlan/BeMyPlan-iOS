//
//  ScrapEmptyCotainerCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit

class ScrapEmptyCotainerCVC: UICollectionViewCell,UICollectionViewRegisterable {
  static var isFromNib: Bool = true
  @IBOutlet var titleLabel: UILabel! {
    didSet {
      self.titleLabel.text = "여행의 즐거움을 느끼고 싶다면."
    }
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUIs()
  }
  
  private func setUIs() {
  }
  
}
