//
//  PlanPreviewPhotoTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit
import SkeletonView
import Kingfisher

class PlanPreviewPhotoTVC: UITableViewCell {
  
  // MARK: - Vars & Lets Part
  var heightLoadComplete: ((CGFloat) -> ())?
  
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
  @IBOutlet var textViewHeightConstraint: NSLayoutConstraint!
  // MARK: - Life Cycle Part
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUI()
    setSkeletonUI()
  }
  
  override func prepareForReuse() {
    contentImageView.kf.cancelDownloadTask() // first, cancel currenct download task
    contentImageView.image = nil
//    setSkeletonUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  // MARK: - IBAction Part
  
  // MARK: - Custom Method Part
  private func setUI(){
    contentImageView.layer.cornerRadius = 5
  }
  
  private func setSkeletonUI(){
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    contentImageView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation, transition: .none)
  }
  
  func setPhotoData(_ data : PlanPreview.PhotoData,_ cachedHeight: CGFloat = 0){
    contentTextView.text = data.content
    textViewHeightConstraint.constant = makeTextHeight(data.content)
    
    switch(data.height.case){
      case .valueExist:
        imageHeightConstraint.constant = cachedHeight != 0 ? cachedHeight : data.height.value
        
      default :
        if cachedHeight == 0 {
          imageHeightConstraint.constant = screenWidth
        } else {
          imageHeightConstraint.constant = cachedHeight
//          self.layoutIfNeeded()
        }
    }

    contentImageView.setImage(with: data.photoUrl) { image in
      let height = self.makeImageHeight(image)
      
        self.contentImageView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.2))
        if let heightLoadComplete = self.heightLoadComplete,
           data.height.value != height,
           cachedHeight == 0{
          heightLoadComplete(height)
        }
    }
  }
  

  private func makeTextHeight(_ text: String) -> CGFloat{
    return calculateTextViewHeight(width: screenWidth - 48,
                                   font: .systemFont(ofSize: 14),
                                   lineHeightMultiple: 1.31, text: text)
  }
  
  private func calculateTextViewHeight(width: CGFloat,font: UIFont, lineHeightMultiple: CGFloat, text: String) -> CGFloat {
    let mockTextView = UITextView()
    let newSize = CGSize(width: width, height: CGFloat.infinity)
    mockTextView.textContainerInset = .zero
    mockTextView.textContainer.lineFragmentPadding = 0
    mockTextView.setTextWithLineHeight(text: text, lineHeightMultiple: lineHeightMultiple)
    mockTextView.isScrollEnabled = false
    mockTextView.translatesAutoresizingMaskIntoConstraints = false
    mockTextView.font = font
    let estimatedSize = mockTextView.sizeThatFits(newSize)
    return estimatedSize.height + 20
  }
  
  private func makeImageHeight(_ image: UIImage?) -> CGFloat {
    let imageViewWidth = screenWidth - 48
    if let img = image {
      let ratio = img.size.width / img.size.height
      let heightForDevice = imageViewWidth / ratio
      return heightForDevice
    } else {
      return screenWidth
    }
  }
}
