//
//  pressAction.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import Foundation
import UIKit
extension UIButton {
  
  /**
    - Description:
        button에 대해 addTarget해서 일일이 처리안하고, closure 형태로 동작을 처리하기 위해 다음과 같은 extension을 활용합니다
          press를 작성하고, 안에 버튼이 눌렸을 때, 동작하는 함수를 만듭니다.
            
   clicked(completion : @escaping ((Bool) -> Void)) 함수를 활용해,
   버튼이 눌렸을때, 줄어들었다가 다시 늘어나는 (Popping)효과와 햅틱을 추가해서
   사용자에게 버튼이 눌렸다는 인터렉션을 제공합니다!
              
  */
  
  // iOS14부터 UIAction이 addAction가능하기에... 이전에는 NSObject형태로 등록해서 처리하는 방식으로...
  func press(animated : Bool = false,for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
      self.addAction(UIAction { (action: UIAction) in closure()
        self.makeVibrate(degree: .medium)
        if animated {self.clickedAnimation()}
      }, for: controlEvents)
  }
  
  // 해당 함수를 통해서 Poppin 효과를 처리합니다. 줄어드는 정도를 조절하고싶다면 ,ScaleX,Y값을 조절합니다(최대값 1)
  func clickedAnimation() {
    UIView.animate(withDuration: 0.1, animations: {
      self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) }, completion: { (finish: Bool) in
        UIView.animate(withDuration: 0.1, animations: {
          self.transform = CGAffineTransform.identity
        })
      })
  }
}
