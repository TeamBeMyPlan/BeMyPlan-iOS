//
//  NewPlanPreviewModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import Foundation

protocol NewPlanPreviewDataSource{
  var type: NewPlanPreviewDataSourceType { get set }
}

enum NewPlanPreviewDataSourceType {
  case header
  case creator
  case recommendReason
  case mainContent
  case purchaseGuide
  case suggestList
  case terms
}

struct NewPlanPreviewHeaderDataModel: NewPlanPreviewDataSource {
  var type: NewPlanPreviewDataSourceType = .header
  let photoURLs: [String]
  let title: String
  let address: String
  let hashTags: [String]
  let price: Int
  let summary: NewPlanPreviewHeaderDataModel.IconData
  
  struct IconData{
    let theme : String
    let spotCount : String
    let restaurantCount : String
    let dayCount : String
    let peopleCase : String
    let budget : String
    let transport : String
    let month : String
  }
}

struct NewPlanPreviewCreatorDataModel: NewPlanPreviewDataSource {
  var type: NewPlanPreviewDataSourceType = .creator
  let authorName: String
  let authorDescription: String
  let content: String
}

struct NewPlanPreviewRecommendReasonDataModel: NewPlanPreviewDataSource {
  var type: NewPlanPreviewDataSourceType = .recommendReason
  let contentList: [NewPlanPreviewRecommendReasonDataModel.RecommendData]
  
  struct RecommendData {
    let iconType: NewPlanPreviewRecommendReasonDataModel.IconType
    let content: String
  }
  
  enum IconType: String {
    case coffee
    case nature
  }
}

struct NewPlanPreviewMainContentDataModel: NewPlanPreviewDataSource {
  var type: NewPlanPreviewDataSourceType = .mainContent
  let contentList: [NewPlanPreviewMainContentDataModel.PhotoContent]
  
  struct PhotoContent {
    let imgURLs: [String]
    let content: String
  }
}

struct NewPlanPreviewMainPurchaseGuideDataModel: NewPlanPreviewDataSource {
  var type: NewPlanPreviewDataSourceType = .purchaseGuide
}

struct NewPlanPreviewSuggestListDataModel: NewPlanPreviewDataSource {
  var type: NewPlanPreviewDataSourceType = .suggestList
  let suggestsList: [NewPlanPreviewSuggestListDataModel.SpotData]
  
  struct SpotData {
    let idx: Int
    let imgURL: String
    let title: String
    let address: String
  }
}

struct NewPlanPreviewTemrsDataModel: NewPlanPreviewDataSource {
  var type: NewPlanPreviewDataSourceType = .terms
  let termList: [NewPlanPreviewTemrsDataModel.TermData]
  
  struct TermData {
    let title: String
    let content: String
  }
}
