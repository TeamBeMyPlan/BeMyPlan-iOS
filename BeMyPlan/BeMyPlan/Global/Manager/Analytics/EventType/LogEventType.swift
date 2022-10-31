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
  case view_onboarding // 온보딩 최초 실행
  case touch_onboarding_skip // 온보딩 스킵
  
  // 3. 로그인
  case view_signin
  case touch_signin_skip
  case touch_kakao_signin
  case touch_apple_signin
  case complete_signin(method: LoginSource)
  
  // 4. 회원가입
  case view_signup
  case complete_signup(method: LoginSource)
  
  // 5. 여행 일정 컨텐츠 뷰 미리보기
  case view_plan_detail(title: String, creator: String)
  case touch_purchase(title: String, creator: String, price: Int)
  
  // 6. 여행 일정 구매 뷰
  case view_plan_detail_purchased(title: String, creator: String)
  case touch_place_marker_box
  case touch_place_address
  
  // 7. 설정 뷰
  case view_setup
  case complete_logout
  case complete_withdraw
  
  // 8. 결제 뷰
  case view_purchase // 결제 선택창 뷰

  case view_purchase_complete
  case complete_puchase(planID: Int, title: String, creator: String, price: Int)
  
  // 9. 홈 뷰
  case view_home
  case view_plan_latest // 최신 등록 여행 일정 뷰 렌더링
  case view_plan_recommand // 최신 등록 여행 일정 뷰 렌더링
  
  // 10. 여행지 뷰
  case view_destination
  case view_plan_list
  
  // 11. 스크랩 뷰
  case view_scrap
  case complete_scrap(id: Int, title: String, creator: String)
  
  // 12. 마이플랜 뷰
  case view_myplan
  case view_plan_list_purchased

  
}

extension LogEventType: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
      case .appFirstOpen:                 return "firebase_first_open"
      case .view_onboarding:              return "view_onboarding"
      case .touch_onboarding_skip:        return "touch_onboarding_skip"
      case .view_signin:                  return "view_signin"
      case .touch_signin_skip:            return "touch_signin_skip"
      case .touch_kakao_signin:           return "touch_kakao_signin"
      case .touch_apple_signin:           return "touch_apple_signin"
      case .complete_signin:              return "complete_signin"
      case .view_signup:                  return "view_signup"
      case .complete_signup:              return "complete_signup"
      case .view_plan_detail:             return "view_plan_detail"
      case .touch_purchase:               return "touch_purchase"
      case .view_plan_detail_purchased:   return "view_plan_detail_purchased"
      case .touch_place_marker_box:       return "touch_place_marker_box"
      case .touch_place_address:          return "touch_place_address"
      case .view_setup:                   return "view_setup"
      case .complete_logout:              return "complete_logout"
      case .complete_withdraw:            return "complete_withdraw"
      case .view_purchase:                return "view_purchase"
      case .view_purchase_complete:       return "view_purchase_complete"
      case .complete_puchase:             return "complete_puchase"
      case .view_home:                    return "view_home"
      case .view_plan_latest:             return "view_plan_latest"
      case .view_plan_recommand:          return "view_plan_recommand"
      case .view_destination:             return "view_destination"
      case .view_plan_list:               return "view_plan_list"
      case .view_scrap:                   return "view_scrap"
      case .complete_scrap:               return "complete_scrap"
      case .view_myplan:                  return "view_myplan"
      case .view_plan_list_purchased:     return "view_plan_list_purchased"
        
    }
  }
  
  func parameters(for provider: ProviderType) -> [String : Any]? {
    var params: [String: Any] = [
      "device": "iOS",
      "userIdx": String(UserDefaults.standard.integer(forKey: "userIdx"))
    ]
    switch self {
      case .complete_signin(let method):
        params["method"] = method.rawValue
        
      case .complete_signup(let method):
        params["method"] = method.rawValue

      case .view_plan_detail(let title,
                             let creator):
        params["plan_title"] = title
        params["plan_creator"] = creator
        
      case .touch_purchase(let title,
                           let creator,
                           let price):
        params["plan_title"] = title
        params["plan_creator"] = creator
        params["plan_price"] = price
        
      case .view_plan_detail_purchased(let title,
                                       let creator):
        params["plan_title"] = title
        params["plan_creator"] = creator

      case .complete_puchase(let planID,
                            let title,
                            let creator,
                            let price):
        params["plan_id"] = planID
        params["plan_title"] = title
        params["plan_creator"] = creator
        params["plan_price"] = price
        
      case .complete_scrap(let id,
                          let title,
                          let creator):
        params["plan_id"] = id
        params["plan_title"] = title
        params["plan_creator"] = creator
        

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
