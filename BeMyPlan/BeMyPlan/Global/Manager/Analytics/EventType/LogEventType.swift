//
//  LogEventType.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/03.
//

import Foundation

enum LogEventType {
  // 1. 앱 최초 실행
  case appFirstOpen // 앱 최초 실행
  
  // 2. 온보딩
  case onboardingFirstOpen // 온보딩 최초 실행
  case onboardingViewSecondPage // 온보딩 두번째 페이지 보기
  case onboardingViewThirdPage // 온보딩 세번째 페이지 보기
  case onboardingSkip // 온보딩 스킵
  case onboardingComplete // 온보딩 완료
  
  // 3. 로그인
  case signin(source: LoginSource) // 애플로그인,카카오로그인,둘러보기
  
  // 4. 회원가입
  case signupNickname(source: LoginSource) // 닉네임 작성 완료
  case signupEmail(source: LoginSource) // 이메일 작성 완료
  case signupComplete(source: LoginSource) // 회원가입 완료
  
  // 5. 탭바 클릭 액션 O
  case clickTab(source: TabSource) // 각자 탭바 클릭
  
  // 6. 홈탭 내 액션 O
  case clickHomeRecentPlanList // 홈에서 최신목록 더보기 클릭
  case clickHomeRecommendPlanList // 홈에서 추천목록 더보기 클릭
  
  // 7. 여행지 뷰 O
  case clickOpenedTravelSpot(spot: String) // 열린 여행지 클릭 + 지역 이름
  case clickClosedTravelSpot(spot: String) // 닫힌 여행지 클릭 + 지역 이름
  
  // 8. 둘러보기 -> 로그인뷰 띄워지는 경우
  case showLoginPage(source: ViewSource) // 둘러보기 상태에서 로그인 버튼을 누르는 경로(스크랩,마이플랜,구매)

  // 9. 여행 일정 클릭
  case clickTravelPlan(source :ViewSource,
                       postIdx: String) // 여행 일정 뷰를 어디서 들어오는지 파악(홈,여행지 목록,스크랩,마이플랜)
  
  // 10. 스크랩 액션
  case scrapTravelPlan(source: ViewSource,
                       postIdx: String) // 스크랩 한 뷰 위치 + postIdx
  case scrapCancelTravelPlan(source: ViewSource,
                             postIdx: String) // 스크랩 취소한 뷰 위치 + postIdx
  
  // 11.결제 뷰 O
  case closePaymentView // 결제창 닫기
  case clickPaymentMethod(source: PaymentSource) // 결제 수단 선택(카카오페이,토스,네이버페이)
  case clickPaymentButton(postIdx: String) // 결제 버튼 누르기
  
  // 12. 결제 완료 뷰 O
  case closePaymentCompleteView // 결제 완료창 닫기
  case clickPlanDetailViewInPayment(postIdx: String) // 컨텐츠 바로보러가기 클릭 + postIdx
  
  // 13. 결제 전 여행일정 예시 O
  case clickPlanDetailExample // 구매한 여행일정 예시 버튼 클릭
  
  // 14. 결제 후 여행일정 O
  case clickAddressCopy // 주소 복사 클릭
  case moveMapApplication(source: MapSource) // 외부 맵 어플 이동하는 경우 (네이버맵,카카오맵)
  case alertNoMapApplication // 외부 맵 어플이 둘다 없는 경우
  
  // 15. 작성자 이름 클릭 O
  case clickEditorName(source: ViewSource) // 작성자 이름 클릭
  
  // 16. 회원 유입 및 이탈 O
  case enterForeGround // 홈버튼 눌러서 앱을 나가는 경우
  case enterBackGround // 백그라운드에서 다시 앱으로 돌아오는 경우
  case logout // 로그아웃
  case withdrawal // 회원탈퇴
}

extension LogEventType: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
      case .appFirstOpen:                 return "firebase_first_open"
      case .onboardingFirstOpen:          return "onboarding_first_open"
      case .onboardingViewSecondPage:     return "onboarding_view_second_page"
      case .onboardingViewThirdPage:      return "onboarding_view_third_page"
      case .onboardingSkip:               return "onboarding_skip"
      case .onboardingComplete:           return "onboarding_complete"
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
          .clickPlanDetailViewInPayment(let postIdx):
        params["postIdx"] = postIdx
        
      case .moveMapApplication(let mapSource):
        params["mapSource"] = mapSource

      case .clickEditorName(let viewSource):
        params["viewSource"] = viewSource

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
    case homeView
    case scrapView
    case scrapRecommendView
    case travelListView
    case planListView
    case planPreview
    case planDetail
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
