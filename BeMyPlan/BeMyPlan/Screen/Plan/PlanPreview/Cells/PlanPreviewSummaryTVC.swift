//
//  PlanPreviewSummaryTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit

class PlanPreviewSummaryTVC: UITableViewCell {
  
  // MARK: - UI Component Part
  
  @IBOutlet var summaryContentTextView: UITextView!{
    didSet{
      let style = NSMutableParagraphStyle()
      style.lineHeightMultiple = 1.3
      let attributes = [NSAttributedString.Key.paragraphStyle: style]  as [NSAttributedString.Key: Any]
      
      summaryContentTextView.attributedText = NSAttributedString(
        string: summaryContentTextView.text,
        attributes: attributes)
      
      summaryContentTextView.font = UIFont.systemFont(ofSize: 14)
      summaryContentTextView.textColor = .grey01
      summaryContentTextView.textContainer.lineFragmentPadding = .zero
      
    }
  }
  
  // MARK: - Life Cycle Part
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  // MARK: - Custom Method Part
  
  func setSummaryData(content : String?){
    summaryContentTextView.text = (content != nil) ? content : ""
  }
  
}
