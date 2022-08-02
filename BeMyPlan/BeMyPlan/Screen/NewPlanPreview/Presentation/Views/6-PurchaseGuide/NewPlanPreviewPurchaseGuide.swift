//
//  NewPlanPreviewPurchaseGuide.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class NewPlanPreviewPurchaseGuide: UITableViewCell, UITableViewRegisterable {
  
  static var isFromNib: Bool = true
  var previewActionClickEvent: (() -> Void)?
  var viewModel: NewPlanPreviewPurchaseGuideViewModel! {didSet{ guideTableView.reloadData()}}
  
  @IBOutlet var guideTableView: UITableView!
  @IBOutlet var previewActionTitleLabel: UILabel!
  @IBOutlet var previewActionButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    registerCell()
    setDelegate()
    setButtonActions()
  }
}

extension NewPlanPreviewPurchaseGuide {
  private func setUI() {
    previewActionTitleLabel.font = .getSpooqaMediumFont(size: 14)
  }
  
  private func setDelegate() {
    guideTableView.delegate = self
    guideTableView.dataSource = self
  }
  
  private func registerCell() {
    NewPlanPreviewPurchaseGuideTVC.register(target: guideTableView)
  }
  
  private func setButtonActions() {
    previewActionButton.press {
      self.previewActionClickEvent?()
    }
  }
}

extension NewPlanPreviewPurchaseGuide: UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if viewModel == nil { return 0 }
    else {
      return viewModel.list.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let guideCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewPurchaseGuideTVC.className, for: indexPath) as? NewPlanPreviewPurchaseGuideTVC
    else { return UITableViewCell() }
    guideCell.viewModel = viewModel.list[indexPath.row]
    guideCell.selectionStyle = .none
    return guideCell
  }
}

extension NewPlanPreviewPurchaseGuide: UITableViewDataSource {
  
}

struct NewPlanPreviewPurchaseGuideViewModel {
  let list: [PurchaseGuideCellViewModel]
}
