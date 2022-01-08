//
//  PlanPreviewWriterTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit

class PlanPreviewWriterTVC: UITableViewCell {
  
  // MARK: - Vars & Lets Part
  
  
  // MARK: - UI Component Part
  
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var titleLabel: UITextView!{
    didSet{
      titleLabel.contentInset = .zero
    }
  }
  
  // MARK: - Life Cycle Part
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: - IBAction Part
  
  
  // MARK: - Custom Method Part
  
  func setHeaderData(author: String, title : String){
    authorLabel.text = author
    titleLabel.text = title
    titleLabel.sizeToFit()
  }
  
  
}








