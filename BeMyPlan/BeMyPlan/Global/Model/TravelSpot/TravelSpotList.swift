//
//  TravelSpotList.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/02.
//

import Foundation

enum TravelSpotList: String {
  case jeju = "JEJU"
  
  func getKoreanName() -> String {
    switch(self) {
      case .jeju: return "제주"
    }
  }
}
