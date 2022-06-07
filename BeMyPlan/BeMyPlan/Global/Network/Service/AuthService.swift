//
//  AuthService.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/21.
//

import Foundation

protocol AuthServiceType{
  func postSocialLogin(socialToken: String, socialType: String, completion: @escaping (Result<AuthDataGettable?, Error>) -> Void)
  func postSocialSignUp(socialToken: String, socialType: String, nickName: String, email: String, completion: @escaping (Result<AuthDataGettable?, Error>) -> Void)
  func postNickNameCheck(nickName: String, completion: @escaping (Result<String?, Error>) -> Void)
}

extension BaseService : AuthServiceType {
  func postSocialLogin(socialToken: String, socialType: String, completion: @escaping (Result<AuthDataGettable?, Error>) -> Void) {
    requestObject(.postSocialLogin(socialToken: socialToken, socialType: socialType), completion: completion)
  }
  
  func postSocialSignUp(socialToken: String, socialType: String, nickName: String, email: String, completion: @escaping (Result<AuthDataGettable?, Error>) -> Void) {
    requestObject(.postSocialSignUp(socialToken: socialToken, socialType: socialType, nickName: nickName,email: email), completion: completion)
    }
  
  func postNickNameCheck(nickName: String, completion: @escaping (Result<String?, Error>) -> Void) {
    requestObject(.getNickNameCheck(nickName: nickName), completion: completion)
  }
  
  func postUserLogout(completion: @escaping (Result<String?, Error>) -> Void) {
    requestObject(.postUserLogout, completion: completion)
  }
  
  func deleteUser(reason: String,completion: @escaping (Result<String?, Error>) -> Void) {
    requestObject(.deleteUserWithdraw(reason: reason), completion: completion)
  }
}
