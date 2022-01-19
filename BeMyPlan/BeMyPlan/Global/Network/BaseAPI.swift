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
  case getNewTravelList(page : Int)
  case getSuggestTravelList(page : Int)
  
  // MARK: - 양원
  case getTravelSpotList
  case getTravelSpotDetailList(area: Int, page: Int,sort:String)
  case getRecentTripList(page: Int, pageSize: Int)
  case getScrapList(userId: Int, page: Int, pageSize: Int, sort: String)
  
  case postScrapBtn
  
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
      
<<<<<<< HEAD
    case .getPopularTravelList:
=======
    case .getPopularTravelList, .getNewTravelList, .getSuggestTravelList:
>>>>>>> 68e37420ee4e5ed41ae02dea2e4c1d3861c8553d
      base += "/post"
      
    case .getTravelSpotList:
      base += "/area"
      
    case .getBuyList:
      base += "/order"
      
<<<<<<< HEAD
    case .getTravelSpotDetailList:
      base += "/area"
      
    case .getRecentTripList:
      base += "/post/new"
     
    case .getScrapList:
      base += "/scrap"
      
  
      
    case .postScrapBtn:
      base += "추후 수정"
      
=======
>>>>>>> 68e37420ee4e5ed41ae02dea2e4c1d3861c8553d
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
<<<<<<< HEAD
      case .getPopularTravelList:
        return "/popular"
      case .getBuyList(let userID):
        return "/\(userID)"
      case .getTravelSpotDetailList(let area,_,_):
        return "/\(area)"
      
//      case .getRecentTripList(let page, _):
//      return ""
      
    case .getScrapList(let userId, _, _, _):
      return "/\(userId)"
      
      default :
        return ""
=======
    case .getPopularTravelList:
      return "/popular"
    case .getNewTravelList:
      return "/new"
    case .getSuggestTravelList:
      return "/suggest"
    case .getBuyList(let userID):
      return "/\(userID)"
    default :
      return ""
>>>>>>> 68e37420ee4e5ed41ae02dea2e4c1d3861c8553d
    }
  }
  
  // MARK: - Method
  /// - note :
  ///  각 case 별로 get,post,delete,put 인지 정의합니다.
  
  var method: Moya.Method {
    switch self{
<<<<<<< HEAD
      case .sampleAPI:
        return .post

      default :
        return .get

=======
    case .sampleAPI:
      return .post
    default :
      return .get
      
>>>>>>> 68e37420ee4e5ed41ae02dea2e4c1d3861c8553d
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
<<<<<<< HEAD
      case .sampleAPI(let email):
        params["email"] = email
        params["password"] = "여기에 필요한 Value값 넣기"
      
      case .getTravelSpotDetailList(let area, let page, let sort):
        params["page"] = page
        params["pageSize"] = 5
        params["sort"] = sort
      
//      case .getRecentTripList(let page, let pageSize):
//        params["page"] = page
//        params["pageSize"] = 5
      
    case .getScrapList(_, let page, let pageSize, let sort):
      params["page"] = page
      params["pageSize"] = 5
      params["sort"] = sort
      
      default:
        break

=======
    case .sampleAPI(let email):
      params["email"] = email
      params["password"] = "여기에 필요한 Value값 넣기"
    case .getNewTravelList(let page):
      params["page"] = page
    case .getSuggestTravelList(let page):
      params["page"] = page
    default:
      break
      
>>>>>>> 68e37420ee4e5ed41ae02dea2e4c1d3861c8553d
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
<<<<<<< HEAD
    case .sampleAPI, .getTravelSpotDetailList, .getScrapList:
        return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
      default :
        return JSONEncoding.default
=======
    case .sampleAPI, .getNewTravelList, .getSuggestTravelList:
      return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
    default :
      return JSONEncoding.default
>>>>>>> 68e37420ee4e5ed41ae02dea2e4c1d3861c8553d
    }
  }
  
  /// - note :
  ///  body Parameters가 있는 경우 requestParameters  case 처리.
  ///  일반적인 처리는 모두 requestPlain으로 사용.
  ///
  var task: Task {
    switch self{
<<<<<<< HEAD
    case .sampleAPI,.getTravelSpotDetailList, .getScrapList:
        return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
      default:
        return .requestPlain
 
=======
    case .sampleAPI, .getNewTravelList, .getSuggestTravelList:
      return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
    default:
      return .requestPlain
      
>>>>>>> 68e37420ee4e5ed41ae02dea2e4c1d3861c8553d
    }
  }
  
  
  public var headers: [String: String]? {
    if let userToken = UserDefaults.standard.string(forKey: "userToken") {
      return ["Authorization": userToken,
              "Content-Type": "application/json"]
    } else {
      return ["Content-Type": "application/json"]
    }
  }
  
  public var validationType: ValidationType {
    return .successCodes
  }
}
