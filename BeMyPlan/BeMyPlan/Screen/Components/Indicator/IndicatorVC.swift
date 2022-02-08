//
//  IndicatorVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/21.
//

import UIKit

class IndicatorVC: UIViewController {
  
  // MARK: - UI Component Part
  
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addObserverActions()
    activityIndicator.startAnimating()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    removeObserver()
    activityIndicator.stopAnimating()
  }
  
  // MARK: - Custom Method Part
  
  private func addObserverActions(){
    addObserverAction(.indicatorComplete) { _ in
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  private func removeObserver(){
    removeObserverAction(.indicatorComplete)
  }
}
