//
//  MainListData.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/07.
//

import Foundation

struct MainListData {
  
  var image : String
  var title : String
  
  func makeItemImage() -> UIImage? {
    return UIImage(named: image)
  }
}
