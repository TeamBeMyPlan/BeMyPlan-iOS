//
//  PlanPreviewRecommendTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit

class PlanPreviewRecommendTVC: UITableViewCell {

  // MARK: - Vars & Lets Part

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var contentTextView: UITextView!{
    didSet{
      let style = NSMutableParagraphStyle()
      style.lineHeightMultiple = 1.3
      let attributes = [NSAttributedString.Key.paragraphStyle: style]  as [NSAttributedString.Key: Any]
      
      contentTextView.attributedText = NSAttributedString(
          string: contentTextView.text,
          attributes: attributes)

      contentTextView.font = UIFont.systemFont(ofSize: 14)
      contentTextView.textColor = .grey01
      contentTextView.textContainer.lineFragmentPadding = .zero
    }
  }
  // MARK: - UI Component Part

  
  // MARK: - Life Cycle Part

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
  
  // MARK: - Custom Method Part
  
  func setRecommendData(title : String?,content : String?){
    titleLabel.text = (title != nil) ? title : ""
    contentTextView.text = (content != nil) ? content : ""
  }

  
  // MARK: - @objc Function Part

}
