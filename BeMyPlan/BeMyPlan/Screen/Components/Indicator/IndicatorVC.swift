//
//  IndicatorVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/21.
//

import UIKit

class IndicatorVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  
  // MARK: - UI Component Part
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("SHJOSSOHS")
    addObserverActions()
    activityIndicator.startAnimating()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    removeObserver()
    activityIndicator.stopAnimating()
  }
  

  // MARK: - Custom Method Part
  private func addObserverActions(){
    addObserverAction(keyName: NSNotification.Name.init(rawValue: "indicatorComplete")) { _ in
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  private func removeObserver(){
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(rawValue: "indicatorComplete"), object: nil)
  }
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
