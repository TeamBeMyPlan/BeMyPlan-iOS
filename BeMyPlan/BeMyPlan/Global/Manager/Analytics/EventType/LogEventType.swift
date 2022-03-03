//
//  LogEventType.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/03.
//

import Foundation

/**
 앱 설치 --> appFirstOpen
 앱 삭제 --> 추적 불가능
 
 로그인
 
 
 스크랩 눌러서 로그인
 구매하기 눌러서 로그인
 마이플랜에서 로그인
 
 --> login + type + userID
 
  로그아웃
 --> logout + userID
 
 
 
 
 
 메인홈 콘텐츠 보기
 여행지탭에 들어가 콘텐츠 리스트 보기
 콘텐츠 선택
 스크랩한 여행 일정 보기
 -->  clickPlanDetail + case + postID

 
 여행 일정 스크랩 하기
 여행 일정 스크랩 제거
 --> scrap + postID
 
 
 구매하기 누름
 결제수단 선택
 결제하기 누름
 마이플랜에서 구매한 여행 일정 누름

 */
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
  
  // 12. 결제 완료 뷰
  case closePaymentCompleteView
  case clickPlanDetailView(postIdx: String)
  
  // 13. 결제 전 여행일정
  case clickPlanDetailExample
  
  // 14. 결제 후 여행일정
  case clickAddressCopy(postIdx: String)
  case moveMapApplication(source: MapSource)
  case alertNoMapApplication
  
  // 15. 작성자 이름 클릭
  case clickEditorName(source: ViewSource)
  
  // 16. 회원 유입 및 이탈
  case enterForeGround
  case enterBackGround
  case logout
  case withdrawal
  

}

extension LogEventType: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
      case .appFirstOpen: return "event_firebase_first_open"
      case .onboardingFirstOpen: return "event_onboarding_first_open"
      case .onboardingEnd: return "event_onboarding_complete"
      case .signin: return "event_signin_click"
      case .signupNickname: return "event_signup_nickname"
      case .signupEmail: return "onboarding_first_open"
      case .signupComplete: return "onboarding_first_open"
      case .clickTab: return "onboarding_first_open"
      case .clickHomeRecentPlanList: return "onboarding_first_open"
      case .clickHomeRecommendPlanList: return "onboarding_first_open"
      case .clickOpenedTravelSpot(spot: let spot): return "onboarding_first_open"
        
      case .clickClosedTravelSpot(spot: let spot): return "onboarding_first_open"
        
      case .showLoginPage(source: let source):
        return "onboarding_first_open"
        
      case .clickTravelPlan(source: let source, postIdx: let postIdx):
        return "onboarding_first_open"
        
      case .scrapTravelPlan(source: let source, postIdx: let postIdx):
        return "onboarding_first_open"
        
      case .scrapCancelTravelPlan(source: let source, postIdx: let postIdx):
        return "onboarding_first_open"
        
      case .closePaymentView: return "onboarding_first_open"
        
      case .clickPaymentMethod(source: let source): return "onboarding_first_open"
        
      case .closePaymentCompleteView: return "onboarding_first_open"
        
      case .clickPlanDetailView(postIdx: let postIdx): return "onboarding_first_open"
        
      case .clickPlanDetailExample: return "onboarding_first_open"
        
      case .clickAddressCopy(postIdx: let postIdx): return "onboarding_first_open"
        
      case .moveMapApplication(source: let source): return "onboarding_first_open"
        
      case .alertNoMapApplication: return "onboarding_first_open"
        
      case .clickEditorName(source: let source): return "onboarding_first_open"
        
      case .enterForeGround: return "onboarding_first_open"
        
      case .enterBackGround: return "onboarding_first_open"
        
      case .logout: return "onboarding_first_open"
        
      case .withdrawal: return "onboarding_first_open"
        
    }
  }
  
  func parameters(for provider: ProviderType) -> [String : Any]? {
    var params: [String: Any] = [
      "device": "iOS",
      "userIdx": String(UserDefaults.standard.integer(forKey: "userIdx"))
    ]
    switch self {

      default: break
    }
    return params
  }
}


extension LogEventType {
  enum LoginSource: String {
    case kakao = "kakao"
    case apple = "apple"
    case guest = "guest"
  }
  
  enum TabSource: String {
    case home = "home"
    case travelSpot = "travelSpot"
    case scrap = "scrap"
    case myPlan = "myPlan"
  }
  
  enum ViewSource: String {
    case scrapView = "scrapView"
    case travelListView = "travelListView"
    case planPreview = "planPreview"
    case PlanDetail = "planDetail"
    case myPlanView = "myPlanView"
  }
  
  enum PaymentSource: String{
    case kakaoPay = "kakaoPay"
    case naverPay = "naverPay"
    case toss = "toss"
  }
  
  enum MapSource: String{
    case kakaoMap = "kakaoMap"
    case naverMap = "naverMap"
  }
}
