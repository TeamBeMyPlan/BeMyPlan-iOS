//
//  ScrapContainerView.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit
import PanModal
import Moya

class ScrapContainerView: XibView {
  
  @IBOutlet var contentCV: UICollectionView!

  var scrapDataList: [ScrapDataGettable] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setAll()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setAll()
  }
  
  @IBAction func filterBtn(_ sender: Any) {
    NotificationCenter.default.post(name: NSNotification.Name("filterBottomSheet"), object: nil)
  }
  
  private func setAll() {
    registerCells()
    fetchScrapItemList()
    setDelegate()
  }
  
  private func registerCells() {
    ScrapContainerCVC.register(target: contentCV)
  }
  
  private func setDelegate() {
    contentCV.dataSource = self
    contentCV.delegate = self
  }
  
  private func fetchScrapItemList() {
    BaseService.default.getScrapList(userId: 1, page: 0, pageSize: 5, sort: "created_at") { result in
      result.success { data in
        self.scrapDataList = []
        if let testedData = data {
          self.scrapDataList = testedData
          dump("---> DDDD \(self.scrapDataList)")
        }
        self.contentCV.reloadData()
      }.catch { error in
        if let err = error as? MoyaError {
          dump("---> ScrapContainer \(err)")
        }
      }
    }
  }
  
  
}


extension ScrapContainerView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return scrapDataList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrapContainerCVC.className, for: indexPath) as? ScrapContainerCVC else {return UICollectionViewCell()
    }

    cell.titleLabel.text = scrapDataList[indexPath.row].title
    cell.contentImage.setImage(with: scrapDataList[indexPath.row].thumbnailURL)
    
    return cell
  }
}

extension ScrapContainerView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellHeight = screenWidth * (206/375)
    let cellWidth = screenWidth * (156/375)
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let inset = screenWidth * (24/375)
    return UIEdgeInsets(top: 0, left: inset, bottom: inset, right: inset)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
}
