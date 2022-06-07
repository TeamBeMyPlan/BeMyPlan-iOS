//
//  setAttributedText.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/04.
//

import Foundation

extension UITextView {
  func setTargetAttributedText(targetString : String, fontType: UIFont, color: UIColor? = nil, text: String? = nil) {
    
    let fullText = self.text ?? ""
    let range = (fullText as NSString).range(of: targetString)
    let attributedString = NSMutableAttributedString(string: fullText)
    
    
    attributedString.addAttribute(.font, value: fontType, range: range)
    
    
    if let textColor = color {
       attributedString.addAttribute(.foregroundColor, value: textColor, range: range)
    }
    
    self.attributedText = attributedString
    
  }
}


extension NSMutableAttributedString {

    func bold(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {

      let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: fontSize)]

        self.append(NSMutableAttributedString(string: text, attributes: attrs))

        return self

    }
    func normal(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {

      let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]

        self.append(NSMutableAttributedString(string: text, attributes: attrs))

        return self

    }

}
