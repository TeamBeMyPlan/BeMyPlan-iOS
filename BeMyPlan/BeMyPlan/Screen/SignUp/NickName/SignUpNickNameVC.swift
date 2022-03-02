//
//  SignUpNickNameVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/02/26.
//

import UIKit

class SignUpNicknameVC: UIViewController {
  
  var delegate : SignupDelegate?
  var userToken : String = ""
  var socialType : String = ""
  
  private var isNicknameValid : Bool = false {
    didSet {
      setStartBtnStatus()
    }
  }
  
  @IBOutlet var signUpProgressView: UIProgressView!
  @IBOutlet var nicknameInputTextField: UITextField!{
    didSet {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: nicknameInputTextField.frame.height))
      nicknameInputTextField.leftView = paddingView
      nicknameInputTextField.leftViewMode = UITextField.ViewMode.always
      nicknameInputTextField.delegate = self
    }
  }
  @IBOutlet var nicknameCheckLabel: UILabel!
  @IBOutlet var nicknameCountLabel: UILabel!{
    didSet {
      nicknameCheckLabel.isHidden = true
    }
  }
  @IBOutlet var nextBtn: UIButton!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setStartBtnStatus()
    addTapGesture()
    addToolbar(textfields: [nicknameInputTextField])
    setBtnStatus()
    setTextField()
    addBtnActions()
  }
  
  private func setStartBtnStatus(){
    if isNicknameValid{
      nextBtn.backgroundColor = .bemyBlue
      nextBtn.isEnabled = true
    } else {
      nextBtn.backgroundColor = .grey04
      nextBtn.isEnabled = false
    }
  }
  
  private func setBtnStatus() {
    nextBtn.isEnabled = false
    nextBtn.backgroundColor = .grey04
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
        self.nextBtn.isEnabled = false
        //        self.nickNameCheckLabel.isHidden = true
        
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
        self.nextBtn.isEnabled = true
        
        if isValidNickname(nickname: nicknameInputTextField.text){
          isNicknameValid = true
          nicknameCountLabel.textColor = .grey03
          nicknameInputTextField.layer.borderWidth = 1
          nicknameInputTextField.layer.cornerRadius = 5
          nicknameInputTextField.layer.borderColor = UIColor.grey04.cgColor
          
          self.nicknameCheckLabel.isHidden = true
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
    return pred.evaluate(with: nickname)
  }
  
  private func addBtnActions() {
    //실제로는 이방법이 아니라 dismiss 되었을때 completion에 새로운 escaping closure를 선언해서 파라미터로 받아와서 해야한다....!
    nextBtn.press{
      if let nicknameInputTextField = self.nicknameInputTextField.text {
        self.postNickNameData(nickName: nicknameInputTextField)
      }
    }
  }
  
  private func showSignupAlert(){
    self.makeAlert(alertCase: .requestAlert, content: "닉네임을 수정할 수 없습니다.\n이대로 가입을 진행할까요?") {
      self.makeAlert(alertCase: .simpleAlert, title: "알림", content: "회원가입이 완료되었습니다."){
        self.dismiss(animated: true) {
          self.delegate?.loginComplete()
        }
      }
    }
  }
  
  private func postSocialSignUpData() {
    if let nickName = nicknameInputTextField.text {
      BaseService.default.postSocialSignUp(socialToken: userToken , socialType: socialType, nickName: nickName) { result in
        result.success{ [weak self] data in
          if let data = data {
            UserDefaults.standard.setValue(data.accessToken, forKey: "userToken")
            //BaseVC로 이동
            
            self?.makeAlert(alertCase: .simpleAlert, title: "알림", content: "회원가입이 완료되었습니다."){
              self?.dismiss(animated: true) {
                self?.delegate?.loginComplete()
                self?.pushBaseVC()
                
              }
            }
            
          }
          //성공 하면 회원가입 성공 창으로 가기
          //서버에 데이터 넘겨주기
          
        }.catch { error in
          self.makeAlert(alertCase: .simpleAlert, title: "알림", content: "회원가입이 실패되었습니다.")
          
        }
      }
    }
  }
  
  private func pushBaseVC() {
    guard let baseVC = UIStoryboard.list(.base).instantiateViewController(withIdentifier: BaseVC.className) as? BaseVC else {return}
    self.navigationController?.pushViewController(baseVC, animated: true)
  }
  
  private func postNickNameData(nickName: String) {
    BaseService.default.postNickNameCheck(nickName: nickName) { result in
      result.success { [weak self] data in
        if let data = data {
          
          if !data.duplicated { // w
            
            //alert두번 (닉네임 수정 불가 -> 확인 누르면 회원가입 된다
            //            self?.showSignupAlert()  // 회원가입 처리를 어떻게 함..?
            // 확인을 눌렀을 때  회원가입 합니다.
            
            self?.makeAlert(alertCase: .requestAlert, content: "닉네임을 수정할 수 없습니다.\n이대로 가입을 진행할까요?") {
              
              self?.postSocialSignUpData()
              
            }
            
          } else {
            // 빨간 테투리 뜨는 걸로
            self?.nicknameCheckLabel.isHidden = false
            //회원가입 버튼 비활
            self?.setBtnStatus()
            self?.nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
          }
        }
      }.catch {error in
        //        self.pushSignUPVC(socialToken: socialToken, socialType: socialType)
        
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
extension SignUpNicknameVC : UITextFieldDelegate{
  private func textViewDidBeginEditing(_ textField: UITextField) {
    //텍스트가 있을 경우
    if textField.text == I18N.SignUp.NickName.placeHolder{
      nicknameInputTextField.text = ""
      nicknameInputTextField.textColor = .black
    }
    nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
  }
  
  private func textViewDidEndEditing(_ textField: UITextField) {
    //비어있을 경우 --> 아무것도 뭐 없는디 ..
    if textField.text == nil {
      textField.text = I18N.MyPlan.Withdraw.placeHolder
      textField.textColor = .black
    }
    nicknameInputTextField.layer.borderColor = UIColor.grey04.cgColor
  }

  
}
protocol SignupDelegate{
  func loginComplete()
}
