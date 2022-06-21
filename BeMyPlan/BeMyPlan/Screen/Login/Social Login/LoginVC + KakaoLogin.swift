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
    print("KAKAO LOGINGING")
    if (UserApi.isKakaoTalkLoginAvailable()) {
      // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let _ = error { self.showKakaoLoginFailMessage() }
        else {
          print("KAKAO accessToken")
          if let accessToken = oauthToken?.accessToken {
            
            //토큰 가져오려면 다음과 같이 accessToken 사용
            print("TOKEN",accessToken)
            self.postSocialLoginData(socialToken: accessToken, socialType: "KAKAO")

          }
        }
      }
    }
    else { // 카카오 계정으로 로그인
      UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
        if let _ = error { self.showKakaoLoginFailMessage() }
        else {
          // 여기서도 위와 같이 로그인 처리해주면 됨.
          if let accessToken = oauthToken?.accessToken {
            self.postSocialLoginData(socialToken: accessToken, socialType: "KAKAO")
          }
          print("loginWithKakaoTalk() success.")
          //성공해서 성공 VC로 이동
        }
      }
    }
  }
  
  func postSocialLoginData(socialToken: String, socialType: String,email: String? = nil) {
    print("postSocialLoginData",socialToken)
    BaseService.default.postSocialLogin(socialToken: socialToken, socialType: socialType) { result in
      result.success { [weak self] data in
        if let data = data{
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
