//
//  StoryboardLiterals.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit

/**

  - Description:
          enum형태로 Storybaords 값을 안전하게 가져오기 위해 사용합니다.
          스토리보드를 추가할때마다 case 과 값을 추가하면 됩니다!
*/
enum Storyboards: String {
  case base = "Base"
  case splash = "Spalsh"
  case login = "Login"
  case home = "Home"
  case travelSpot = "TravelSpot"
  case scrap = "Scrap"
  case myPlan = "MyPlan"
}

extension UIStoryboard{
  static func list(_ name : Storyboards) -> UIStoryboard{
    return UIStoryboard(name: name.rawValue, bundle: nil)
  }
}
