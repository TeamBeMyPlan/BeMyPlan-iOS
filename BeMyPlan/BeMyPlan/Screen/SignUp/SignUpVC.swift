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
      nicknameInputTextField.delegate = self
      
      setTextField()
    }
  }
  @IBOutlet var boxView: UIView!
  @IBOutlet var totalAgreeImageView: UIImageView!
  @IBOutlet var useAgreeImageView: UIImageView!
  @IBOutlet var infoAgreeImageView: UIImageView!
  @IBOutlet var startBtn: UIButton!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setBoxViewUI()
    addTapGesture()
    addToolbar(textfields: [nicknameInputTextField])
    setBtn()
    
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
  
  private func setBtn() {
    startBtn.isEnabled = false
    startBtn.backgroundColor = .grey04
  }
  
  private func setTextField() {
    nicknameInputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }
  
  
  // MARK: - @objc Function Part
  @objc func textFieldDidChange(_ sender:Any?) -> Void {
    startBtn.isEnabled = nicknameInputTextField.hasText
    if startBtn.isEnabled == true {
      startBtn.backgroundColor = .bemyBlue
    } else{
      startBtn.backgroundColor = .grey04
    }
  }
  
}
// MARK: - Extension Part
extension SignUpVC : UITextFieldDelegate{
  func textViewDidBeginEditing(_ textField: UITextField) {
    //텍스트가 있을 경우
    if textField.text == I18N.SignUp.NickName.placeHolder{
      nicknameInputTextField.text = ""
      nicknameInputTextField.textColor = .black
    }
    nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
  }
  
  func textViewDidEndEditing(_ textField: UITextField) {
    //비어있을 경우 --> 아무것도 뭐 없는디 ..
    if textField.text == nil {
      textField.text = I18N.MyPlan.Withdraw.placeHolder
      textField.textColor = .black
    }
    nicknameInputTextField.layer.borderColor = UIColor.grey04.cgColor
  }
  
  func textViewDidChange(_ textField: UITextField) {
    //      startBtn.setButtonState(isSelected: !nicknameInputTextField.text.isEmpty, title: I18N.Components.next)
    if let textField = textField as? UITextField {
      if let text = nicknameInputTextField.text {
        if text.count > 20 {
          // 🪓 주어진 인덱스에서 특정 거리만큼 떨어진 인덱스 반환
          let maxIndex = text.index(text.startIndex, offsetBy: 20)
          // 🪓 문자열 자르기
          let newString = String(text[text.startIndex..<maxIndex])
          nicknameInputTextField.text = newString
          
          //경고문구..!까지 띄우기
          
        }
      }
    }
  }
  
  
}



