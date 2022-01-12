//
//  ScrapEmptyContainerView.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit

class ScrapEmptyContainerView: XibView {
  // static var isFromNib: Bool = true
  
  @IBOutlet var contentCV: UICollectionView!
  override init(frame: CGRect) {
    super.init(frame: frame)
    registerCells()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    registerCells()
  }
  
  
  
  func registerCells() {
    ScrapEmptyCotainerCVC.register(target: contentCV)
  }
  
}
