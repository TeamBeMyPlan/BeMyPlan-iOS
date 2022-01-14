//
//  NoTitleCustomAlertVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/14.
//

import UIKit

enum CustomAlertCase {
  case requestAlert
  case simpleAlert
}

class CustomAlertVC: UIViewController {
  
  // MARK: - Vars & Lets Part a
  var alertCase : CustomAlertCase = .simpleAlert
  var alertTitle: String?
  var alertContent: String?
  var okAction: (() -> Void)?
  
  // MARK: - UI Component Part
  @IBOutlet var alertLayer: UIView!
  @IBOutlet var alertTitleLabel: UILabel!
  @IBOutlet var alertContentLabel: UILabel!
  @IBOutlet var cancellLabel: UILabel!
  @IBOutlet var cancelBtnArea: UIButton!
  @IBOutlet var confirmLabel: UILabel!
  @IBOutlet var confirmBtnArea: UIButton!
  
  @IBOutlet var simpleConfirmBtnArea: UIButton!
  
  @IBOutlet var simpleOkView: UIView!
  
  
  @IBOutlet var contentLabelCenterLayout: NSLayoutConstraint!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setLayer()
    setUIs()
    setButtonActions()
  }
  
  // MARK: - IBAction Part
  
  
  // MARK: - Custom Method Part
  private func setLayer() {
    alertLayer.layer.cornerRadius = 5
  }
  
  private func setUIs(){
    simpleOkView.isHidden = alertCase == .simpleAlert ? false : true
    contentLabelCenterLayout.constant = (alertTitle != nil) ? -6 : -20
    if let alertTitle = alertTitle {
      alertTitleLabel.isHidden = false
      alertTitleLabel.text = alertTitle
    }else{
      alertTitleLabel.isHidden = true
    }
    if let alertContent = alertContent {
      alertContentLabel.text = alertContent
      alertContentLabel.sizeToFit()
    }
    
  }
  
  func setButtonActions(){
    confirmBtnArea.press {
      (self.okAction ?? self.emptyActions)()
      self.dismiss(animated: true, completion: nil)
    }
    simpleConfirmBtnArea.press {
      (self.okAction ?? self.emptyActions)()
      self.dismiss(animated: true, completion: nil)
    }
    cancelBtnArea.press {
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  private func emptyActions(){
    
  }
  
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
//-20 (타이틀 옶을때) -> 타이틀은 히든 처리, -6 (타이틀 있을때)
