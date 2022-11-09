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
  
  func calculateRecommendCellHeight(textList: [String]?) -> CGFloat {
    guard let textList = textList else { return 242 }
    var height: CGFloat = 0
    
    let mockTextView = UILabel()
    mockTextView.font = .systemFont(ofSize: 14)
    mockTextView.frame = CGRect(x: 0, y: 0, width: screenWidth - 113, height: 0)
    mockTextView.lineBreakMode = .byCharWrapping
    mockTextView.numberOfLines = 0
    
    for text in textList {
      mockTextView.text = text
      mockTextView.sizeToFit()
      height += mockTextView.frame.height + 28
    }
    return height + 113
  }
  
  func calculateCreatorCellHeight(text: String?) -> CGFloat {
    guard let text = text else { return 421 }
    let mockTextView = UITextView()
    mockTextView.font = .systemFont(ofSize: 14)
    mockTextView.setTextWithLineHeight(text: text, lineHeightMultiple: 1.31)
    mockTextView.removeMargin()
    mockTextView.textContainerInset = UIEdgeInsets.init(top: 21, left: 21, bottom: 0, right: 21)
    mockTextView.font = .systemFont(ofSize: 14)
    mockTextView.textContainer.lineBreakMode = .byWordWrapping
    mockTextView.sizeToFit()

    return mockTextView.frame.height + 241
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
