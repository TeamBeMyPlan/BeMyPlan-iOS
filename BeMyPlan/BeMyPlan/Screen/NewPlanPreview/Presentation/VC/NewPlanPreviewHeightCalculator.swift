//
//  NewPlanPreviewHeightCalculator.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/03.
//

import Foundation

struct NewPlanPreviewHeightCalculator {
  static let shared = NewPlanPreviewHeightCalculator()
  private init() { }
  
  func calculateCreatorCellHeight(text: String?) -> CGFloat {
    guard let text = text else { return 421 }
    let mockTextView = UILabel()
    mockTextView.font = .systemFont(ofSize: 14)
    mockTextView.setTextWithLineHeightMultiple(text: text, lineHeightMultiple: 1.31)
    mockTextView.frame = CGRect(x: 0, y: 0, width: screenWidth - 90, height: 0)
    mockTextView.text = text
    mockTextView.lineBreakMode = .byCharWrapping
    mockTextView.numberOfLines = 0
    mockTextView.sizeToFit()

    return mockTextView.frame.height + 240
  }
  
  func calculateMainCellHeight(textList: [String]? ) -> CGFloat {
    guard let textList = textList else { return 0 }
    
    var totalHeight = 0
    let mockTextView = UILabel()
    mockTextView.frame = CGRect(x: 0, y: 0, width: screenWidth - 90, height: 0)
    mockTextView.lineBreakMode = .byCharWrapping
    mockTextView.numberOfLines = 0

    let imageHeight = screenWidth * (435/375)
    let padding = 62
    
    for text in textList {
      mockTextView.setTextWithLineHeightMultiple(text: text, lineHeightMultiple: 1.31)
      mockTextView.font = .systemFont(ofSize: 14)
      mockTextView.text = text
      mockTextView.sizeToFit()
      totalHeight += Int(mockTextView.frame.height + imageHeight) + padding
    }
    
    return CGFloat(totalHeight)
    
  }
}
