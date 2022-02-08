//
//  PlanPreviewWriterTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit

class PlanPreviewWriterTVC: UITableViewCell,UITableViewRegisterable{
  
  // MARK: - Vars & Lets Part
  static var isFromNib: Bool = true
  // MARK: - UI Component Part
  
  var nickname : String = ""
  var authID : Int = 0
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var titleLabel: UITextView!{
    didSet{
      titleLabel.contentInset = .zero
      titleLabel.font = .boldSystemFont(ofSize: 20)
    }
  }
  
  // MARK: - Life Cycle Part
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: - IBAction Part
  
  
  @IBAction func nicknameButtonClicked(_ sender: Any) {
    let data = PlanWriterDataModel.init(authorName: nickname,
                                        authorID: authID)
    postObserverAction(.moveNicknamePlanList,object: data)
  }
  
  // MARK: - Custom Method Part
  private func setUI(){
    titleLabel.textContainerInset = .zero
    titleLabel.textContainer.lineFragmentPadding = .zero
    
    let style = NSMutableParagraphStyle()
    style.lineHeightMultiple = 1.2
    let attributes = [NSAttributedString.Key.paragraphStyle: style]  as [NSAttributedString.Key: Any]
    
    titleLabel.attributedText = NSAttributedString(
        string: titleLabel.text,
        attributes: attributes)

    titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    titleLabel.textColor = .grey01
    
  }
  
  func setHeaderData(author: String?, title : String?,authIDs: Int){
    if let author = author {
      nickname = author
    }
    authID = authIDs
    authorLabel.text = (author != nil) ? author : ""
    titleLabel.text = (title != nil) ? title : ""
    titleLabel.sizeToFit()
  }
  
  
}

struct PlanWriterDataModel{
  var authorName : String
  var authorID : Int
}
