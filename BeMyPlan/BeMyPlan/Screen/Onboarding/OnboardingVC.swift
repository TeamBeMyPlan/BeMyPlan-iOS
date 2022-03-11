//
//  OnboardingVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/11.
//

import UIKit
import Then

class OnboardingVC: UIViewController {

  // MARK: - Vars & Lets Part


  // MARK: - UI Component Part
  
  private lazy var mainContentView = UIView()
  private lazy var bottomPageControlView = UIView()
  private lazy var nextActionButton = UIButton()
  private lazy var skipActionButton = UIButton()

  
  
  private lazy var headerFirstLabel = UILabel().then {
    $0.setTextWithLineHeight(text: "여행 취향이 비슷한 크리에이터의 \n여행 일정을 찾아보세요",
                             lineHeight: 1.16)
    $0.font = .boldSystemFont(ofSize: 18)
    $0.numberOfLines = 0
    $0.alpha = 0
  }
  
  private lazy var headerSecondLabel = UILabel().then {
    $0.setTextWithLineHeight(text: "미리보기로 원하는\n여행인지 확인하세요",
                             lineHeight: 1.16)
    $0.font = .boldSystemFont(ofSize: 18)
    $0.numberOfLines = 0
    $0.alpha = 0
  }
  
  private lazy var headerThirdLabel = UILabel().then {
    $0.setTextWithLineHeight(text: "여행 일정을 구매하여\n알찬 여행 정보를 만나보세요",
                             lineHeight: 1.16)
    $0.font = .boldSystemFont(ofSize: 18)
    $0.numberOfLines = 0
    $0.alpha = 0
  }
  

  // MARK: - Life Cycle Part
  
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
  // MARK: - IBAction Part

  
  // MARK: - Custom Method Part

  
  // MARK: - @objc Function Part

}
// MARK: - Extension Part
