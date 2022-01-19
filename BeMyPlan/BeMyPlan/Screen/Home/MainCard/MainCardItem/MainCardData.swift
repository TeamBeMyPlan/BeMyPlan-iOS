//
//  MainCardData.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/07.
//

import Foundation

struct MainCardData {
  
  var id: Int
  var thumbnailURL : String
//  var category : String
  var title : String
  
  func makeItemImage() -> UIImage? {
    return UIImage(named: thumbnailURL)
  }
}
