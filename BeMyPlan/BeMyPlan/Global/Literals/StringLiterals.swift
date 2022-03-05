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
  }
  
  struct Components {
    static let next = "다음"
    static let ok = "확인"
    static let total = "전체"
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
  }
  
  struct MyPlan{
    struct Withdraw{
      static let placeHolder = "직접 입력해주세요."
    }
  }
  
  struct SignUp{
    struct NickName{
      static let placeHolder = "20자 이내로 입력해주세요."
    }
  }
}
