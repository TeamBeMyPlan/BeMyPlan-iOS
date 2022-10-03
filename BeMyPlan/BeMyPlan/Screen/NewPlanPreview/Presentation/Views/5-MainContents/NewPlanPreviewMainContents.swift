//
//  NewPlanPreviewMainContents.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit

final class NewPlanPreviewMainContents: UITableViewCell, UITableViewRegisterable{
  static var isFromNib: Bool = true
  var viewModel: NewPlanPreviewMainContentViewModel! { didSet { configureUI()}}
  
  @IBOutlet var placeCountDescriptionLabel: UILabel!
  @IBOutlet var contentTV: UITableView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    registerCell()
  }
}

extension NewPlanPreviewMainContents {
  private func configureUI() {
    contentTV.delegate = self
    contentTV.dataSource = self
    contentTV.isScrollEnabled = false
    contentTV.separatorStyle = .none
    
    let fullText = placeCountDescriptionLabel.text ?? ""
    let attributedString = NSMutableAttributedString(string: fullText)
    let highlightedWords = String(viewModel.contentList.count) + "곳"
    let textRange = (fullText as NSString).range(of: highlightedWords)
    let boldFont = UIColor.bemyBlue
    print("RANGE",textRange)
    attributedString.addAttributes([.foregroundColor : UIColor.bemyBlue,
                                    .font : UIFont.boldSystemFont(ofSize: 14)], range: textRange)

    placeCountDescriptionLabel.attributedText = attributedString
    placeCountDescriptionLabel.sizeToFit()
  }
  
  private func registerCell() {
    NewPlanMainContentsTVC.register(target: contentTV)
  }
}

extension NewPlanPreviewMainContents: UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let contentCell = tableView.dequeueReusableCell(withIdentifier: NewPlanMainContentsTVC.className, for: indexPath) as? NewPlanMainContentsTVC else { return UITableViewCell() }
    contentCell.selectionStyle = .none
    contentCell.viewModel = self.viewModel.contentList[indexPath.row]
    return contentCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.contentList.count
  }
}

struct NewPlanPreviewMainContentViewModel {
  let contentList: [NewPlanMainContentsCellViewModel]
}
