//
//  BaseAPI.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.

import Moya
import Alamofire

enum BaseAPI{
  case sampleAPI(sample : String)
  // 계정관련
  case postSignIn(email : String, pw : String)
  case postSignUp(email : String,  pw : String, name : String)
}

extension BaseAPI: TargetType {

  // MARK: - Base URL
  
  public var baseURL: URL {
    var base = Config.Network.baseURL
    switch self{
      case .sampleAPI:
        base += "더할 주소"
        
      case .postSignIn,.postSignUp:
        base += "/user"
    }
    guard let url = URL(string: base) else {
      fatalError("baseURL could not be configured")
    }
    return url
  }
  
  // MARK: - Path
  var path: String {
    switch self{
      case .sampleAPI:
        return "뒤에붙는 주소"
      case .postSignIn:
        return "/login"
      case .postSignUp:
        return "/signup"
      default :
        return ""
    }
  }
  
  // MARK: - Method
  var method: Moya.Method {
    switch self{
      case .postSignIn,.postSignUp :
        return .post
      default :
        return .get

    }
  }
  
  // MARK: - Data
  var sampleData: Data {
    return Data()
  }
  
  // MARK: - Parameters
  private var bodyParameters: Parameters? {
    var params: Parameters = [:]
    switch self{
      case .sampleAPI:
        params[""] = ""
      case .postSignIn(let email, let password) :
        params["email"] = email
        params["password"] = password
      case .postSignUp(let email, let password, let name):
        params["email"] = email
        params["name"] = name
        params["password"] = password
    }
    return params
  }
  
  // MARK: - MultiParts
  
  private var multiparts: [Moya.MultipartFormData] {
    switch self{
      case .sampleAPI(_):
        var multiparts : [Moya.MultipartFormData] = []
        multiparts.append(.init(provider: .data("".data(using: .utf8) ?? Data()), name: ""))
        return multiparts
      default : return []
//        images.forEach {
//          multiparts.append(.init(provider: .data($0), name: "images", fileName: "image.jpeg", mimeType: "image/jpeg"))
//        }
    }
  }

  private var parameterEncoding : ParameterEncoding{
    switch self {
      case .sampleAPI:
        return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
      default :
        return JSONEncoding.default
    }
  }

  var task: Task {
    switch self{
      case .sampleAPI:
        return .uploadMultipart(multiparts)
        
      case .postSignIn,.postSignUp:
        return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
 
    }
  }
  
  public var headers: [String: String]? {
    if let userToken = UserDefaults.standard.string(forKey: "userToken") {
      return ["Authorization": userToken,
              "Content-Type": "application/json"]
    }else{
      return ["Content-Type": "application/json"]
    }
  }
  
  public var validationType: ValidationType {
    return .successCodes
  }
}
