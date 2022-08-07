//
//  HashtagContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class HashtagContainerView: XibView{
  var viewModel: HashtagContainerViewModel! { didSet{
    hashtagCV.reloadData() }}
  
  private let flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 6
    return layout
  }()
  
  @IBOutlet var hashtagCV: UICollectionView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    hashtagCV.delegate = self
    hashtagCV.dataSource = self
    hashtagCV.contentInset = .zero
    hashtagCV.collectionViewLayout = flowLayout
    HashtagCVC.register(target: hashtagCV)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    hashtagCV.delegate = self
    hashtagCV.dataSource = self
    hashtagCV.contentInset = .zero
    hashtagCV.collectionViewLayout = flowLayout
    HashtagCVC.register(target: hashtagCV)
  }
}

extension HashtagContainerView: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.hashtagList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let hashtagCell = collectionView.dequeueReusableCell(withReuseIdentifier: HashtagCVC.className, for: indexPath) as? HashtagCVC
    else { return UICollectionViewCell () }
    hashtagCell.layer.cornerRadius = 2
    hashtagCell.viewModel = self.viewModel.hashtagList[indexPath.row]
    return hashtagCell
  }
}

extension HashtagContainerView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let mockLabel = UILabel()
    mockLabel.font = .systemFont(ofSize: 10)
    mockLabel.text = viewModel.hashtagList[indexPath.row]
    mockLabel.sizeToFit()
    return CGSize(width: mockLabel.frame.width + 16, height: 25)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.zero
  }
}

struct HashtagContainerViewModel {
  let hashtagList: [HashtagCellViewModel]
}
