//
//  controllerFromStoryboard + UIViewController.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit

/**

  - Description:
 
          Module Factory 형태에서 VC들을 간편하게 선언하기 위해 만든 extension 입니다.
          1) 스토리보드를 enum 형으로 안전하게 선언해서,
          2) 자체 className을 활용해 identifier을 선언하고,
          3) instantitateVieController 기본 메서드를 활용해 VC 인스턴스를 생성합니다.
 
          다음 메서드는 ModuleFactory에서 사용됩니다.
          
*/

extension UIViewController {
  
  private class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
    return storyboard.instantiateViewController(withIdentifier: identifier) as! T
  }
  
  class func controllerInStoryboard(_ storyboard: UIStoryboard, identifier: String) -> Self {
    return instantiateControllerInStoryboard(storyboard, identifier: identifier)
  }
  
  class func controllerInStoryboard(_ storyboard: UIStoryboard) -> Self {
    return controllerInStoryboard(storyboard, identifier: className)
  }
  
  class func controllerFromStoryboard(_ storyboard: Storyboards) -> Self {
    return controllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle: nil), identifier: className)
  }
}
