//
//  ScrapEmptyContainerView.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit

class ScrapEmptyContainerView: XibView {
  
  @IBOutlet var emptyLabel: UILabel!
  @IBOutlet var contentCV: UICollectionView!
  override init(frame: CGRect) {
    super.init(frame: frame)
    registerCells()
    contentCV.dataSource = self
    contentCV.delegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    registerCells()
    contentCV.dataSource = self
    contentCV.delegate = self
  }
  
  
  
  func registerCells() {
    ScrapEmptyCotainerCVC.register(target: contentCV)
  }
  
  func setUIs() {
  }
  
}

extension ScrapEmptyContainerView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrapEmptyCotainerCVC.className, for: indexPath) as? ScrapEmptyCotainerCVC else {return UICollectionViewCell()}
    return cell
  }  
}


extension ScrapEmptyContainerView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = screenWidth * (160/375)
    let cellHeight = screenWidth * (212/375)
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let inset = screenWidth * (24/375)
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: inset)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 12
  }
}
