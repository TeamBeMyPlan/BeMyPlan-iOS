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
  private let factory: ModuleFactoryProtocol = ModuleFactory.resolve()

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
    $0.setTextWithLineHeight(text: I18N.Onboarding.GuideFirstText,
                             lineHeight: screenWidth*25/375)
    $0.font = .boldSystemFont(ofSize: screenWidth*18/375)
    $0.numberOfLines = 0
    $0.textColor = .grey01
    $0.textAlignment = .center
    $0.alpha = 1
  }
  
  lazy var headerSecondLabel = UILabel().then {
    $0.setTextWithLineHeight(text: I18N.Onboarding.GuideSecondText,
                             lineHeight: screenWidth*25/375)
    $0.font = .boldSystemFont(ofSize: screenWidth*18/375)
    $0.numberOfLines = 0
    $0.textColor = .grey01
    $0.textAlignment = .center
    $0.alpha = 0
  }
  
  lazy var headerThirdLabel = UILabel().then {
    $0.setTextWithLineHeight(text: I18N.Onboarding.GuideThirdText,
                             lineHeight: screenWidth*25/375)
    $0.font = .boldSystemFont(ofSize: screenWidth*18/375)
    $0.numberOfLines = 0
    $0.textColor = .grey01
    $0.textAlignment = .center
    $0.alpha = 0
  }
  
  lazy var contentFirstImageView = UIImageView().then {
    $0.image = ImageLiterals.Onboarding.previewImage1
    $0.contentMode = .scaleAspectFit
  }
  
  lazy var contentSecondImageView = UIImageView().then {
    $0.image = ImageLiterals.Onboarding.previewImage2
    $0.contentMode = .scaleAspectFit
  }
  
  lazy var contentThirdImageView = UIImageView().then {
    $0.image = ImageLiterals.Onboarding.previewImage3
    $0.contentMode = .scaleAspectFit
  }
  
  lazy var nextButtonLabel = UILabel().then {
    $0.font = .boldSystemFont(ofSize: 16)
    $0.textColor = .bemyBlue
    $0.text = I18N.Onboarding.nextButton
    $0.textAlignment = .center
  }
  
  lazy var skipButtonLabel = UILabel().then {
    $0.font = .boldSystemFont(ofSize: 16)
    $0.textColor = .grey03
    $0.text = I18N.Onboarding.skipButton
    $0.textAlignment = .center
  }
  
  lazy var pageControlImageView = UIImageView().then {
    $0.image = ImageLiterals.Onboarding.pageControlDot1
  }
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    AppLog.log(at: FirebaseAnalyticsProvider.self, .view_onboarding)
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
        self.moveLoginVC()
        UserDefaults.standard.setValue(true, forKey: "onboardingComplete")
      }
    }
    skipActionButton.press {
      self.moveLoginVC()
      UserDefaults.standard.setValue(true, forKey: "onboardingComplete")
      AppLog.log(at: FirebaseAnalyticsProvider.self, .touch_onboarding_skip)
    }
  }
  
  func setPageControlImage(){
    switch(pageIndex) {
      case 0:
        nextButtonLabel.text = I18N.Onboarding.nextButton
        pageControlImageView.image = ImageLiterals.Onboarding.pageControlDot1
        
      case 1:
        nextButtonLabel.text = I18N.Onboarding.nextButton
        pageControlImageView.image = ImageLiterals.Onboarding.pageControlDot2
        
      default:
        nextButtonLabel.text = I18N.Onboarding.completeButton
        pageControlImageView.image = ImageLiterals.Onboarding.pageControlDot3
    }
  }
  
  func moveLoginVC(){
    let loginVC = factory.instantiateLoginVC()
    loginVC.modalPresentationStyle = .fullScreen
    self.present(loginVC, animated: false, completion: nil)
  }
}

extension OnboardingVC: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pointX = scrollView.contentOffset.x
    switch(pointX){
      case 0 ... screenWidth/2 :
        headerFirstLabel.alpha = (screenWidth/2 - pointX) / (screenWidth/2)
        headerSecondLabel.alpha = 0
        headerThirdLabel.alpha = 0
        
      case screenWidth/2 ... screenWidth * 2/2 :
        headerFirstLabel.alpha = 0
        headerSecondLabel.alpha = (pointX - screenWidth/2) / (screenWidth/2)
        headerThirdLabel.alpha = 0

      case screenWidth * 2/2 ... screenWidth * 3/2 :
        headerFirstLabel.alpha = 0
        headerSecondLabel.alpha = (screenWidth * 3/2 - pointX) / (screenWidth/2)
        headerThirdLabel.alpha = 0

      case screenWidth * 3/2 ... screenWidth * 4/2 :
        headerFirstLabel.alpha = 0
        headerSecondLabel.alpha = 0
        headerThirdLabel.alpha = (pointX - screenWidth * 3/2) / (screenWidth / 2)
        
      default :
        headerFirstLabel.alpha = 0
        headerSecondLabel.alpha = 0
        headerThirdLabel.alpha = 0
    }

  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    pageIndex = Int(targetContentOffset.pointee.x/screenWidth)
  }
}
