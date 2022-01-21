//
//  PlanDetailWriterContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/19.
//

import UIKit

class PlanDetailWriterContainerView: XibView {

  var nickName : String = ""
  var authID = 0
  
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
  
  @IBOutlet var arrowIconImageView: UIImageView!
  
  @IBOutlet var nicknameClicked: UIButton!
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
  
  @IBAction func nicknameButtonClicked(_ sender: Any) {
    let data = PlanWriterDataModel.init(authorName: nickName,
                                        authorID: authID)
    NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .moveNicknamePlanList), object:data )
  }
  func setTitleData(title : String, writer: String,isPreviewPage : Bool,authorID : Int){
    writerLabel.text = title
    locationTitleView.text = writer
    locationTitleView.sizeToFit()
    arrowIconImageView.isHidden = isPreviewPage
    
    authID = authorID
    nickName = writer
  }
}


struct DetailHeaderData{
  var title : String
  var writer : String
}
