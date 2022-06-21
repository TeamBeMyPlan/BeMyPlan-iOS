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
      $0.height.equalTo(90)
    }
    
    self.view.addSubview(mainContentView)
    mainContentView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(bottomPageControlView.snp.top)
      $0.top.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  func configureMainContentView() {
    [headerFirstLabel,headerSecondLabel,headerThirdLabel].forEach { label in
      mainContentView.addSubview(label)
      label.snp.makeConstraints {
        $0.bottom.equalTo(imageStackView.snp.top).inset(-40)
        $0.height.equalTo(screenWidth * 60/375)
        $0.centerX.equalToSuperview()
      }
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
      if UIDevice.current.hasNotch {
        $0.bottom.equalToSuperview().inset(60)
        $0.height.equalTo(screenWidth * 460/375)
      }else {
        $0.bottom.equalToSuperview().inset(28)
        $0.height.equalTo(screenHeight * 460/812)
      }

    }
    
    [contentFirstImageView,contentSecondImageView,contentThirdImageView].forEach { imageView in
      imageStackView.addArrangedSubview(imageView)
    }
  }
  
  func configureBottomPageControlView() {
    
    bottomPageControlView.addSubview(skipButtonLabel)
    bottomPageControlView.addSubview(nextButtonLabel)
    
    skipButtonLabel.snp.makeConstraints {
      $0.height.equalTo(20)
      $0.top.equalToSuperview().offset(13)
      $0.left.equalToSuperview().offset(37)
    }
    
    nextButtonLabel.snp.makeConstraints {
      $0.height.equalTo(20)
      $0.width.equalTo(60)
      $0.top.equalToSuperview().offset(13)
      $0.right.equalToSuperview().inset(38)
    }
    
    bottomPageControlView.addSubview(skipActionButton)
    skipActionButton.snp.makeConstraints {
      $0.height.equalTo(50)
      $0.width.equalTo(103)
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview().offset(15)
    }
    
    bottomPageControlView.addSubview(nextActionButton)
    nextActionButton.snp.makeConstraints {
      $0.height.equalTo(50)
      $0.width.equalTo(103)
      $0.top.equalToSuperview()
      $0.trailing.equalToSuperview().inset(15)
    }
    
    bottomPageControlView.addSubview(pageControlImageView)
    pageControlImageView.snp.makeConstraints {
      $0.height.equalTo(8)
      $0.width.equalTo(58)
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(19)
    }
  }
  
  func configureImageShadow(){
    [contentFirstImageView,contentSecondImageView,contentThirdImageView].forEach { imageView in
      imageView.layer.applyShadow(color: .black, alpha: 0.15, x: 5, y: 4, blur: 15, spread: 0)
    }
  }

}
