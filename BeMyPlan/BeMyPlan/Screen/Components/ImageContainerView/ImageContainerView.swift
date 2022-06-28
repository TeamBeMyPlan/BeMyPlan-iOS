//
//  ImageContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/29.
//

import UIKit

class ImageContainerView: XibView{
  var viewModel: ImageContainerViewModel! { didSet{ setCounterView() }}
  
  @IBOutlet var imageCounterContainerView: ImageIndexContainerView!
  @IBOutlet var photoCV: UICollectionView! { didSet {
    photoCV.delegate = self
    photoCV.dataSource = self
    photoCV.isPagingEnabled = true
  }}
}

extension ImageContainerView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.imgList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let imgCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageContainerPhotoCell.className, for: indexPath) as? ImageContainerPhotoCell else { return UICollectionViewCell() }
    imgCell.viewModel = .init(imgURL: self.viewModel.imgList[indexPath.row])
    return imgCell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.frame.width, height: self.frame.height)
  }
}

extension ImageContainerView {
  private func setCounterView() {
    imageCounterContainerView.viewModel = .init(currentIndex: self.viewModel.currentIndex,
      totalIndex: self.viewModel.imgList.count)
  }
}

struct ImageContainerViewModel {
  var currentIndex: Int
  var imgList: [String]
}
