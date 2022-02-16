//
//  Router.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/31.
//

import Foundation

protocol RouterProtocol: Presentable {
  
  typealias TransiotionType = (CATransitionType, CATransitionSubtype)
  
  func present(_ module: Presentable?)
  func present(_ module: Presentable?, animated: Bool)
  func alert(_ module: Presentable?)
  
  func push(_ module: Presentable?)
  func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?)
  func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
  func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?)
  
  func popModule()
  func popModule(transition: UIViewControllerAnimatedTransitioning?)
  func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
  
  func dismissModule()
  func dismissModule(animated: Bool, completion: (() -> Void)?)
  
  func setRootModule(_ module: Presentable?)
  func setRootModule(_ module: Presentable?, hideBar: Bool)
  func setRootModule(_ module: Presentable?, type: TransiotionType)
  func setRootModule(_ module: Presentable?, type: TransiotionType, hideBar: Bool, animated: Bool)
  
  func popToRootModule(animated: Bool)
  func popToModule(module: Presentable?, animated: Bool)
}

final class Router: NSObject, RouterProtocol {
  
  // MARK: - Vars & Lets
  
  private weak var rootController: UINavigationController?
  private var completions: [UIViewController : () -> Void]
  private var transition: UIViewControllerAnimatedTransitioning?
  
  // MARK: - Presentable
  
  func toPresent() -> UIViewController? {
    return self.rootController
  }
  
  // MARK: - RouterProtocol
  
  func present(_ module: Presentable?) {
    present(module, animated: true)
  }
  
  func present(_ module: Presentable?, animated: Bool) {
    guard let controller = module?.toPresent() else { return }
    controller.modalPresentationStyle = .fullScreen
    self.rootController?.present(controller, animated: animated, completion: nil)
  }
  
  func alert(_ module: Presentable?) {
    guard let controller = module?.toPresent() else { return }
    controller.modalTransitionStyle = .crossDissolve
    controller.modalPresentationStyle = .overCurrentContext
    self.rootController?.present(controller, animated: true, completion: nil)
  }
  
  func push(_ module: Presentable?)  {
    self.push(module, transition: nil)
  }
  
  func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
    self.push(module, transition: transition, animated: true)
  }
  
  func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)  {
    self.push(module, transition: transition, animated: animated, completion: nil)
  }
  
  func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?) {
    self.transition = transition
    guard let controller = module?.toPresent(),
      (controller is UINavigationController == false)
      else { assertionFailure("Deprecated push UINavigationController."); return }
    
    if let completion = completion {
      self.completions[controller] = completion
    }
    self.rootController?.pushViewController(controller, animated: animated)
  }
  
  func popModule()  {
    self.popModule(transition: nil)
  }
  
  func popModule(transition: UIViewControllerAnimatedTransitioning?) {
    self.popModule(transition: transition, animated: true)
  }
  
  func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
    self.transition = transition
    if let controller = rootController?.popViewController(animated: animated) {
      self.runCompletion(for: controller)
    }
  }
  
  func popToModule(module: Presentable?, animated: Bool) {
    if let controllers = self.rootController?.viewControllers , let module = module {
      for controller in controllers {
        if controller == module as! UIViewController {
          self.rootController?.popToViewController(controller, animated: animated)
          break
        }
      }
    }
  }
  
  func dismissModule() {
    self.dismissModule(animated: true, completion: nil)
  }
  
  func dismissModule(animated: Bool, completion: (() -> Void)?) {
    self.rootController?.dismiss(animated: animated, completion: completion)
  }
  
  func setRootModule(_ module: Presentable?) {
    self.setRootModule(module, type: (.fade, .fromTop), hideBar: true, animated: true)
  }
  
  func setRootModule(_ module: Presentable?, hideBar: Bool) {
    self.setRootModule(module, type: (.fade, .fromTop), hideBar: hideBar, animated: true)
  }
  
  func setRootModule(_ module: Presentable?, type: TransiotionType) {
    self.setRootModule(module, type: type, hideBar: true, animated: true)
  }
  
  func setRootModule(_ module: Presentable?, type: TransiotionType, hideBar: Bool, animated: Bool) {
    guard let controller = module?.toPresent() else { return }
    if animated {
      let transition: CATransition = CATransition()
      transition.duration = 0.3
      var timingFunction: CAMediaTimingFunction = .init(name: .linear)
      if type.0 == .moveIn {
        timingFunction = .init(name: .easeOut)
      }
      if type.0 == .reveal {
        timingFunction = .init(name: .easeIn)
      }
      transition.timingFunction = timingFunction
      transition.type = type.0
      transition.subtype = type.1
      self.rootController?.view.layer.add(transition, forKey: nil)
    }
    self.rootController?.setViewControllers([controller], animated: false)
    self.rootController?.navigationBar.isHidden = hideBar
  }
  
  func popToRootModule(animated: Bool) {
    self.rootController?.dismiss(animated: false)
    if let controllers = self.rootController?.popToRootViewController(animated: animated) {
      controllers.forEach { controller in
        self.runCompletion(for: controller)
      }
    }
  }
  
  // MARK: - Private methods
  
  private func runCompletion(for controller: UIViewController) {
    guard let completion = self.completions[controller] else { return }
    completion()
    completions.removeValue(forKey: controller)
  }
  
  // MARK: - Init methods
  
  init(rootController: UINavigationController) {
    self.rootController = rootController
    self.completions = [:]
    super.init()
//    self.rootController?.delegate = self
  }
}

// MARK: - Extensions
// MARK: - UINavigationControllerDelegate

extension Router: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self.transition
  }
}
