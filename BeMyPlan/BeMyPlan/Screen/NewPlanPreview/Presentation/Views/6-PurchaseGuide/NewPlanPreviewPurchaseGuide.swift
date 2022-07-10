//
//  NewPlanPreviewPurchaseGuide.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

class NewPlanPreviewPurchaseGuide: XibView{
  
  var previewActionClickEvent: (() -> Void)?
  var viewModel: NewPlanPreviewPurchaseGuideViewModel!
  
  @IBOutlet var guideTableView: UITableView!
  @IBOutlet var previewActionTitleLabel: UILabel!
  @IBOutlet var previewActionButton: UIButton!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    registerCell()
    setDelegate()
    setButtonActions()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
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
    return viewModel.list.count
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
