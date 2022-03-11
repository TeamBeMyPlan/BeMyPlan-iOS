//
//  OnboardingVC + ConfigureLayout.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/11.
//

import SnapKit

extension OnboardingVC {
  func configureUI(){
    self.view.backgroundColor = .grey06
    
    self.view.addSubview(bottomPageControlView)
    bottomPageControlView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalTo(80)
    }
    
    self.view.addSubview(mainContentView)
    mainContentView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(bottomPageControlView.snp.top)
      $0.top.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  func configureMainContentView() {
    mainContentView.addSubview(headerFirstLabel)
    mainContentView.addSubview(headerSecondLabel)
    mainContentView.addSubview(headerThirdLabel)
  
    headerFirstLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(73)
      $0.centerX.equalToSuperview()
    }
    
    headerSecondLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(73)
      $0.centerX.equalToSuperview()
    }
    
    headerThirdLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(73)
      $0.centerX.equalToSuperview()
    }
  }
  
  func configureImageScrollView() {
    mainContentView.addSubview(contentScrollView)
    contentScrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    contentScrollView.addSubview(contentScrollInnerView)
    contentScrollInnerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.height.equalTo(contentScrollView.snp.height).multipliedBy(1)
      $0.width.equalTo(contentScrollView.snp.width).multipliedBy(3).priority(.low)
    }
    
    contentScrollInnerView.addSubview(imageStackView)
    imageStackView.snp.makeConstraints {
      $0.width.equalTo(screenWidth*3)
      $0.bottom.equalToSuperview().inset(60)
      $0.height.equalTo(screenWidth * 460/375)
    }
    
    imageStackView.addArrangedSubview(contentFirstImageView)
    imageStackView.addArrangedSubview(contentSecondImageView)
    imageStackView.addArrangedSubview(contentThirdImageView)
  }
  
  func configureBottomPageControlView() {
    bottomPageControlView.addSubview(skipActionButton)
    skipActionButton.snp.makeConstraints {
      $0.height.equalTo(50)
      $0.height.equalTo(103)
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview().offset(15)
    }
    
    bottomPageControlView.addSubview(nextActionButton)
    nextActionButton.snp.makeConstraints {
      $0.height.equalTo(50)
      $0.height.equalTo(103)
      $0.top.equalToSuperview()
      $0.trailing.equalToSuperview().offset(15)
    }
    
    bottomPageControlView.addSubview(pageControlImageView)
    pageControlImageView.snp.makeConstraints {
      $0.height.equalTo(8)
      $0.width.equalTo(58)
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(19)
    }
  }
  

}
