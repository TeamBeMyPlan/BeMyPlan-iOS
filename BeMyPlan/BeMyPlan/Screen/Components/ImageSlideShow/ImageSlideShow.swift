//
//  ImageSlideShow.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/07/04.
//

import UIKit

class ImageSlideShow: XibView{
  @IBOutlet var indexCounterView: ImageIndexContainerView!
  @IBOutlet var slideShowCV: UICollectionView! {
    didSet {
      slideShowCV.delegate = self
      slideShowCV.dataSource = self
    }
  }
  private var currentIndex = 0
  var viewModel: ImageContainerViewModel! { didSet{ setCounterView() }}
  override init(frame: CGRect) {
    super.init(frame: frame)
    registerCell()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    registerCell()
  }
}

extension ImageSlideShow {
  private func configureCV() {
    slideShowCV.decelerationRate = .fast
    slideShowCV.isPagingEnabled = false
    
    let layout = SlideShowCollectionViewFlowLayout()
    layout.itemSize = CGSize(width: bounds.width - 48, height: bounds.height)
    layout.minimumLineSpacing = 1
    layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    layout.scrollDirection = .horizontal
    slideShowCV.collectionViewLayout = layout
  }
  
  private func registerCell() {
    ImageSlideShowCVC.register(target: slideShowCV)
  }
  
  private func setCounterView() {
    indexCounterView.isHidden = self.viewModel.imgList.count <= 1
    indexCounterView.viewModel = .init(currentIndex: self.currentIndex,
      totalIndex: self.viewModel.imgList.count)
  }
}

extension ImageSlideShow: UICollectionViewDelegate, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.viewModel.imgList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let imgCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSlideShowCVC.className, for: indexPath) as? ImageSlideShowCVC else { return UICollectionViewCell() }
    imgCell.imageURL = self.viewModel.imgList[indexPath.row]
    return imgCell
  }
  
}

final class SlideShowCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let itemsCount = collectionView.numberOfItems(inSection: 0)

        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = min(currentPage + 1, itemsCount - 1)
        }

        let updatedOffset = (itemSize.width + minimumInteritemSpacing) * CGFloat(currentPage)
        previousOffset = updatedOffset

        return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
    }
}
