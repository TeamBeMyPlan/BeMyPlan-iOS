//
//  LogEventType.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/03.
//

import Foundation

enum LogEventType {
  // 1. 앱 최초 실행
  case appFirstOpen
  
  // 2. 온보딩
  case onboardingFirstOpen
  case onboardingEnd
  
  // 3. 로그인
  case signin(source: LoginSource)
  
  // 4. 회원가입
  case signupNickname(source: LoginSource)
  case signupEmail(source: LoginSource)
  case signupComplete(source: LoginSource)
  
  // 5. 탭바 클릭 액션
  case clickTab(source: TabSource)
  
  // 6. 홈탭 내 액션
  case clickHomeRecentPlanList
  case clickHomeRecommendPlanList
  
  // 7. 여행지 뷰
  case clickOpenedTravelSpot(spot: String)
  case clickClosedTravelSpot(spot: String)
  
  // 8. 둘러보기 -> 로그인뷰 띄워지는 경우
  case showLoginPage(source: ViewSource)

  // 9. 여행 일정 클릭
  case clickTravelPlan(source :ViewSource,
                       postIdx: String)
  
  // 10. 스크랩 액션
  case scrapTravelPlan(source: ViewSource,
                       postIdx: String)
  case scrapCancelTravelPlan(source: ViewSource,
                             postIdx: String)
  
  // 11.결제 뷰
  case closePaymentView
  case clickPaymentMethod(source: PaymentSource)
  case clickPaymentButton(postIdx: String)
  
  // 12. 결제 완료 뷰
  case closePaymentCompleteView
  case clickPlanDetailViewInPayment(postIdx: String)
  
  // 13. 결제 전 여행일정
  case clickPlanDetailExample
  
  // 14. 결제 후 여행일정
  case clickAddressCopy(postIdx: String)
  case moveMapApplication(source: MapSource,postIdx: String)
  case alertNoMapApplication
  
  // 15. 작성자 이름 클릭
  case clickEditorName(source: ViewSource,postIdx: String)
  
  // 16. 회원 유입 및 이탈
  case enterForeGround
  case enterBackGround
  case logout
  case withdrawal
}

extension LogEventType: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
      case .appFirstOpen:                 return "firebase_first_open"
      case .onboardingFirstOpen:          return "onboarding_first_open"
      case .onboardingEnd:                return "onboarding_complete"
      case .signin:                       return "signin_click"
      case .signupNickname:               return "signup_nickname"
      case .signupEmail:                  return "signup_email"
      case .signupComplete:               return "signup_complete"
      case .clickTab:                     return "click_tab"
      case .clickHomeRecentPlanList:      return "click_home_recent_list"
      case .clickHomeRecommendPlanList:   return "click_home_recommend_list"
      case .clickOpenedTravelSpot:        return "click_opened_travel_spot"
      case .clickClosedTravelSpot:        return "click_closed_travel_spot"
      case .showLoginPage:                return "move_login_page"
      case .clickTravelPlan:              return "click_travel_plan"
      case .scrapTravelPlan:              return "scrap_travel_plan"
      case .scrapCancelTravelPlan:        return "scrap_cancel_travel_plan"
      case .closePaymentView:             return "close_payment_view"
      case .clickPaymentMethod:           return "click_payment_method"
      case .clickPaymentButton:           return "click_payment_button"
      case .closePaymentCompleteView:     return "close_payment_complete"
      case .clickPlanDetailViewInPayment: return "move_plan_detail_view_in_payment"
      case .clickPlanDetailExample:       return "click_plan_detail_example"
      case .clickAddressCopy:             return "click_address_copy"
      case .moveMapApplication:           return "move_map_application"
      case .alertNoMapApplication:        return "alert_no_map_application"
      case .clickEditorName:              return "click_editor_name"
      case .enterForeGround:              return "enter_foreground"
      case .enterBackGround:              return "enter_background"
      case .logout:                       return "user_logout"
      case .withdrawal:                   return "user_withdrawal"
    }
  }
  
  func parameters(for provider: ProviderType) -> [String : Any]? {
    var params: [String: Any] = [
      "device": "iOS",
      "userIdx": String(UserDefaults.standard.integer(forKey: "userIdx"))
    ]
    switch self {
      case .signin(let loginSource),
          .signupNickname(let loginSource),
          .signupEmail(let loginSource),
          .signupComplete(let loginSource):
        params["loginSource"] = loginSource.rawValue
        
      case .clickTab(let tabSource):
        params["tabSource"] = tabSource.rawValue
      
      case .clickOpenedTravelSpot(let spot),
          .clickClosedTravelSpot(let spot):
        params["spot"] = spot
    
      case .showLoginPage(let viewSource):
        params["viewSource"] = viewSource.rawValue
        
      case .clickTravelPlan(let viewSource, let postIdx):
        params["viewSource"] = viewSource.rawValue
        params["postIdx"] = postIdx
        
      case .scrapTravelPlan(let viewSource, let postIdx),
          .scrapCancelTravelPlan(let viewSource, let postIdx):
        params["viewSource"] = viewSource.rawValue
        params["postIdx"] = postIdx
        
      case .clickPaymentMethod(let paymentSource):
        params["paymentSource"] = paymentSource.rawValue
      
      case .clickPaymentButton(let postIdx),
          .clickPlanDetailViewInPayment(let postIdx),
          .clickAddressCopy(let postIdx):
        params["postIdx"] = postIdx
        
      case .moveMapApplication(let mapSource, let postIdx):
        params["mapSource"] = mapSource
        params["postIdx"] = postIdx

      case .clickEditorName(let viewSource, let postIdx):
        params["viewSource"] = viewSource
        params["postIdx"] = postIdx

      default: break
    }
    return params
  }
}


extension LogEventType {
  enum LoginSource: String {
    case kakao
    case apple
    case guest  }
  
  enum TabSource: String {
    case home
    case travelSpot
    case scrap
    case myPlan
  }
  
  enum ViewSource: String {
    case scrapView
    case travelListView
    case planPreview
    case PlanDetail
    case myPlanView
  }
  
  enum PaymentSource: String{
    case kakaoPay
    case naverPay
    case toss
  }
  
  enum MapSource: String{
    case kakaoMap
    case naverMap
  }
}
