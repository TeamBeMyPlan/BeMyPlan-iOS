//
//  AuthService.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/21.
//

import Foundation


protocol AuthServiceType{
  func postSocialLogin(socialToken: String, socialType: String, completion: @escaping (Result<AuthDataGettable?, Error>) -> Void)
  func postSocialSignUp(socialToken: String, socialType: String, nickName: String, completion: @escaping (Result<AuthDataGettable?, Error>) -> Void)
}

extension BaseService : AuthServiceType {
  func postSocialLogin(socialToken: String, socialType: String, completion: @escaping (Result<AuthDataGettable?, Error>) -> Void) {
    requestObject(.postSocialLogin(socialToken: socialToken, socialType: socialType), completion: completion)
  }
  
  func postSocialSignUp(socialToken: String, socialType: String, nickName: String, completion: @escaping (Result<AuthDataGettable?, Error>) -> Void) {
      requestObject(.postSocialSignUp(socialToken: socialToken, socialType: socialType, nickName: nickName), completion: completion)
    }

}
