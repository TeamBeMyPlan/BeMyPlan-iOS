//
//  SignUpNicknameVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/12.
//

import UIKit

class SignUpVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  var totalAgreeStatus: Bool = false {
    didSet {
      setCheckTotalImage()
    }
  }
  
  var useAgreeStatus: Bool = false {
    didSet {
      setCheckUseImage()
    }
  }
  
  var infoAgreeStatus: Bool = false {
    didSet {
      setCheckInfoImage()
    }
  }
  
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
    totalAgreeStatus = !totalAgreeStatus
  }
  @IBAction func pressUseAgree(_ sender: Any) {
    useAgreeStatus = !useAgreeStatus
  }
  @IBAction func pressInfoAgree(_ sender: Any) {
    infoAgreeStatus = !infoAgreeStatus
  }
  
  @IBAction func pressUseDetail(_ sender: Any) {
  }
  @IBAction func pressInfoDetail(_ sender: Any) {
  }
  
  @IBAction func pressStart(_ sender: Any) {
  }
  
  
  
  // MARK: - Custom Method Part
  private func setBoxViewUI() {
    boxView.layer.borderWidth = 1
    boxView.layer.cornerRadius = 5
    boxView.layer.borderColor = UIColor.grey04.cgColor
  }
  
  private func setStartBtnUI() {
    //닉네임 입력 했을 때 --> 시작하기 활성화
  }
  
  private func setCheckTotalImage() {
    totalAgreeImageView.image = totalAgreeStatus ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
    useAgreeImageView.image = totalAgreeStatus ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
    infoAgreeImageView.image = totalAgreeStatus ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
  }
  
  private func setCheckUseImage() {
    useAgreeImageView.image = useAgreeStatus ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
  }
  
  private func setCheckInfoImage() {
    infoAgreeImageView.image = infoAgreeStatus ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
  }
  
  
  
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
