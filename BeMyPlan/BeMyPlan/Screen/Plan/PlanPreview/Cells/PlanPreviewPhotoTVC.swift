//
//  PlanPreviewPhotoTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit
import SkeletonView

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
    makeShortContent(content: data.content)
    
    switch(data.height.case){
      case .valueExist:
        imageHeightConstraint.constant = cachedHeight != 0 ? cachedHeight : data.height.value
        
      default :
        if cachedHeight == 0 {
          imageHeightConstraint.constant = screenWidth
        } else {
          print("캐싱된 height",cachedHeight,data.content)
          imageHeightConstraint.constant = cachedHeight
//          self.layoutIfNeeded()
        }
    }

    contentImageView.setImage(with: data.photoUrl) { image in
      let height = self.makeImageHeight(image)
      
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.contentImageView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(1))
        print("--------------------")
        print("셀 내에서 계삳ㄴ된 높이",height)
        print("밖에서 꽂아준 height ",data.height.value)
        print("cachedHeight",cachedHeight,data.content)
        print("--------------------")
        print("WHAT..?",self.heightLoadComplete)

        if let heightLoadComplete = self.heightLoadComplete,
           data.height.value != height,
           cachedHeight == 0{
          print("INDDDDD",data.content)
          heightLoadComplete(height)
        }
      }

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
