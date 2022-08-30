//
//  IconHelperPresentVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/08/31.
//

import PanModal

class IconHelperPresentVC: UIViewController {
  
  var screenDismissed: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  override func viewWillDisappear(_ animated: Bool) {
    screenDismissed?()
  }

}
// MARK: - Extension Part
extension IconHelperPresentVC: PanModalPresentable {
  
  var panScrollable: UIScrollView? {
    return nil
  }

  // 처음 시작 위치
  var shortFormHeight: PanModalHeight {
    let height = screenWidth * (330/375)
    return .contentHeightIgnoringSafeArea(height)
  }

  var longFormHeight: PanModalHeight {
    let height = screenWidth * (330/375)

    return .contentHeightIgnoringSafeArea(height)
  }

  var dragIndicatorBackgroundColor: UIColor {
    return .grey05
  }

}
