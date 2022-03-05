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
        if let _ = error {
          //예외처리 (로그인 취소)
          print("로그인 실패")
          //실패해서 실패 VC로 이동
          
        }
        else {
          if let accessToken = oauthToken?.accessToken {
            //토큰 가져오려면 다음과 같이 accessToken 사용
            self.postSocialLoginData(socialToken: accessToken, socialType: "KAKAO")
            // 유저 데이터 가져오려면 다음과 같이 UserAPI에서
            // user 값 가져오기
//            UserApi.shared.me { (user,error) in
//              print("👀 User Data")
//              dump(error)
//            }
            //성공해서 성공 VC로 이동
//            self.moveSignup()
          }
        }
      }
    }
    else { // 카카오 계정으로 로그인
      print("카카오톡 설치 되지 않음")
      UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
        if let _ = error {
          //실패해서 실패 VC로 이동
        }
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
  
  private func postSocialLoginData(socialToken: String, socialType: String) {
    BaseService.default.postSocialLogin(socialToken: socialToken, socialType: socialType) { result in
      result.success { [weak self] data in
        if let data = data{
            UserDefaults.standard.setValue(data.accessToken, forKey: "userToken")
            self?.moveBaseVC()
          }
      }.catch {error in
        self.pushSignUpNicknameVC(socialToken: socialToken, socialType: socialType)

      }
    }
  }

  private func pushSignUpNicknameVC(socialToken : String, socialType : String) {
    guard let signupNicknameVC = UIStoryboard.list(.signup).instantiateViewController(withIdentifier: SignUpNicknameVC.className) as? SignUpNicknameVC else {return}
    
    signupNicknameVC.socialType = socialType
    signupNicknameVC.userToken = socialToken
    
    signupNicknameVC.modalPresentationStyle = .overFullScreen
    signupNicknameVC.delegate = self
    self.present(signupNicknameVC, animated: true, completion: nil)
  }
  
}
