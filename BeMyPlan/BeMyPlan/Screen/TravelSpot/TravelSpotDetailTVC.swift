//
//  TravelSpotDetailTVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/07.
//

import UIKit

func setFontTextView(text: String, lineSpacing: CGFloat, fontName: String, fontSize: CGFloat, textColor: UIColor, textType: UITextView) {
  let attributedString = NSMutableAttributedString(string: text)
  let paragraphStyle = NSMutableParagraphStyle()
  paragraphStyle.lineSpacing = lineSpacing
  attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
  textType.attributedText = attributedString
  textType.font = UIFont(name: fontName, size: fontSize)
  textType.textColor = textColor
}


class TravelSpotDetailTVC: UITableViewCell {
  
  static let identifier = "TravelSpotDetailTVC"
  
  @IBOutlet var contentImage: UIImageView!
  @IBOutlet var nickNameLabel: UILabel!
  @IBOutlet var titleTextView: UITextView!
  @IBOutlet var scrapBtn: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUIs()
    setFont ()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  private func setUIs() {
    titleTextView.textContainer.maximumNumberOfLines = 2
    titleTextView.textContainerInset = .zero
    titleTextView.textContainer.lineFragmentPadding = .zero
    titleTextView.textContainer.lineBreakMode = .byTruncatingTail
  }
  
  func setFont () {
//    setFontTextView(text: titleTextView.text, lineSpacing: 20, fontName: "SpoqaHanSansNeo-Bold", fontSize: 20, textColor: UIColor.grey01, textType: titleTextView)
  }
  
  
  @IBAction func scrapBtnTapped(_ sender: Any) {
    scrapBtn.isSelected.toggle()
  }
}
