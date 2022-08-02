//
//  removeTextViewMargin.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/07/04.
//

import UIKit

extension UITextView {
  func removeMargin() {
    self.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    self.textContainer.lineFragmentPadding = 0
  }
}
