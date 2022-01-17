//
//  BaseAPI.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.

import Moya
import Alamofire

enum BaseAPI{
  case sampleAPI(sample : String)
  // MARK: - 현주
  case getPopularTravelList
  
  // MARK: - 양원
  case getTravelSpotList
  
  // MARK: - 지훈
  case getBuyList(userID: Int)
}

extension BaseAPI: TargetType {

  // MARK: - Base URL & Path
  /// - Parameters:
  ///   - base : 각 api case별로 앞에 공통적으로 붙는 주소 부분을 정의합니다.
  ///   - path : 각 api case별로 뒤에 붙는 개별적인 주소 부분을 정의합니다. (없으면 안적어도 상관 X)
  ///           bas eURL과  path의 차이점은
  ///           a  : (고정주소값)/post/popular
  ///           b  : (고정주소값)/post/new
  ///
  ///     a와 b 라는 주소가 있다고 하면은
  ///     case a,b -> baseURL은 "/post"이고,
  ///      case a -> path 은 "/popular"
  ///      case b -> path 는 /new" 입니다.
  ///
  public var baseURL: URL {
    var base = Config.Network.baseURL
    switch self{
      case .sampleAPI:
        base += ""
        
      case .getPopularTravelList:
        base += "/post"
        
      case .getTravelSpotList:
        base += "/area"

      case .getBuyList:
        base += "/order"
    }
    guard let url = URL(string: base) else {
      fatalError("baseURL could not be configured")
    }
    return url
  }
  
  // MARK: - Path
  /// - note :
  ///  path에 필요한 parameter를 넣어야 되는 경우,
  ///  enum을 정의했을때 적은 파라미터가
  ///  .case이름(let 변수이름):
  ///  형태로 작성하면 변수를 받아올 수 있습니다.
  ///
  var path: String {
    switch self{
      case .getPopularTravelList:
        return "/popular"
      case .getBuyList(let userID):
        return "/\(userID)"
      default :
        return ""
    }
  }
  
  // MARK: - Method
  /// - note :
  ///  각 case 별로 get,post,delete,put 인지 정의합니다.
  
  var method: Moya.Method {
    switch self{
      case .sampleAPI:
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
  /// - note :
  ///  post를 할때, body Parameter를 담아서 전송해야하는 경우가 있는데,
  ///  이 경우에 사용하는 부분입니다.
  ///
  ///  (get에서는 사용 ❌, get의 경우에는 쿼리로)
  ///
  private var bodyParameters: Parameters? {
    var params: Parameters = [:]
    switch self{
      case .sampleAPI(let email):
        params["email"] = email
        params["password"] = "여기에 필요한 Value값 넣기"
      default:
        break

    }
    return params
  }
  
  // MARK: - MultiParts
  
  /// - note :
  ///  사진등을 업로드 할때 사용하는 multiparts 부분이라 따로 사용 X
  ///
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

  /// - note :
  ///  query문을 사용하는 경우 URLEncoding 을 사용해야 합니다
  ///  나머지는 그냥 전부 다 default 처리.
  ///
  private var parameterEncoding : ParameterEncoding{
    switch self {
      case .sampleAPI:
        return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
      default :
        return JSONEncoding.default
    }
  }

  /// - note :
  ///  body Parameters가 있는 경우 requestParameters  case 처리.
  ///  일반적인 처리는 모두 requestPlain으로 사용.
  ///
  var task: Task {
    switch self{
      case .sampleAPI:
        return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
      default:
        return .requestPlain
 
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
