//
//  StringLiterals.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//
import Foundation

struct I18N {
  
  struct TabBar{
    static let home = "홈"
    static let travelSpot = "여행지"
    static let scrap = "스크랩"
    static let myPlan = "마이 플랜"
  }
  
  struct Alert {
    static let alarm = "알림"
    static let error = "오류"
    static let notInstallKakaomap = "네이버맵이 설치되지 않았습니다."
    static let networkError = "네트워크 상태를 확인해주세요"
    static let copyComplete = "📑 주소가 복사되었습니다"
    static let notOpenTravelSpot = "추후 오픈될 예정입니다"
  }
  
  struct Components {
    static let next = "다음"
    static let ok = "확인"
    static let total = "전체"
  }
  
  struct Onboarding {
    static let GuideFirstText = "여행 취향이 비슷한 크리에이터의 \n여행 일정을 찾아보세요"
    static let GuideSecondText = "미리보기로 원하는\n여행인지 확인하세요"
    static let GuideThirdText = "여행 일정을 구매하여\n알찬 여행 정보를 만나보세요"
    static let skipButton = "건너뛰기"
    static let nextButton = "다음"
    static let completeButton = "시작하기"
  }
  
  struct Account {
    static let enterNamePlaceHolder = "이름을 입력해주세요"
    static let enterEmailPlaceHolder = "이메일 또는 휴대전화"
    static let enterPasswordPlaceHolder = "비밀번호 입력"
  }
  
  struct MainTab {
    static let home = "홈"
    static let shorts = "Shorts"
    static let add = "추가"
    static let subscribe = "구독"
    static let library = "보관함"
  }
  
  struct Subscribe {
    struct Filter {
      static let total = "전체"
      static let today = "오늘"
      static let continueToWatch = "이어서 시청하기"
      static let noWatch = "시청하지 않음"
      static let live = "실시간"
      static let article = "게시물"
    }
  }
  
  struct PlanList {
    static let bemyPlanRecommendHeader = "비마플 추천 일정"
    static let recentlyHeader = "최신 여행 일정"
  }
  
  struct PlanPreview{
    struct Recommend{
      static let title = "콘텐츠를 구매하시면 이런 내용을 볼 수 있어요!"
      static let content =
"""
✔️  장소를 핀한 지도
✔️  정류장 형식 일정
✔️  솔직 후기
✔️  가본 사람만 알 수 있는 꿀팁
✔️  다음 장소로 이동할 때의 교통편
"""
    }
    
    struct Theme {
      static let activity = "액티비티"
      static let camping = "캠핑"
      static let eating = "먹방"
      static let healing = "힐링"
      static let hotplacing = "핫플"
      static let lifeshot = "인생샷"
      static let local = "로컬"
    }
    
    struct Partner {
      static let couple = "커플"
      static let family = "가족"
      static let friend = "친구"
      static let solo = "혼자"
    }
    
    struct Mobility {
      static let bicycle = "자전거"
      static let car = "차량"
      static let `public` = "대중교통"
      static let walk = "도보"
    }
  }
  
  struct MyPlan{
    struct Withdraw{
      static let placeHolder = "직접 입력해주세요."
    }
  }
  
  struct SignUp{
    struct NickName{
      static let errorAlert = "중복된 닉네임 입니다."
      static let placeHolder = "특수문자는 사용할 수 없습니다."
    }
    struct SpecialChar{
      static let errorAlert = "특수문자를 사용할 수 없습니다."
    }
    struct StrangeChar {
      static let errorAlert = "닉네임 형식이 올바르지 않습니다."
    }
    struct Email{
      static let errorAlert = "이메일 형식이 올바르지 않습니다."
      static let placeHolder = "이메일 입력"
    }
  }
  
}
