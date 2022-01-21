//
//  TravelSpotDetailTVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/07.
//

import UIKit
import Moya

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
  
  private var postId:Int = 1
  private var userId:Int = 1
  private var scrapBtnData: [ScrapBtnDataGettable] = []
  
  @IBOutlet var contentImage: UIImageView!
  @IBOutlet var nickNameLabel: UILabel!
  @IBOutlet var titleTextView: UITextView!
  @IBOutlet var scrapBtn: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUIs()
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
    contentImage.layer.cornerRadius = 5
    contentImage.contentMode = .scaleAspectFill
  }
  
  public func setData(data: HomeListDataGettable.Item){
    contentImage.setImage(with: data.thumbnailURL)
    titleTextView.text = data.title
    nickNameLabel.text = data.nickname
    postId = data.id
  }
  
  public func scrapBtnAPI() {
//    BaseService.default.postScrapBtnTapped(postId: postId, userId: userId) { result in
    BaseService.default.postScrapBtnTapped(postId: postId) { result in
      result.success { data in
        self.scrapBtnData = []
        if let testedData = data {
          print("---> 버튼클릭값 \(testedData)")
          self.scrapBtnData = testedData
        }
      }.catch { error in
        if let err = error as? MoyaError {
          dump(err)
        }
      }
    }
  }
    
  
  
  @IBAction func scrapBtnTapped(_ sender: Any) {
    scrapBtnAPI()
    if scrapBtnData.count != 0 {
      scrapBtn.isSelected.toggle()
      scrapBtnData = []
      //        if scrapBtnData[0].scrapped == true {
      //          scrapBtn.isSelected.toggle()
      //          scrapBtnData = []
      //        } else {
      //          scrapBtn.isSelected.toggle()
      //        }
    }
  }
}
