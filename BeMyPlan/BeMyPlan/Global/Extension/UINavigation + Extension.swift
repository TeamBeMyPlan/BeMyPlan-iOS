//
//  UINavigation + Extension.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/15.
//

import UIKit

public extension UINavigationController {
  func fixInteractivePopGestureRecognizer(delegate: UIGestureRecognizerDelegate) {
    guard
      let popGestureRecognizer = interactivePopGestureRecognizer,
      let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray,
      let gestureRecognizers = view.gestureRecognizers,
      targets.count > 0
    else { return }
    
    ///  기존 Gesture Recognizer에서
    /// 현재 Navigation Controller가 쥐고있는
    ///  gestureRecognizer와 popGestureRecognizer를 들고옵니다.
    
    /// VC가 1개인 경우는 첫번째 VC를 의미하기 때문에, 기존에 popDirectionGesture를 쥐고있다면, nil로 해제하는 방식으로 처리

    if viewControllers.count == 1 {
      for recognizer in gestureRecognizers where recognizer is PanDirectionGestureRecognizer {
        view.removeGestureRecognizer(recognizer)
        popGestureRecognizer.isEnabled = false
        recognizer.delegate = nil
      }
    } else {
      /// gesture -> edgePanSwipeGesture 1개만 있는 경우에
      /// 기존 popGesture를 fail 시키고
      /// 새로 PanDirectionGestureRecognizer를 등록하는 식으로 처리
      /// 1번 등록하게 되면 그 이후에는 계속해서 사용하게 됨
      if gestureRecognizers.count == 1 {
        let gestureRecognizer = PanDirectionGestureRecognizer(axis: .horizontal, direction: .right)
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.setValue(targets, forKey: "targets")
        gestureRecognizer.require(toFail: popGestureRecognizer)
        gestureRecognizer.delegate = delegate
        popGestureRecognizer.isEnabled = true

        view.addGestureRecognizer(gestureRecognizer)
      }
    }
  }
  
  func removePopGesture(){
    view.gestureRecognizers?.removeAll()
  }
}
