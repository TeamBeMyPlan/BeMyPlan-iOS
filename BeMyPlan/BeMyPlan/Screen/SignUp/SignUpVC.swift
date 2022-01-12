//
//  SignUpNicknameVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/12.
//

import UIKit

class SignUpVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  
  // MARK: - UI Component Part
  
  
  @IBOutlet var nicknameInputTextField: UITextField! {
    didSet {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: nicknameInputTextField.frame.height))
      nicknameInputTextField.leftView = paddingView
      nicknameInputTextField.leftViewMode = UITextField.ViewMode.always
    }
  }
  @IBOutlet var boxView: UIView!
  @IBOutlet var startBtn: UIButton!
  @IBOutlet var totalAgreeImageView: UIImageView!
  @IBOutlet var useAgreeImageView: UIImageView!
  @IBOutlet var infoAgreeImageView: UIImageView!
  
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setBoxViewUI()
  }
  
  // MARK: - IBAction Part
  @IBAction func pressCancel(_ sender: Any) {
  }
  
  @IBAction func pressTotalAgree(_ sender: Any) {
  }
  @IBAction func pressUseAgree(_ sender: Any) {
  }
  @IBAction func pressInfoAgree(_ sender: Any) {
  }
  
  @IBAction func pressUseDetail(_ sender: Any) {
  }
  @IBAction func pressInfoDetail(_ sender: Any) {
  }
  
  @IBAction func pressStart(_ sender: Any) {
  }
  
  
  
  // MARK: - Custom Method Part
  func setBoxViewUI() {
    boxView.layer.borderWidth = 1
    boxView.layer.cornerRadius = 5
    boxView.layer.borderColor = UIColor.grey04.cgColor
  }
  
  func setStartBtnUI() {
    //닉네임 입력 했을 때 --> 시작하기 활성화
  }
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
