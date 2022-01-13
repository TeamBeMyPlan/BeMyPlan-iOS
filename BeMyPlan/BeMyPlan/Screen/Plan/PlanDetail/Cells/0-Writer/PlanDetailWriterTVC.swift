//
//  PlanDetailWriterTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/13.
//

import UIKit

class PlanDetailWriterTVC: UITableViewCell,UITableViewRegisterable{
  
  static var isFromNib: Bool = true
  
  @IBOutlet var locationTitleView: UITextView!
  @IBOutlet var writerLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setTextView()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func setTextView(){
    locationTitleView.textContainer.lineFragmentPadding = .zero
    locationTitleView.textContainerInset = .zero
  }
  
  func setTitleData(title : String, writer: String){
    writerLabel.text = title
    locationTitleView.text = writer
    locationTitleView.sizeToFit()
  }
  
}
