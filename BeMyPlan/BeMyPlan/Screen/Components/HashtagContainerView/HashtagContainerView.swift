//
//  HashtagContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class HashtagContainerView: XibView{
  var viewModel: HashtagContainerViewModel!
  
  @IBOutlet var hashtagCV: UICollectionView! { didSet {
    hashtagCV.delegate = self
    hashtagCV.dataSource = self
  }}
}

extension HashtagContainerView: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.hashtagList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let hashtagCell = collectionView.dequeueReusableCell(withReuseIdentifier: HashtagCVC.className, for: indexPath) as? HashtagCVC
    else { return UICollectionViewCell () }
    hashtagCell.viewModel = self.viewModel.hashtagList[indexPath.row]
    return hashtagCell
  }
}

extension HashtagContainerView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let mockLabel = UILabel()
    mockLabel.font = .systemFont(ofSize: 10)
    mockLabel.sizeToFit()
    return CGSize(width: mockLabel.frame.width + 16, height: 25)
  }
}

struct HashtagContainerViewModel {
  let hashtagList: [HashtagCellViewModel]
}
