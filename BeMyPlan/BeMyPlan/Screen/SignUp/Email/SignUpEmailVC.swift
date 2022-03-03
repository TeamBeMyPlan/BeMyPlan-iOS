//
//  SignUpEmailVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/02/26.
//

import UIKit

class SignUpEmailVC: UIViewController {

  // MARK: - Vars & Lets Part
  var delegate : SignupDelegate?
  var nickname : String = ""
  var userToken : String = ""
  var socialType : String = ""
  
  
  private var isEmailValid : Bool = false {
    didSet {
      setNextBtnStatus()
    }
  }
  
  // MARK: - UI Component Part
  @IBOutlet var backBtn: UIButton!
  @IBOutlet var signUpProgressView: UIProgressView!
  @IBOutlet var emailInputTextField: UITextField!
  @IBOutlet var emailCheckLabel: UILabel!{
    didSet{
      emailCheckLabel.isHidden = true
    }
  }
  @IBOutlet var nextBtn: UIButton!
  
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setNextBtnStatus() //다음 버트 비활
    addTapGesture() //다른곳 누르면 키보드 사라지는것
    addToolbar(textfields: [emailInputTextField]) //키보드 툴바 세팅?
    //    setBtnStatus()
    setTextField() // 변경되는거 감지 -> 글자수 값, 글자수 제한
    addBtnActions() //다음 버튼을 눌렀을 때, postNickNameData 호출-> 닉네임 중복 체크해서 (1)중복 아니면 postSocialSignUpData 호출해서 Email로 이동? (2) 중복이면 "alert 보이게"
    print("________________")
    print(nickname)
    print(socialType)
  }
  
  
  // MARK: - Custom Method Part
  private func setNextBtnStatus(){
    if isEmailValid{
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
    emailInputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }
  
  //여기서 유효성 검사
  private func checkMaxLabelCount(){
    if let text = emailInputTextField.text {
      //이메일 정규식에 맞으면
      if isValidEmail(email: emailInputTextField.text){
        isEmailValid = true //nextBtn관련
        emailInputTextField.layer.borderWidth = 1
        emailInputTextField.layer.cornerRadius = 5
        emailInputTextField.layer.borderColor = UIColor.grey04.cgColor
        
        self.emailCheckLabel.isHidden = true
      }else{
        emailInputTextField.layer.borderWidth = 1
        emailInputTextField.layer.cornerRadius = 5
        emailInputTextField.layer.borderColor = UIColor.alertRed.cgColor
        isEmailValid = false
        self.emailCheckLabel.isHidden = false
      }
    }
  }
  
  private func isValidEmail(email: String?) -> Bool {
    guard email != nil else { return false }
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let pred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return pred.evaluate(with: email)
  }
  
  
  private func addBtnActions() {
    //실제로는 이방법이 아니라 dismiss 되었을때 completion에 새로운 escaping closure를 선언해서 파라미터로 받아와서 해야한다....!
    nextBtn.press{
      self.nextBtn.isEnabled = false //버튼 여러번 눌리는거 해결
      if let emailInputTextField = self.emailInputTextField.text {
        //        self.postEmailData(email: emailInputTextField)
        //이거를 TOSVC에 전달하기만 하면 될듯? 서버 연결 할거 없음 중복 검사도 안하니까?
        
        self.pushSignUpTOSVC()
        self.nextBtn.isEnabled = true //되돌아왔을때 pop 했을때 버튼 비활되어 있어서 다시 true해주기
      }
    }
    
    backBtn.press {
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  
  private func postEmailData(email: String) {
    //email 서버 세팅 해야함
    //    BaseService.default.postNickNameCheck(email: email) { result in
    //      result.success { [weak self] data in
    //        if let data = data {
    //
    //          if !data.duplicated { // w
    //
    //            //alert두번 (닉네임 수정 불가 -> 확인 누르면 회원가입 된다
    //            //            self?.showSignupAlert()  // 회원가입 처리를 어떻게 함..?
    //            // 확인을 눌렀을 때  회원가입 합니다.
    //
    ////            self?.makeAlert(alertCase: .requestAlert, content: "닉네임을 수정할 수 없습니다.\n이대로 가입을 진행할까요?") {
    ////              self?.postSocialSignUpData()
    ////            }
    //
    ////            self?.postSocialSignUpData()
    //            self?.pushSignUpTOSVC()
    //
    //          } else { //중복 돠면 중복된 멘트 뜨게 해야하는데
    //            // 빨간 테투리 뜨는 걸로
    //            self?.emailCheckLabel.isHidden = false
    //            //회원가입 버튼 비활
    //            self?.setBtnStatus()
    //            self?.emailInputTextField.layer.borderColor = UIColor.alertRed.cgColor
    //          }
    //        }
    //      }.catch {error in
    //        //        self.pushSignUPVC(socialToken: socialToken, socialType: socialType)
    //
    //      }
    //    }
  }
  
  private func pushSignUpTOSVC() {
    guard let tosVC = UIStoryboard.list(.signup).instantiateViewController(withIdentifier: SignUpTOSVC.className) as? SignUpTOSVC else {return}
    self.navigationController?.pushViewController(tosVC, animated: true)
    tosVC.nickname = nickname
    tosVC.email = emailInputTextField.text!
    tosVC.socialType = socialType
    tosVC.userToken = userToken
  }
  
  
  
  // MARK: - @objc Function Part
  @objc func textFieldDidChange() {
    checkMaxLabelCount()
  }
  
}


// MARK: - Extension Part
extension SignUpEmailVC : UITextFieldDelegate{
  private func textViewDidBeginEditing(_ textField: UITextField) {
    //텍스트가 있을 경우
    if textField.text == I18N.SignUp.Email.placeHolder{
      emailInputTextField.text = ""
      emailInputTextField.textColor = .black
    }
    emailInputTextField.layer.borderColor = UIColor.alertRed.cgColor
  }
  
  private func textViewDidEndEditing(_ textField: UITextField) {
    //비어있을 경우 --> 아무것도 뭐 없는디 ..
    if textField.text == nil {
      textField.text = I18N.MyPlan.Withdraw.placeHolder
      textField.textColor = .black
    }
    emailInputTextField.layer.borderColor = UIColor.grey04.cgColor
  }
  
  
}
