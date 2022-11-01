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
  var time: Float = 0.66
  var timer: Timer?
  
  private var statusList : [Bool] = [false,false,false]{
    didSet{
      showCheckImageForStatus()
      setStartBtnStatus()
    }
  }
  
  // MARK: - UI Component Part
  @IBOutlet var backBtn: UIButton!
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
  
  @IBAction func agreeButtonClicked(_ sender: Any) {
    guard let url = URL(string: "https://boggy-snowstorm-fdb.notion.site/a69b7abcdb9f42399825f4ff25343bfd"), UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
  
  @IBAction func informationButtonClicked(_ sender: Any) {
    guard let url = URL(string: "https://boggy-snowstorm-fdb.notion.site/41be86bb755a40c09414be125908228d"), UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
    startBtn.press{
      self.postSocialSignUpData()
    }
    
    backBtn.press {
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  //여기서 닉네임, 아이디, 소셜타입, userToken 전달 해야함
  private func postSocialSignUpData() {
    BaseService.default.postSocialSignUp(socialToken: userToken , socialType: socialType, nickName: nickname, email: email) { result in
      result.success{ [weak self] data in
        if let data = data {
          UserDefaults.standard.setValue(data.userId, forKey: UserDefaultKey.userID)
          UserDefaults.standard.setValue(data.sessionId, forKey: UserDefaultKey.sessionID)
          UserDefaults.standard.setValue(data.nickname, forKey: UserDefaultKey.userNickname)
          let socialType: LogEventType.LoginSource = (self?.socialType == "KAKAO") ? .kakao : .apple
            AppLog.log(at: FirebaseAnalyticsProvider.self, .complete_signin(method: socialType))
          
          self?.makeAlert(alertCase: .simpleAlert, title: "알림", content: "회원가입이 완료되었습니다."){
            self?.dismiss(animated: true) {
              self?.postObserverAction(.signupComplete)
            }
          }
        }
      }.catch { error in
        self.makeAlert(alertCase: .simpleAlert, title: "알림", content: "네트워크 상태를 확인해주세요")
      }
    }
  }
  
  private func pushBaseVC() {
    guard let baseVC = UIStoryboard.list(.base).instantiateViewController(withIdentifier: BaseVC.className) as? BaseVC else {return}
    self.navigationController?.pushViewController(baseVC, animated: true)
  }
  
  // MARK: - @objc Function Part
  @objc func setProgress() {
    time += 0.045
    signUpProgressView.setProgress(time, animated: true)
    if time >= 1 {
      timer?.invalidate()
    }
  }
  
}
