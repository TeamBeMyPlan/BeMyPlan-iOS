//
//  OnboardingVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/11.
//

import UIKit
import Then

final class OnboardingVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private var pageIndex = 0{ didSet { setPageControlImage() }}
  
  // MARK: - UI Component Part
  
  lazy var mainContentView = UIView()

  lazy var contentScrollInnerView = UIView()
  lazy var bottomPageControlView = UIView()
  
  lazy var nextActionButton = UIButton().then {
    $0.isExclusiveTouch = true
  }
  
  lazy var skipActionButton = UIButton().then {
    $0.isExclusiveTouch = true
  }
  
  lazy var imageStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.spacing = 0
    $0.axis = .horizontal
  }
  lazy var contentScrollView = UIScrollView().then {
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.isExclusiveTouch = true
    $0.bounces = false
    $0.delegate = self
  }

  lazy var headerFirstLabel = UILabel().then {
    $0.setTextWithLineHeight(text: "여행 취향이 비슷한 크리에이터의 \n여행 일정을 찾아보세요",
                             lineHeight: screenWidth*25/375)
    $0.font = .boldSystemFont(ofSize: screenWidth*18/375)
    $0.numberOfLines = 0
    $0.textColor = .grey01
    $0.textAlignment = .center
    $0.alpha = 1
  }
  
  lazy var headerSecondLabel = UILabel().then {
    $0.setTextWithLineHeight(text: "미리보기로 원하는\n여행인지 확인하세요",
                             lineHeight: screenWidth*25/375)
    $0.font = .boldSystemFont(ofSize: screenWidth*18/375)
    $0.numberOfLines = 0
    $0.textColor = .grey01
    $0.textAlignment = .center
    $0.alpha = 0
  }
  
  lazy var headerThirdLabel = UILabel().then {
    $0.setTextWithLineHeight(text: "여행 일정을 구매하여\n알찬 여행 정보를 만나보세요",
                             lineHeight: screenWidth*25/375)
    $0.font = .boldSystemFont(ofSize: screenWidth*18/375)
    $0.numberOfLines = 0
    $0.textColor = .grey01
    $0.textAlignment = .center
    $0.alpha = 0
  }
  
  lazy var contentFirstImageView = UIImageView().then {
    $0.image = UIImage(named: "img_onboarding_01")
    $0.contentMode = .scaleAspectFit
  }
  
  lazy var contentSecondImageView = UIImageView().then {
    $0.image = UIImage(named: "img_onboarding_02")
    $0.contentMode = .scaleAspectFit
  }
  
  lazy var contentThirdImageView = UIImageView().then {
    $0.image = UIImage(named: "img_onboarding_03")
    $0.contentMode = .scaleAspectFit
  }
  
  lazy var nextButtonLabel = UILabel().then {
    $0.font = .boldSystemFont(ofSize: 16)
    $0.textColor = .bemyBlue
    $0.text = "다음"
  }
  
  lazy var skipButtonLabel = UILabel().then {
    $0.font = .boldSystemFont(ofSize: 16)
    $0.textColor = .grey03
    $0.text = "건너뛰기"
  }
  
  lazy var pageControlImageView = UIImageView().then {
    $0.image = UIImage(named: "dots_1")
  }
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
    self.configureImageScrollView()
    self.configureMainContentView()
    self.configureBottomPageControlView()
    self.configureImageShadow()
    self.setButtonActions()
  }
  
}
// MARK: - Extension Part
private extension OnboardingVC {
  func setButtonActions() {
    nextActionButton.press {
      if self.pageIndex != 2{
        self.pageIndex += 1
        self.contentScrollView.setContentOffset(CGPoint(x: CGFloat(self.pageIndex) * screenWidth, y: 0),
                                                animated: true)
      }else {
        print("온보딩 끝")
      }
    }
    
    skipActionButton.press {
      print("온보딩 끝")
    }
  }
  
  func setPageControlImage(){
    switch(pageIndex) {
      case 0: pageControlImageView.image = UIImage(named: "dots_1")
      case 1: pageControlImageView.image = UIImage(named: "dots_2")
      default: pageControlImageView.image = UIImage(named: "dots_3")
    }
  }
}


extension OnboardingVC: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pointX = scrollView.contentOffset.x
    
    switch(pointX){
      case 0 ... screenWidth/2 :
        headerFirstLabel.alpha = (screenWidth/2 - pointX) / (screenWidth/2)
      case screenWidth/2 ... screenWidth * 2/2 :
      case screenWidth * 2/2 ... screenWidth * 3/2 :
      case screenWidth * 3/2 ... screenWidth * 4/2 :
      case screenWidth * 4/2 ... screenWidth * 5/2 :
      case screenWidth * 5/2 ... screenWidth * 6/2 :
    }

  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    pageIndex = Int(targetContentOffset.pointee.x/screenWidth)
  }
}
