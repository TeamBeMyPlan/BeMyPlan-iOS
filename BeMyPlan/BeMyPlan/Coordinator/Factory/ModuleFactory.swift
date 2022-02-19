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
  
  // MARK: - Auth
  func instantiateLoginVC() -> LoginVC
  func instantiateSignupVC() -> SignUpVC
  
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
  
  // MARK: - Plan
  func instantiatePlanPreviewVC(postID: Int) -> PlanPreviewVC
  func instantiatePlanDetailVC(isPreviewPage: Bool) -> PlanDetailVC
  
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
  
  // MARK: - Auth
  func instantiateLoginVC() -> LoginVC {
    return LoginVC.controllerFromStoryboard(.login)
  }
  
  func instantiateSignupVC() -> SignUpVC {
    return SignUpVC.controllerFromStoryboard(.signup)
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
    return PaymentSelectVC.controllerFromStoryboard(.payment)
  }
  
  func instantiatePaymentCompleteVC() -> PaymentCompleteVC {
    return PaymentCompleteVC.controllerFromStoryboard(.payment)
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
  
  func instantiatePlanDetailVC(isPreviewPage: Bool = false) -> PlanDetailVC {
    let vc = PlanDetailVC.controllerFromStoryboard(.planDetail)
    vc.isPreviewPage = isPreviewPage
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
