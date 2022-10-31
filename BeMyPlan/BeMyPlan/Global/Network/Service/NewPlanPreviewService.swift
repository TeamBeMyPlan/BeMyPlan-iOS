//
//  NewPlanPreviewService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/10/03.
//

import Foundation
import RxSwift


protocol NewPlanPreviewServiceType{
  func fetchNewPlanPreviewCreator(idx: Int,completion: @escaping (Result<NewPlanPreviewCreatorEntity?, Error>) -> Void)
  func fetchNewPlanPreviewCourse(idx: Int,completion: @escaping (Result<NewPlanPreviewCourseEntity?, Error>) -> Void)
  func fethcNewPlanPreviewRecommend(region: String,completion: @escaping (Result<[NewPlanPreviewRecommendEntity]?, Error>) -> Void)
  func fetchNewPlanPreviewDetail(idx: Int, completion: @escaping (Result<NewPlanPreviewDetailEntity?, Error>) -> Void)
}

extension BaseService : NewPlanPreviewServiceType{
  func fetchNewPlanPreviewCreator(idx: Int,completion: @escaping (Result<NewPlanPreviewCreatorEntity?, Error>) -> Void) {
    requestObject(.getNewPlanPreviewCreator(idx: idx), completion: completion)
  }
  
  func fetchNewPlanPreviewCourse(idx: Int,completion: @escaping (Result<NewPlanPreviewCourseEntity?, Error>) -> Void) {
    requestObject(.getNewPlanPreviewCourse(idx: idx), completion: completion)
  }

  func fethcNewPlanPreviewRecommend(region: String,completion: @escaping (Result<[NewPlanPreviewRecommendEntity]?, Error>) -> Void) {
    requestObject(.getNewPlanPreviewRecommend(spot: region), completion: completion)
  }
  
  func fetchNewPlanPreviewDetail(idx: Int, completion: @escaping (Result<NewPlanPreviewDetailEntity?, Error>) -> Void) {
    requestObject(.getNewPlanPreviewDetail(idx: idx), completion: completion)
  }
}
