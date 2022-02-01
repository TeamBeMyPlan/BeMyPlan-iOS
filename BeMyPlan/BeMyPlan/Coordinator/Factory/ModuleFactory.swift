//
//  ModuleFactory.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/30.
//

import Foundation

protocol ModuleFactroyProtocol {
  
  // MARK: - Splash
  func instantiateSplashVC() -> SplashVC
  
  // MARK: - Auth
  func instantiateLoginVC() -> LoginVC
  func instantiateSignupVC() -> SignUpVC
  
  // MARK: - BaseTab
  func instantiateBaseVC() -> BaseVC
  
  // MARK: - Home
  func instantiateHomeVC() -> HomeVC

  // MARK: - TravelSpot
  func instantitateTravelSpotVC() -> TravelSpotVC
  
  // MARK: - Scrap
  func instantiateScrapVC() -> ScrapVC
  
  // MARK: - MyPlan
  func instantiateMyPlanVC() -> MyPlanVC
  
  // MARK: - Payment
  func instantiatePaymentSelectVC() -> PaymentSelectVC
  func instantiatePaymentCompleteVC() -> PaymentCompleteVC
  
  // MARK: - Plan
  func instantiatePlanPreviewVC() -> PlanPreviewVC
  func instantiatePlanDetailVC() -> PlanDetailVC
  
  // MARK: - PlanList
  func instantiatePlanListVC() -> TravelSpotDetailVC
}

class ModuleFactory: ModuleFactroyProtocol{

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
  
  // MARK: - Payment

  func instantiatePaymentSelectVC() -> PaymentSelectVC {
    return PaymentSelectVC.controllerFromStoryboard(.payment)
  }
  
  func instantiatePaymentCompleteVC() -> PaymentCompleteVC {
    return PaymentCompleteVC.controllerFromStoryboard(.payment)
  }
  
  // MARK: - Plan

  func instantiatePlanPreviewVC() -> PlanPreviewVC {
    return PlanPreviewVC.controllerFromStoryboard(.planPreview)
  }
  
  func instantiatePlanDetailVC() -> PlanDetailVC {
    return PlanDetailVC.controllerFromStoryboard(.planDetail)
  }
  
  func instantiatePlanListVC() -> TravelSpotDetailVC {
    return TravelSpotDetailVC.controllerFromStoryboard(.travelSpot)
  }
  
}
