//
//  SignUpNicknameVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/12.
//

import UIKit

class SignUpVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private var isNicknameValid : Bool = false {
    didSet {
      setStartBtnStatus()
    }
  }
  private var statusList : [Bool] = [false,false,false]{
    didSet{
      showCheckImageForStatus()
      setStartBtnStatus()
    }
  }
  
  
  // MARK: - UI Component Part
  
  @IBOutlet var nicknameCountLabel: UILabel!
  
  @IBOutlet var nicknameInputTextField: UITextField! {
    didSet {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: nicknameInputTextField.frame.height))
      nicknameInputTextField.leftView = paddingView
      nicknameInputTextField.leftViewMode = UITextField.ViewMode.always
      nicknameInputTextField.delegate = self
      
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
    setBtnStatus()
    setTextField()
    addBtnActions()
  }
  
  // MARK: - IBAction Part
  @IBAction func pressCancel(_ sender: Any) {
  }
  
  @IBAction func pressTotalAgree(_ sender: Any) {
    statusList[0] = !statusList[0]
    manageStatusList()
  }
  @IBAction func pressUseAgree(_ sender: Any) {
    statusList[1] = !statusList[1]
    manageTotalStatus()
  }
  @IBAction func pressInfoAgree(_ sender: Any) {
    statusList[2] = !statusList[2]
    manageTotalStatus()
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
  
  private func setStartBtnStatus(){
    if statusList[0] && isNicknameValid{
      startBtn.backgroundColor = .bemyBlue
      startBtn.isEnabled = true
    } else {
      startBtn.backgroundColor = .grey04
      startBtn.isEnabled = false
    }
  }
  
  
  private func manageStatusList(){
    statusList[1] = statusList[0]
    statusList[2] = statusList[0]
  }
  
  private func manageTotalStatus(){
    if statusList[1] && statusList[2]{
      statusList[0] = true
    }else{
      statusList[0] = false
    }
  }
  
  private func showCheckImageForStatus(){
    totalAgreeImageView.image = statusList[0] ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
    useAgreeImageView.image = statusList[1] ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
    infoAgreeImageView.image = statusList[2] ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
  }
  
  private func setBtnStatus() {
    startBtn.isEnabled = false
    startBtn.backgroundColor = .grey04
  }
  
  private func setTextField() {
    nicknameInputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }
  
  private func setCountLabel(){
    if let count = nicknameInputTextField.text?.count{
      nicknameCountLabel.text = String(count) + "/20"
    }
  }
  
  private func checkMaxLabelCount(){
    if let text = nicknameInputTextField.text {
      if text.count > 20 || text.count < 2{
        // 🪓 주어진 인덱스에서 특정 거리만큼 떨어진 인덱스 반환
        // 🪓 문자열 자르기
        nicknameCountLabel.textColor = .alertRed
        nicknameInputTextField.layer.borderWidth = 1
        nicknameInputTextField.layer.cornerRadius = 5
        nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
        isNicknameValid = false
        
        if text.count > 20{
          let maxIndex = text.index(text.startIndex, offsetBy: 20)
          let newString = String(text[text.startIndex..<maxIndex])
          nicknameInputTextField.text = newString
        }
        //경고문구..!까지 띄우기
        
      }else{
        
        if isValidNickname(nickname: nicknameInputTextField.text){
          isNicknameValid = true
          nicknameCountLabel.textColor = .grey03
          nicknameInputTextField.layer.borderWidth = 1
          nicknameInputTextField.layer.cornerRadius = 5
          nicknameInputTextField.layer.borderColor = UIColor.grey04.cgColor
        }else{
          nicknameCountLabel.textColor = .alertRed
          nicknameInputTextField.layer.borderWidth = 1
          nicknameInputTextField.layer.cornerRadius = 5
          nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
          isNicknameValid = false
        }
      }
    }
  }
  
  private func isValidNickname(nickname: String?) -> Bool {
    guard nickname != nil else { return false }
    
    let nickRegEx = "[가-힣A-Za-z0-9]{2,20}"
    
    let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
    print("NICKNAME",nickname,pred.evaluate(with: nickname))
    return pred.evaluate(with: nickname)
  }
  
  private func addBtnActions() {
    startBtn.press {
      self.makeAlert(alertCase: .requestAlert, content: "회원가입을 그만두시겠습니까?") {
        //실제로는 이방법이 아니라 dismiss 되었을때 completion에 새로운 escaping closure를 선언해서 파라미터로 받아와서 해야한다....!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) {
          self.makeAlert(alertCase:   .requestAlert, content: "닉네임을 수정할 수 없습니다.\n이대로 가입을 진행할까요?") {
            print("SignUp 커스텀 Alert 완료")
          }
        }
      }
    }
  }
  
  // MARK: - @objc Function Part
  @objc func textFieldDidChange() {
    checkMaxLabelCount()
    setCountLabel()
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
  
  //  func textViewDidChange(_ textField: UITextField) {
  //    //      startBtn.setButtonState(isSelected: !nicknameInputTextField.text.isEmpty, title: I18N.Components.next)
  //    if let textField = textField as? UITextField {
  //      if let text = nicknameInputTextField.text {
  //        if text.count > 20 {
  //          // 🪓 주어진 인덱스에서 특정 거리만큼 떨어진 인덱스 반환
  //          let maxIndex = text.index(text.startIndex, offsetBy: 20)
  //          // 🪓 문자열 자르기
  //          let newString = String(text[text.startIndex..<maxIndex])
  //          nicknameInputTextField.text = newString
  //
  //          //경고문구..!까지 띄우기
  //
  //        }
  //      }
  //    }
  //  }
  
  
}


