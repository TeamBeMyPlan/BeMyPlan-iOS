//
//  ModuleFactory.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/30.
//

import Foundation

protocol ModuleFactoryProtocol {
  
  // MARK: - Splash
  func instantiateSplashVC() -> SplashVC
  
  // MARK: - Onboarding
  func instantiateOnboardingVC() -> OnboardingVC
  
  // MARK: - Auth
  func instantiateLoginVC() -> LoginVC
  func instantiateSignupNC(socialType: String,socialToken: String,email: String?) -> SignupNC
  func instantiateSignupNicknameVC() -> SignUpNicknameVC
  func instantiateSignupEmailVC() -> SignUpEmailVC
  func instantiateSignupTOSVC() -> SignUpTOSVC
  
  // MARK: - BaseTab
  func instantiateBaseNC() -> BaseNC
  func instantiateBaseVC() -> BaseVC
  
  // MARK: - Home
  func instantiateHomeVC() -> HomeVC

  // MARK: - TravelSpot
  func instantitateTravelSpotVC() -> TravelSpotVC
  
  // MARK: - Scrap
  func instantiateScrapVC() -> ScrapVC
  
  // MARK: - MyPlan
  func instantiateMyPlanVC() -> MyPlanVC
  func instantiateMyPlanSettingVC() -> MyPlanSettingVC
  func instantiateMyPlanWithdrawVC() -> MyPlanWithdrawVC
  
  // MARK: - Payment
  func instantiatePaymentSelectVC(paymentData: PaymentContentData) -> PaymentSelectVC
  func instantiatePaymentCompleteVC() -> PaymentCompleteVC
  func instantiatePaymentEventPopupVC() -> PaymentEventPopupVC
  
  // MARK: - Plan
  func instantiatePlanPreviewVC(postID: Int,scrapState: Bool) -> PlanPreviewVC
  func instantiatePlanDetailVC(postID: Int,isPreviewPage: Bool) -> PlanDetailVC
  func makeSummaryHelper() -> IconHelperPresentVC
  
  // MARK: - PlanList
  func instantiatePlanListVC() -> TravelSpotDetailVC
  
  // MARK: - Indiciator
  func instantiateIndicatorVC() -> IndicatorVC
}

class ModuleFactory: ModuleFactoryProtocol{
  static func resolve() -> ModuleFactory {
    return ModuleFactory()
  }
  
  // MARK: - Splash
  func instantiateSplashVC() -> SplashVC {
    return SplashVC.controllerFromStoryboard(.splash)
  }
  
  // MARK: - Onboarding
  func instantiateOnboardingVC() -> OnboardingVC {
    return OnboardingVC.controllerFromStoryboard(.onboarding)
  }
  
  // MARK: - Auth
  
  func instantiateLoginVC() -> LoginVC {
    return LoginVC.controllerFromStoryboard(.login)
  }
  
  func instantiateSignupNC(socialType: String,socialToken: String,email: String?) -> SignupNC {
    let signupNC = SignupNC.controllerFromStoryboard(.signup)
    signupNC.socialToken = socialToken
    signupNC.socialType = socialType
    signupNC.email = email
    return signupNC
  }
  
  func instantiateSignupNicknameVC() -> SignUpNicknameVC {
    return SignUpNicknameVC.controllerFromStoryboard(.signup)
  }
  
  func instantiateSignupEmailVC() -> SignUpEmailVC {
    return SignUpEmailVC.controllerFromStoryboard(.signup)
  }
  
  func instantiateSignupTOSVC() -> SignUpTOSVC {
    return SignUpTOSVC.controllerFromStoryboard(.signup)
  }
  
  // MARK: - Base Tap
  
  func instantiateBaseNC() -> BaseNC {
    return BaseNC.controllerFromStoryboard(.base)
  }

  func instantiateBaseVC() -> BaseVC {
    return BaseVC.controllerFromStoryboard(.base)
  }
  
  // MARK: - Home

  func instantiateHomeVC() -> HomeVC {
    return HomeVC.controllerFromStoryboard(.home)
  }
  
  // MARK: - TravelSpot
  
  func instantitateTravelSpotVC() -> TravelSpotVC {
    return TravelSpotVC.controllerFromStoryboard(.travelSpot)
  }
  
  // MARK: - Scrap

  func instantiateScrapVC() -> ScrapVC {
    return ScrapVC.controllerFromStoryboard(.scrap)
  }
  
  // MARK: - MyPlan
  func instantiateMyPlanVC() -> MyPlanVC {
    return MyPlanVC.controllerFromStoryboard(.myPlan)
  }
  
  func instantiateMyPlanSettingVC() -> MyPlanSettingVC {
    return MyPlanSettingVC.controllerFromStoryboard(.myPlan)
  }
  
  func instantiateMyPlanWithdrawVC() -> MyPlanWithdrawVC {
    return MyPlanWithdrawVC.controllerFromStoryboard(.myPlan)
  }
  func makeSummaryHelper() -> IconHelperPresentVC {
    return IconHelperPresentVC.controllerFromStoryboard(.iconHelper)
  }
  
  // MARK: - Payment

  func instantiatePaymentSelectVC(paymentData: PaymentContentData) -> PaymentSelectVC {
    let vc = PaymentSelectVC.controllerFromStoryboard(.payment)
    vc.paymentData = paymentData
    return vc
  }
  
  func instantiatePaymentCompleteVC() -> PaymentCompleteVC {
    return PaymentCompleteVC.controllerFromStoryboard(.payment)
  }
  
  func instantiatePaymentEventPopupVC() -> PaymentEventPopupVC {
    return PaymentEventPopupVC.controllerFromStoryboard(.payment)
  }
  
  // MARK: - Plan

  func instantiatePlanPreviewVC(postID: Int,scrapState: Bool) -> PlanPreviewVC {
    let repository = DefaultPlanPreviewRepository(service: BaseService.default)
    let useCase = DefaultPlanPreviewUseCase(repository: repository, postIdx: postID)
    let viewModel = PlanPreviewViewModel(useCase: useCase)
    let vc = PlanPreviewVC.controllerFromStoryboard(.planPreview)
    vc.viewModel = viewModel
    vc.idx = postID
    vc.scrapState = scrapState
    return vc
  }
  
  func instantiatePlanListVC() -> TravelSpotDetailVC {
    return TravelSpotDetailVC.controllerFromStoryboard(.travelSpot)
  }
  
  func instantiatePlanDetailVC(postID: Int,isPreviewPage: Bool = false) -> PlanDetailVC {
    
    let repository = PlanDetailRepository(service: BaseService.default)
    let viewModel = PlanDetailViewModel(postId: postID,
                                        isPreviewPage: isPreviewPage,
                                        repository: repository)
    let vc = PlanDetailVC.controllerFromStoryboard(.planDetail)
    vc.viewModel = viewModel
    return vc
  }
  
  // MARK: - Indicator
  func instantiateIndicatorVC() -> IndicatorVC{
    let indicatorVC = IndicatorVC.controllerFromStoryboard(.indicator)
    indicatorVC.modalTransitionStyle = .crossDissolve
    indicatorVC.modalPresentationStyle = .overCurrentContext
    return indicatorVC
  }
  
}
