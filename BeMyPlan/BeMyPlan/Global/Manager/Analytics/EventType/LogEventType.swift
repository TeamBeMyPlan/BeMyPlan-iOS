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
 
 --> login + type
 
 
 메인홈 콘텐츠 보기
 여행지탭에 들어가 콘텐츠 리스트 보기
 콘텐츠 선택
 스크랩한 여행 일정 보기
 -->  clickPlanDetail + case

 
 여행 일정 스크랩 하기
 여행 일정 스크랩 제거
 --> scrap
 
 
 구매하기 누름
 결제수단 선택
 결제하기 누름
 마이플랜에서 구매한 여행 일정 누름

 */
enum LogEventType {
  case appFirstOpen
  case signUp
  case clickHomePlanDetail
  case clickSpotList
  case clickPlanDetailInSpotList
  
  
  
  
  case addSubjectTimetable(subjectIdx: String, subjectName: String)
  case enterCommunicationRoom(subjectIdx: String)
  case sendCommunicationMessage(subjectIdx: String, messageType: String)
  case loadCommunityArticle(postIdx: String)
  case writeCommunityArticle(boardIdx: String)
  case writeCommunityArticleComment(postIdx: String)
  case loadCommunityQnA(qnaIdx: String)
  case writeCommunityQnA(tagIdx: String)
  case writeCommunityQnaAnswer(qnaIdx: String)
  case clickBottomTabHome
  case clickBottomTabClass
  case clickBottomTabCommunity
  case clickBottomTabQna
  case clickBottomTabMypage
  case clickHomeMajorDept
  case clickCommunityMajorDept
}

extension LogEventType: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
      case .appFirstOpen: return "Appsflyer_app_open"
      case .signUp: return "Appsflyer_sign_up"
      case .addSubjectTimetable: return "timetable_add_subject"
      case .enterCommunicationRoom: return "lecture_entrance"
      case .sendCommunicationMessage: return "lecture_send_message"
      case .loadCommunityArticle: return "community_article_load"
      case .writeCommunityArticle: return "community_article_write"
      case .writeCommunityArticleComment: return "community_article_comment_write"
      case .loadCommunityQnA: return "community_qna_load"
      case .writeCommunityQnA: return "community_qna_write"
      case .writeCommunityQnaAnswer: return "community_qna_write_answer"
      case .clickBottomTabHome: return "event_click_bottom_tab_home"
      case .clickBottomTabClass: return "event_click_bottom_tab_class"
      case .clickBottomTabCommunity: return "event_click_bottom_tab_community"
      case .clickBottomTabQna: return "event_click_bottom_tab_qna"
      case .clickBottomTabMypage: return "event_click_bottom_tab_mypage"
      case .clickHomeMajorDept: return "event_click_home_major_dept"
      case .clickCommunityMajorDept: return "event_click_community_major_dept"
    }
  }
  
  func parameters(for provider: ProviderType) -> [String : Any]? {
    var params: [String: Any] = [
      "device": "iOS",
      "userIdx": String(UserDefaults.standard.integer(forKey: "userIdx"))
    ]
    switch self {
      case let .addSubjectTimetable(subjectIdx, subjectName):
        params["subjectIdx"] = subjectIdx
        params["subjectName"] = subjectName
      case let .enterCommunicationRoom(subjectIdx):
        params["subjectIdx"] = subjectIdx
      case let .sendCommunicationMessage(subjectIdx, messageType):
        params["subjectIdx"] = subjectIdx
        params["messageType"] = messageType
      case let .loadCommunityArticle(postIdx):
        params["postIdx"] = postIdx
      case let .writeCommunityArticle(boardIdx):
        params["boardIdx"] = boardIdx
      case let .writeCommunityArticleComment(postIdx):
        params["postIdx"] = postIdx
      case let .loadCommunityQnA(qnaIdx):
        params["qnaIdx"] = qnaIdx
      case let .writeCommunityQnA(tagIdx):
        params["tagIdx"] = tagIdx
      case let .writeCommunityQnaAnswer(qnaIdx):
        params["qnaIdx"] = qnaIdx
      default: break
    }
    return params
  }
}
