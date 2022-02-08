//
//  UITableViewCell + Animator.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import UIKit
typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

final class Animator {
    private var hasAnimatedAllCells = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }

      animation(cell, indexPath, tableView)
      if let _ = tableView.visibleCells.last {
        hasAnimatedAllCells = true
      }else{
        hasAnimatedAllCells = false
      }
    }
}
enum AnimationFactory {
  static func makeFadeAnimation(duration: TimeInterval, delayFactor: Double) -> Animation {
      return { cell, indexPath, _ in
          cell.alpha = 0

        UIView.animate(withDuration: duration,
                       delay: delayFactor * Double(indexPath.row),
                       options: .allowUserInteraction) {
          cell.alpha = 1
        }
      }
  }
}
