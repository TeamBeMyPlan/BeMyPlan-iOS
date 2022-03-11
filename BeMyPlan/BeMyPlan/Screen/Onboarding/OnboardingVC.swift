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
  
  // MARK: - UI Component Part
  
  lazy var mainContentView = UIView()
  lazy var contentScrollView = UIScrollView().then {
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
  }
  lazy var contentScrollInnerView = UIView()
  lazy var bottomPageControlView = UIView()
  lazy var nextActionButton = UIButton()
  lazy var skipActionButton = UIButton()
  lazy var imageStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.spacing = 0
    $0.axis = .horizontal
  }
  
  
  lazy var headerFirstLabel = UILabel().then {
    $0.setTextWithLineHeight(text: "여행 취향이 비슷한 크리에이터의 \n여행 일정을 찾아보세요",
                             lineHeight: 1.16)
    $0.font = .boldSystemFont(ofSize: 18)
    $0.numberOfLines = 0
    $0.textColor = .grey01
    $0.textAlignment = .center
    $0.alpha = 1
  }
  
  lazy var headerSecondLabel = UILabel().then {
    $0.setTextWithLineHeight(text: "미리보기로 원하는\n여행인지 확인하세요",
                             lineHeight: 1.16)
    $0.font = .boldSystemFont(ofSize: 18)
    $0.numberOfLines = 0
    $0.textColor = .grey01
    $0.textAlignment = .center
    $0.alpha = 0
  }
  
  lazy var headerThirdLabel = UILabel().then {
    $0.setTextWithLineHeight(text: "여행 일정을 구매하여\n알찬 여행 정보를 만나보세요",
                             lineHeight: 1.16)
    $0.font = .boldSystemFont(ofSize: 18)
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
  
  lazy var skiptButtonLabel = UILabel().then {
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
    self.configureMainContentView()
    self.configureImageScrollView()
    self.configureBottomPageControlView()
  }
  
  // MARK: - IBAction Part
  
  
  // MARK: - Custom Method Part
  
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
