//
//  setTextLineHeight + UILabel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

extension UILabel {
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style
            ]
                
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}

extension UILabel {
  func setTextWithLineHeightMultiple(text: String?, lineHeightMultiple: CGFloat) {
    if let text = text {
      let style = NSMutableParagraphStyle()
      style.lineHeightMultiple = lineHeightMultiple
      
      let attributes: [NSAttributedString.Key: Any] = [
        .paragraphStyle: style
      ]
      
      let attrString = NSAttributedString(string: text,
                                          attributes: attributes)
      self.attributedText = attrString
    }
  }
}

extension UITextView {
  func setTextWithLineHeight(text: String?, lineHeightMultiple: CGFloat) {
    if let text = text {
      let style = NSMutableParagraphStyle()
      style.lineHeightMultiple = lineHeightMultiple
      
      let attributes: [NSAttributedString.Key: Any] = [
        .paragraphStyle: style
      ]
      
      let attrString = NSAttributedString(string: text,
                                          attributes: attributes)
      self.attributedText = attrString
    }
  }
}
