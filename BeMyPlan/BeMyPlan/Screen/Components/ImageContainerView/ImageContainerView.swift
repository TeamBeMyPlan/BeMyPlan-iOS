//
//  ImageContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/29.
//

import UIKit

class ImageContainerView: XibView{
  var viewModel: ImageContainerViewModel! { didSet{ setCounterView() }}
  private var currentIndex = 0 { didSet{ setCounterView() }}
  @IBOutlet var imageCounterContainerView: ImageIndexContainerView!
  @IBOutlet var photoCV: UICollectionView! { didSet {
    photoCV.delegate = self
    photoCV.dataSource = self
    photoCV.isPagingEnabled = true
  }}
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    registerCell()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    registerCell()
  }
  
  private func registerCell() {
    ImageContainerPhotoCell.register(target: photoCV)
  }
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

extension ImageContainerView: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let positionX = scrollView.contentOffset.x
    let index = positionX / self.bounds.width
    currentIndex = Int(index)
  }
}

extension ImageContainerView {
  private func setCounterView() {
    imageCounterContainerView.viewModel = .init(currentIndex: self.currentIndex,
                                                totalIndex: self.viewModel.imgList.count)
    imageCounterContainerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    imageCounterContainerView.layer.cornerRadius = 13
  }
}

struct ImageContainerViewModel {
  var imgList: [String]
}
