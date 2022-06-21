//
//  SignUpNickNameVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/02/26.
//

import UIKit

enum nicknameStatus{
  case specialCharErr
  case strangeCharErr
  case countLetterErr
  case normal
}

class SignUpNicknameVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  var userToken : String = ""
  var socialType : String = ""
  var email: String?
  var timer: Timer?
  var time: Float = 0
  
  private var isNicknameValid : Bool = false {
    didSet {
      setStartBtnStatus()
    }
  }
  
  
  // MARK: - UI Component Part
  @IBOutlet var cancelBtn: UIButton!
  @IBOutlet var signUpProgressView: UIProgressView!{
    didSet{
      signUpProgressView.progressViewStyle = .bar
      signUpProgressView.progressTintColor = .black
      signUpProgressView.trackTintColor = .grey05
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.setProgress), userInfo: nil, repeats: true)
      }
    }
  }
  @IBOutlet var nicknameInputTextField: UITextField!{
    didSet {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: nicknameInputTextField.frame.height))
      nicknameInputTextField.leftView = paddingView
      nicknameInputTextField.leftViewMode = UITextField.ViewMode.always
      nicknameInputTextField.delegate = self
    }
  }
  @IBOutlet var nicknameCheckLabel: UILabel!{
    didSet {
      nicknameCheckLabel.isHidden = true
    }
  }
  @IBOutlet var nicknameCountLabel: UILabel!
  @IBOutlet var nextBtn: UIButton!
  
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setStartBtnStatus() //다음 버트 비활
    addTapGesture() //다른곳 누르면 키보드 사라지는것
    addToolbar(textfields: [nicknameInputTextField]) //키보드 툴바 세팅?
    //    setBtnStatus()
    setTextField() // 변경되는거 감지 -> 글자수 값, 글자수 제한
    addBtnActions() //다음 버튼을 눌렀을 때, postNickNameData 호출-> 닉네임 중복 체크해서 (1)중복 아니면 postSocialSignUpData 호출해서 Email로 이동? (2) 중복이면 "alert 보이게"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if (self.nicknameInputTextField.text?.isEmpty ?? true) {
      nextBtn.backgroundColor = .grey04
      nextBtn.isEnabled = false
    } else {
      nextBtn.backgroundColor = .bemyBlue
      nextBtn.isEnabled = true
    }
  }
  
  
  // MARK: - Custom Method Part
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
      nicknameCountLabel.text = String(count) + "/15"
    }
  }
  
  
  private func cutMaxLabel() {
    if let text = nicknameInputTextField.text {
      if text.count > 15{
        let maxIndex = text.index(text.startIndex, offsetBy: 15)
        let newString = String(text[text.startIndex..<maxIndex])
        nicknameInputTextField.text = newString
      }
    }
  }
  
  private func isValidNickname(nickname: String?) -> nicknameStatus {
    if !checkMaxLabelCount(nickname: nickname) { //글자수
      return .countLetterErr
    } else if !checkSpecialChar(nickname: nickname){ //특수 문자 있으면 true
      return .specialCharErr
    } else if !checkNormalChar(nickname: nickname) { //정규식에 안 맞으면 !false ㅇㄹ
      return .strangeCharErr
    } else {
      return .normal
    }
  }
  
  private func checkSpecialChar(nickname: String?) -> Bool {
    guard nickname != nil else { return false }
    
    let nickRegEx = "[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{2,15}"
    
    let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
    return pred.evaluate(with: nickname) //특수문자는 false
  }
  
  private func checkNormalChar(nickname: String?) -> Bool {
    guard nickname != nil else { return false }
    
    let nickRegEx = "[가-힣A-Za-z0-9]{2,15}"
    
    let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
    return pred.evaluate(with: nickname) //정규식에 맞으면 true
  }
  
  private func checkMaxLabelCount(nickname: String?) -> Bool {
    if let text = nicknameInputTextField.text {
      if text.count > 15 || text.count < 2{ //문제 있으면 false
        return false
      } else{
        return true
      }
    }
    return false
  }
  
  
  
  //토탈로 검사하는 함수 구현
  func alertNicknameStatus(){
    if let nickname = nicknameInputTextField.text {
      switch(isValidNickname(nickname: nickname)){
      case .countLetterErr:
        //글자수 문제 있을 경우
        self.nextBtn.isEnabled = false
        nicknameInputTextField.shake()
        nicknameCountLabel.textColor = .alertRed
        nicknameInputTextField.layer.borderWidth = 1
        nicknameInputTextField.layer.cornerRadius = 5
        nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
        isNicknameValid = false
        self.nicknameCheckLabel.isHidden = true
        break
        
      case .specialCharErr:
        self.nextBtn.isEnabled = true
        nicknameCheckLabel.textColor = .alertRed
        nicknameInputTextField.shake()
        nicknameCheckLabel.text = I18N.SignUp.SpecialChar.errorAlert
        nicknameInputTextField.layer.borderWidth = 1
        nicknameInputTextField.layer.cornerRadius = 5
        nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
        isNicknameValid = false
        self.nicknameCheckLabel.isHidden = false
        break
        
      case .strangeCharErr:
        self.nextBtn.isEnabled = true
        nicknameInputTextField.shake()

        nicknameCheckLabel.textColor = .alertRed
        nicknameCheckLabel.text = I18N.SignUp.StrangeChar.errorAlert
        nicknameInputTextField.layer.borderWidth = 1
        nicknameInputTextField.layer.cornerRadius = 5
        nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
        isNicknameValid = false
        self.nicknameCheckLabel.isHidden = false
        break
        
        
      case .normal :
        //세팅들
        self.nextBtn.isEnabled = true
        isNicknameValid = true
        nicknameCountLabel.textColor = .grey03
        nicknameInputTextField.layer.borderWidth = 1
        nicknameInputTextField.layer.cornerRadius = 5
        nicknameInputTextField.layer.borderColor = UIColor.bemyBlue.cgColor
        
        self.nicknameCheckLabel.isHidden = true
        break
        
      }
    }
  }
  
  
  private func addBtnActions() {
    //실제로는 이방법이 아니라 dismiss 되었을때 completion에 새로운 escaping closure를 선언해서 파라미터로 받아와서 해야한다....!
    nextBtn.press{
      self.nextBtn.isEnabled = false //버튼 여러번 눌리는거 해결
      if let nicknameInputTextField = self.nicknameInputTextField.text {
        self.postNickNameData(nickName: nicknameInputTextField)
      }
    }
    
    cancelBtn.press {
      self.makeAlert(alertCase: .requestAlert, content: "회원가입을 그만두시겠습니까?"){
        self.dismiss(animated: true) {
        }
      }
    }
  }
  
  private func postNickNameData(nickName: String) {
    BaseService.default.postNickNameCheck(nickName: nickName) { result in
      result.success { [weak self] data in
        if self?.socialType == "APPLE" {
          self?.pushSignUpTOSVC()
        } else {
          self?.pushSignUpEmailVC()
        }
        
      }.catch { error in
        self.nicknameCheckLabel.isHidden = false
        self.setBtnStatus()
        self.nicknameCheckLabel.text = I18N.SignUp.NickName.errorAlert
        self.nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
      }
    }
  }
  
  private func pushSignUpEmailVC() {
    guard let emailVC = UIStoryboard.list(.signup).instantiateViewController(withIdentifier: SignUpEmailVC.className) as? SignUpEmailVC else {return}
    self.navigationController?.pushViewController(emailVC, animated: true)
    emailVC.nickname = nicknameInputTextField.text!  //?? ""  //근데 ! 해도 될거 같은데 무조건 넘어오니까 맞죠..?
    emailVC.socialType = socialType
    emailVC.userToken = userToken
  }
  
  private func pushSignUpTOSVC() {
    guard let tosVC = UIStoryboard.list(.signup).instantiateViewController(withIdentifier: SignUpTOSVC.className) as? SignUpTOSVC else {return}
    self.navigationController?.pushViewController(tosVC, animated: true)
    tosVC.nickname = nicknameInputTextField.text!
    tosVC.email = email ?? ""
    tosVC.socialType = socialType
    tosVC.userToken = userToken
  }
  
  
  
  // MARK: - @objc Function Part
  @objc func textFieldDidChange() {
    //15개 이상 입력 안되도록
    cutMaxLabel()
    //case나눈것
    alertNicknameStatus()
    //    checkMaxLabelCount() //글자수 체크 , 한글이나 이것저것
    setCountLabel() //글자수 값 바뀌는거 실시간으로
  }
  
  @objc func setProgress() {
    time += 0.045
    signUpProgressView.setProgress(time, animated: true)
    if time >= 0.33 {
      timer?.invalidate()
    }
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
