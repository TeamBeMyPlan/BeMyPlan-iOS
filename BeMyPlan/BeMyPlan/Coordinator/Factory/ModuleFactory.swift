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
  
  //삭제해야함
  func instantiateSignupVC() -> SignUpVC
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
  func instantiatePaymentSelectVC(writer: String?,
                                  planTitle: String?,
                                  imgURL: String?,
                                  price : String?,
                                  postID: Int) -> PaymentSelectVC
  func instantiatePaymentCompleteVC() -> PaymentCompleteVC
  func instantiatePaymentEventPopupVC() -> PaymentEventPopupVC
  
  // MARK: - Plan
  func instantiatePlanPreviewVC(postID: Int) -> PlanPreviewVC
  func instantiatePlanDetailVC(postID: Int,isPreviewPage: Bool) -> PlanDetailVC
  
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
  
  //삭제해야함
  func instantiateSignupVC() -> SignUpVC {
    return SignUpVC.controllerFromStoryboard(.signup)
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
  
  // MARK: - Payment

  func instantiatePaymentSelectVC(writer: String?,
                                  planTitle: String?,
                                  imgURL: String?,
                                  price : String?,
                                  postID: Int) -> PaymentSelectVC {
    let vc = PaymentSelectVC.controllerFromStoryboard(.payment)
    vc.writer = writer
    vc.planTitle = planTitle
    vc.imgURL = imgURL
    vc.price = price
    vc.postIdx = postID
    return vc
  }
  
  func instantiatePaymentCompleteVC() -> PaymentCompleteVC {
    return PaymentCompleteVC.controllerFromStoryboard(.payment)
  }
  
  func instantiatePaymentEventPopupVC() -> PaymentEventPopupVC {
    return PaymentEventPopupVC.controllerFromStoryboard(.payment)
  }
  
  // MARK: - Plan

  func instantiatePlanPreviewVC(postID: Int) -> PlanPreviewVC {
    let repository = PlanPreviewRepository(service: BaseService.default)
    let viewModel = PlanPreviewViewModel(postId: postID,
                                         repository: repository)
    // 추후 postID 넣어야 됨
    let vc = PlanPreviewVC.controllerFromStoryboard(.planPreview)
    vc.viewModel = viewModel
  
    return vc
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
  
  func instantiatePlanListVC() -> TravelSpotDetailVC {
    return TravelSpotDetailVC.controllerFromStoryboard(.travelSpot)
  }
  
  // MARK: - Indicator
  func instantiateIndicatorVC() -> IndicatorVC{
    let indicatorVC = IndicatorVC.controllerFromStoryboard(.indicator)
    indicatorVC.modalTransitionStyle = .crossDissolve
    indicatorVC.modalPresentationStyle = .overCurrentContext
    return indicatorVC
  }
  
}
