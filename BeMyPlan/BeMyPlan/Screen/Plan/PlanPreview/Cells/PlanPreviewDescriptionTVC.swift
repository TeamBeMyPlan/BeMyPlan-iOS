//
//  PlanPreviewDescriptionTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit

class PlanPreviewDescriptionTVC: UITableViewCell {

  // MARK: - Vars & Lets Part

  // MARK: - UI Component Part
  @IBOutlet var descriptionTextView: UITextView!
  @IBOutlet var descriptionIconView: PreviewIconContainerView!
  
  // MARK: - Life Cycle Part

    override func awakeFromNib() {
        super.awakeFromNib()
      setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
  // MARK: - IBAction Part

  
  // MARK: - Custom Method Part
  
  private func setUI(){
    
    descriptionTextView.backgroundColor = .grey06
    descriptionTextView.layer.cornerRadius = 5
    descriptionTextView.textContainerInset = UIEdgeInsets(top: 18, left: 16, bottom: 18, right: 16)
    
    let style = NSMutableParagraphStyle()
    style.lineHeightMultiple = 1.3
    let attributes = [NSAttributedString.Key.paragraphStyle: style]  as [NSAttributedString.Key: Any]
    
    descriptionTextView.attributedText = NSAttributedString(
        string: descriptionTextView.text,
        attributes: attributes)

    descriptionTextView.font = UIFont.systemFont(ofSize: 14)
    descriptionTextView.textColor = .grey01
    
    descriptionIconView.layer.cornerRadius = 5
    descriptionIconView.layer.borderColor = UIColor.grey04.cgColor
    descriptionIconView.layer.borderWidth = 1
  }
  
  func setDescriptionData(contentData : PlanPreview.DescriptionData?){
    if let contentData = contentData{
      descriptionTextView.text = contentData.descriptionContent
      descriptionIconView.setIconData(iconData: contentData.summary)
    }else{
      descriptionTextView.text = ""
    }
  }

  
  // MARK: - @objc Function Part

}

// MARK: - Extension Part







