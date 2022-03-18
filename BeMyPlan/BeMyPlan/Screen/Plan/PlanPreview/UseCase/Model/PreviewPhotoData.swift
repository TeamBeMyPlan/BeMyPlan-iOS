//
//  PreviewPhotoData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import Foundation

extension PlanPreview{
  struct PhotoData: PlanPreviewContent{
    var `case`: PlanPreview.ContentList = .photo
    var photoUrl : String
    var content : String
    var height: ImageHeightProcessResult
  }
}
