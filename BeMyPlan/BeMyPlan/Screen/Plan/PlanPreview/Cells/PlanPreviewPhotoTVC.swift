//
//  PlanPreviewPhotoTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit

class PlanPreviewPhotoTVC: UITableViewCell {
  
  // MARK: - Vars & Lets Part
  
  @IBOutlet var contentImageView: UIImageView!
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
  @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
  
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
    contentImageView.layer.cornerRadius = 5
  }
  
  func setPhotoData(_ data : PlanPreview.PhotoData){
    makeShortContent(content: data.content)

    contentImageView.setImage(with: data.photoUrl) { image in
      if data.height.case != .valueExist{
        self.imageHeightConstraint.constant = self.makeImageHeight(image)
        self.contentView.layoutIfNeeded()
      }
    }
    switch(data.height.case){
      case .valueExist:
        imageHeightConstraint.constant = data.height.value
      case .calculateHeightFail,.invalidURL:
        imageHeightConstraint.constant = screenWidth
      default :
        imageHeightConstraint.constant = 0
    }
  }
  
  private func makeShortContent(content: String){
    if content.count < 100{
      contentTextView.text = content
    }else{
      contentTextView.text = content.prefix(99) + "..."
    }
  }
  
  private func makeImageHeight(_ image: UIImage?) -> CGFloat {
    if let img = image {
      let ratio = img.size.height / img.size.width
      let imageViewWidth = screenWidth - 48
      return imageViewWidth * ratio
    } else {
      return screenWidth
    }
  }
}
