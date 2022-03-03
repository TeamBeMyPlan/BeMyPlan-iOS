//
//  SignUpNickNameVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/02/26.
//

import UIKit

//enum LaunchInstructor {
//  case signing
//  case main
//
//  static func configure(_ isAuthorized: Bool = false) -> LaunchInstructor {
//    switch isAuthorized {
//      case false: return .signing
//      case true: return .main
//    }
//  }
//}



enum nicknameStatus{
  case strangeCharErr
  case specialCharErr
  case countLetterErr
  case normal
}

class SignUpNicknameVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  var delegate : SignupDelegate?
  var userToken : String = ""
  var socialType : String = "KAKAO"
  
  private var isNicknameValid : Bool = false {
    didSet {
      setStartBtnStatus()
    }
  }
  
  
  // MARK: - UI Component Part
  @IBOutlet var cancelBtn: UIButton!
  @IBOutlet var signUpProgressView: UIProgressView!
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
  
  private func checkMaxLabelCount(){
    if let text = nicknameInputTextField.text {
      if text.count > 15 || text.count < 2{
        // 🪓 주어진 인덱스에서 특정 거리만큼 떨어진 인덱스 반환
        // 🪓 문자열 자르기
        self.nextBtn.isEnabled = false
        //        self.nickNameCheckLabel.isHidden = true
        
        
        nicknameCountLabel.textColor = .alertRed
        nicknameInputTextField.layer.borderWidth = 1
        nicknameInputTextField.layer.cornerRadius = 5
        nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
        isNicknameValid = false
        self.nicknameCheckLabel.isHidden = true
        
        if text.count > 15{
          let maxIndex = text.index(text.startIndex, offsetBy: 15)
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
          print("특수문자 여기여기여기")  //문제 ㅁ ,ㅇ ㄹ 외자는 특수문자 아닌데 아래의 alert가 뜸, 특수 문자 등등 정규식 아닌 부분
          nicknameCheckLabel.textColor = .alertRed
          nicknameCheckLabel.text = I18N.SignUp.SpecialChar.errorAlert
          nicknameInputTextField.layer.borderWidth = 1
          nicknameInputTextField.layer.cornerRadius = 5
          nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
          isNicknameValid = false
          self.nicknameCheckLabel.isHidden = false
        }
        
        //여기에 if else로
        
        
      }
    }
  }
  
  private func isValidNickname(nickname: String?) -> Bool {
    guard nickname != nil else { return false }
    
    let nickRegEx = "[가-힣A-Za-z0-9]{2,15}"
    
    let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
    return pred.evaluate(with: nickname)
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
          self.delegate?.loginComplete() //BaseVC로 이동
          print("base로 이동") //제대로 출력됩니당
        }
      }
    }
    
    
  }
  
  //  private func showSignupAlert(){
  //    self.makeAlert(alertCase: .requestAlert, content: "닉네임을 수정할 수 없습니다.\n이대로 가입을 진행할까요?") {
  //      self.makeAlert(alertCase: .simpleAlert, title: "알림", content: "회원가입이 완료되었습니다."){
  //        self.dismiss(animated: true) {
  //          self.delegate?.loginComplete()
  //        }
  //      }
  //    }
  //  }
  
  private func postNickNameData(nickName: String) {
    BaseService.default.postNickNameCheck(nickName: nickName) { result in
      result.success { [weak self] data in
        if let data = data {
          
          if !data.duplicated { // w
            
            //alert두번 (닉네임 수정 불가 -> 확인 누르면 회원가입 된다
            //            self?.showSignupAlert()  // 회원가입 처리를 어떻게 함..?
            // 확인을 눌렀을 때  회원가입 합니다.
            
            //            self?.makeAlert(alertCase: .requestAlert, content: "닉네임을 수정할 수 없습니다.\n이대로 가입을 진행할까요?") {
            //              self?.postSocialSignUpData()
            //            }
            
            //            self?.postSocialSignUpData()
            
            
            self?.pushSignUpEmailVC()
            self?.nextBtn.isEnabled = true //되돌아왔을때 pop 했을때 버튼 비활되어 있어서 다시 true해주기
            
          } else { //중복 돠면 중복된 멘트 뜨게 해야하는데
            // 빨간 테투리 뜨는 걸로
            self?.nicknameCheckLabel.isHidden = false
            //회원가입 버튼 비활
            self?.setBtnStatus()
            self?.nicknameCheckLabel.text = I18N.SignUp.NickName.errorAlert
            self?.nicknameInputTextField.layer.borderColor = UIColor.alertRed.cgColor
          }
        }
      }.catch {error in
        //        self.pushSignUPVC(socialToken: socialToken, socialType: socialType)
        
      }
    }
  }
  
  //소셜 post 해주는거 마지막에 해줘야함
  //  private func postSocialSignUpData() {
  //    if let nickName = nicknameInputTextField.text {
  //      BaseService.default.postSocialSignUp(socialToken: userToken , socialType: socialType, nickName: nickName) { result in
  //        result.success{ [weak self] data in
  //          if let data = data {
  //            UserDefaults.standard.setValue(data.accessToken, forKey: "userToken")
  //            //BaseVC로 이동
  //
  //
  //            self?.makeAlert(alertCase: .simpleAlert, title: "알림", content: "회원가입이 완료되었습니다."){ //이거 알람뜨면 안되는거 같은데
  //              self?.dismiss(animated: true) {
  //                self?.delegate?.loginComplete()
  //                self?.pushSignUpEmailVC() //Base가 아니라 그... Email로 이동
  //
  //              }
  //            }
  //
  //          }
  //          //성공 하면 회원가입 성공 창으로 가기
  //          //서버에 데이터 넘겨주기
  //
  //        }.catch { error in
  //          self.makeAlert(alertCase: .simpleAlert, title: "알림", content: "회원가입이 실패되었습니다.")
  //
  //        }
  //      }
  //    }
  //  }
  
  //  private func pushBaseVC() {
  //    guard let baseVC = UIStoryboard.list(.base).instantiateViewController(withIdentifier: BaseVC.className) as? BaseVC else {return}
  //    self.navigationController?.pushViewController(baseVC, animated: true)
  //  }
  
  private func pushSignUpEmailVC() {
    guard let emailVC = UIStoryboard.list(.signup).instantiateViewController(withIdentifier: SignUpEmailVC.className) as? SignUpEmailVC else {return}
    self.navigationController?.pushViewController(emailVC, animated: true)
    emailVC.nickname = nicknameInputTextField.text!  //?? ""  //근데 ! 해도 될거 같은데 무조건 넘어오니까 맞죠..?
    emailVC.socialType = socialType
    emailVC.userToken = userToken
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
