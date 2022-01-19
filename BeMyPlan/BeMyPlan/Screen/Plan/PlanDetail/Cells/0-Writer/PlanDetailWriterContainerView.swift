//
//  PlanDetailWriterContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/19.
//

import UIKit

class PlanDetailWriterContainerView: XibView {

  
  @IBOutlet var locationTitleView: UITextView!{
    didSet{
      locationTitleView.textContainerInset = .zero
      let style = NSMutableParagraphStyle()
      style.lineHeightMultiple = 1.15
      let attributes = [NSAttributedString.Key.paragraphStyle: style]  as [NSAttributedString.Key: Any]
      
      locationTitleView.attributedText = NSAttributedString(
          string: locationTitleView.text,
          attributes: attributes)

      locationTitleView.font = UIFont.boldSystemFont(ofSize: 20)
      locationTitleView.textColor = .grey01
    }
  }
  @IBOutlet var writerLabel: UILabel!
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setTextView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setTextView()
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


struct DetailHeaderData{
  var title : String
  var writer : String
}
