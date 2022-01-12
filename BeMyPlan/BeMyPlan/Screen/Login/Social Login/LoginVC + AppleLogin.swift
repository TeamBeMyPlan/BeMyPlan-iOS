//
//  LoginVC + AppleLogin.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/12.
//

import Foundation
import AuthenticationServices

extension LoginVC {
  func appleLogin(){
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }
}

extension LoginVC : ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return  self.view.window!
  }
}

extension LoginVC : ASAuthorizationControllerDelegate {
  //Apple ID 연동 성공시
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
      //Apple ID
    case let appleIDCredential as ASAuthorizationAppleIDCredential :
      
      //계정 정보 가져오기
      let identityToken = appleIDCredential.identityToken
      let tokenString = String(data: identityToken!, encoding: .utf8)
      
      //성공할 때 성공VC로 이동
      print("SOCIAL TOKEN", tokenString)
    default:
      //실패할 때 실패VC로 이동
      break
    }
  }
}
