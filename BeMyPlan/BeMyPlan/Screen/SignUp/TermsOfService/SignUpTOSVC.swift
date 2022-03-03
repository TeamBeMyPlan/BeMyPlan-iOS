//
//  SignUpTOSVC.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/02/26.
//

import UIKit

class SignUpTOSVC: UIViewController {
  // MARK: - Vars & Lets Part
  var delegate : SignupDelegate?
  var email : String = ""
  var nickname : String = ""
  var userToken : String = ""
  var socialType : String = ""
  
  private var statusList : [Bool] = [false,false,false]{
    didSet{
      showCheckImageForStatus()
      setStartBtnStatus()
    }
  }
  
  // MARK: - UI Component Part
  @IBOutlet var backBtn: UIButton!
  @IBOutlet var signUpProgressView: UIProgressView!
  @IBOutlet var boxView: UIView!
  @IBOutlet var allAgreeImageView: UIImageView!
  @IBOutlet var firstAgreeImageView: UIImageView!
  @IBOutlet var secondAgreeImageView: UIImageView!
  @IBOutlet var startBtn: UIButton!
  
  
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setBoxViewUI()
    setStartBtnStatus()
    addBtnActions()
    print("________________")
    print(nickname)
    print(email)
    print(socialType)
  }
  
  // MARK: - IBAction Part
  @IBAction func pressAllAgree(_ sender: Any) {
    statusList[0] = !statusList[0]
    manageStatusList()
  }
  
  @IBAction func pressFirstAgree(_ sender: Any) {
    statusList[1] = !statusList[1]
    manageTotalStatus()
  }
  
  @IBAction func pressSecondAgree(_ sender: Any) {
    statusList[2] = !statusList[2]
    manageTotalStatus()
  }
  
  // MARK: - Custom Method Part
  private func setBoxViewUI() {
    boxView.layer.borderWidth = 1
    boxView.layer.cornerRadius = 5
    boxView.layer.borderColor = UIColor.grey04.cgColor
  }
  
  private func setStartBtnStatus(){
    if statusList[0] {
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
    allAgreeImageView.image = statusList[0] ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
    firstAgreeImageView.image = statusList[1] ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
    secondAgreeImageView.image = statusList[2] ? ImageLiterals.SignUp.checkonIcon : ImageLiterals.SignUp.checkoffIcon
  }
  
  private func setBtnStatus() {
    startBtn.isEnabled = false
    startBtn.backgroundColor = .grey04
  }
  
  private func addBtnActions() {
    //실제로는 이방법이 아니라 dismiss 되었을때 completion에 새로운 escaping closure를 선언해서 파라미터로 받아와서 해야한다....!
    startBtn.press{
//      self.postSocialSignUpData()
    }
    
    backBtn.press {
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  //여기서 닉네임, 아이디, 소셜타입, userToken 전달 해야함
  private func postSocialSignUpData() {
    BaseService.default.postSocialSignUp(socialToken: userToken , socialType: socialType, nickName: nickname) { result in
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
  
  private func pushBaseVC() {
    guard let baseVC = UIStoryboard.list(.base).instantiateViewController(withIdentifier: BaseVC.className) as? BaseVC else {return}
    self.navigationController?.pushViewController(baseVC, animated: true)
  }
  
  
  // MARK: - @objc Function Part
  
}

// MARK: - Extension Part


