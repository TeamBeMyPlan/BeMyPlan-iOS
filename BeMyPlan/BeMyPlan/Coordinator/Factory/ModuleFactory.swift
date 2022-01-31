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
  
  
  
  
}
