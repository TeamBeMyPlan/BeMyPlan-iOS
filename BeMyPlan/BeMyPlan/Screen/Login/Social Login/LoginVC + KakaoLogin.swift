//
//  LoginVC + KakaoLogin.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/12.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

extension LoginVC {
  func kakaoLogin() {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let _ = error { self.showKakaoLoginFailMessage() }
        else {
          if let accessToken = oauthToken?.accessToken {
            // 액세스 토큰 받아와서 서버에게 넘겨주는 로직 작성
            print("TOKEN",accessToken)
            self.postSocialLoginData(socialToken: accessToken, socialType: "KAKAO")

          }
        }
      }
    }
    else { // 웹으로 로그인해도 똑같이 처리되도록
      UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
        if let _ = error { self.showKakaoLoginFailMessage() }
        else {
          if let accessToken = oauthToken?.accessToken {
            // 액세스 토큰 받아와서 서버에게 넘겨주는 로직 작성
            self.postSocialLoginData(socialToken: accessToken, socialType: "KAKAO")
          }
          //성공해서 성공 VC로 이동
        }
      }
    }
  }
    
  func postSocialLoginData(socialToken: String, socialType: String,email: String? = nil) {
    BaseService.default.postSocialLogin(socialToken: socialToken, socialType: socialType) { result in
      result.success { [weak self] data in
        if let data = data{
          if socialType == "KAKAO" {
            AppLog.log(at: FirebaseAnalyticsProvider.self, .complete_signin(method: .kakao))
          } else {
            AppLog.log(at: FirebaseAnalyticsProvider.self, .complete_signin(method: .apple))
          }
          UserDefaults.standard.setValue(data.nickname, forKey: UserDefaultKey.userNickname)
          UserDefaults.standard.setValue(data.sessionId, forKey: UserDefaultKey.sessionID)
            self?.moveBaseVC()
          }
      }.catch {error in
          self.pushSignUpNicknameVC(socialToken: socialToken, socialType: socialType,email: email)
      }
    }
  }
  
  private func pushSignUpNicknameVC(socialToken : String, socialType : String,email: String?) {
    
    let signupNicknameVC = factory.instantiateSignupNC(socialType: socialType, socialToken: socialToken,email: email)
    signupNicknameVC.modalPresentationStyle = .overFullScreen
    self.present(signupNicknameVC, animated: true, completion: nil)
  }
  
  private func showKakaoLoginFailMessage() {
    self.makeAlert(alertCase: .simpleAlert, title: I18N.Alert.error, content: I18N.Auth.kakaoLoginError)
  }
  
}
