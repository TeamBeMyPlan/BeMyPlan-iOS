//
//  NoTitleCustomAlertVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/14.
//

import UIKit

class NoTitleCustomAlertVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  
  // MARK: - UI Component Part
  
  @IBOutlet var alertLayer: UIView!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setLayer()
  }
  
  // MARK: - IBAction Part
  
  
  // MARK: - Custom Method Part
  private func setLayer() {
    alertLayer.layer.cornerRadius = 5
  }
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
