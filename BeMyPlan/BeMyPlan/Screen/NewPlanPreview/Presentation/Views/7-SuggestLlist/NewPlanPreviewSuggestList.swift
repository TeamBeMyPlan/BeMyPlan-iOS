//
//  NewPlanPreviewSuggestList.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class NewPlanPreviewSuggestList: UITableViewCell, UITableViewRegisterable{
  
  static var isFromNib: Bool = true
  var viewModel: NewPlanPreviewSuggestViewModel? {didSet {
    contentCollectonView.reloadData()}}
  @IBOutlet var contentCollectonView: UICollectionView!
  @IBOutlet var contentCollectionViewHeightConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setDelegate()
    setLayout()
    registerCells()
  }
}

extension NewPlanPreviewSuggestList {
  
  private func setDelegate() {
    contentCollectonView.delegate = self
    contentCollectonView.dataSource = self
  }
  
  private func setLayout() {
    let cellWitdh = screenWidth * (160/375)
    contentCollectionViewHeightConstraint.constant = cellWitdh + 60
    setNeedsLayout()
  }
  
  private func registerCells() {
    NewPlanPreviewSuggestCVC.register(target: contentCollectonView)
  }
}

extension NewPlanPreviewSuggestList: UICollectionViewDelegate {
  
}

extension NewPlanPreviewSuggestList: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let suggestCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewPlanPreviewSuggestCVC.className,
                                                                 for: indexPath) as? NewPlanPreviewSuggestCVC,
            let viewModel = self.viewModel else { return UICollectionViewCell() }
      let cellViewModel = viewModel.list[indexPath.row]
      
    suggestCell.viewModel = cellViewModel
    return suggestCell
  }
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.list.count ?? 0
  }
}

extension NewPlanPreviewSuggestList: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWitdh = screenWidth * (160/375)
    let cellHeight = cellWitdh + 60
    return CGSize(width: cellWitdh, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.init(top: 0, left: 24, bottom: 0, right: 24)
  }
}

struct NewPlanPreviewSuggestViewModel {
  let list: [NewPlanPreviewSuggestCellViewModel]
}
