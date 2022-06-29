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
  case getSuggestTravelList(page : Int, sort: String)
  
  case getTravelSpotDetailList(area: Int, page: Int, pageSize: Int?, sort: String)
  case getNicknameDetailList(userId: Int, page: Int, pageSize: Int?, sort: String)
  
  case postSocialLogin(socialToken: String, socialType: String)
	case postSocialSignUp(socialToken: String, socialType: String, nickName: String,email: String)
  case getNickNameCheck(nickName: String)

  // MARK: - 양원
  case getTravelSpotList
  case getRecentTripList(page: Int, pageSize: Int)
  case getScrapEmptyList

  // MARK: - Auth
	case postUserLogout
	case deleteUserWithdraw(reason: String)

  
  // MARK: - HomeList
  case getHomeOrderList // (최상단 부분, 구매순 정렬)
  case getHomeRecentlyList // (최신순 정렬)
  case getHomeBemyPlanList // (비마플 추천 데이터)
	
	// MARK: - ScrapList
	case getScrapList(lastScrapId: Int?, sort: String)
  case postScrap(postId: Int)
	case deleteScrap(postId: Int)
	
	// MARK: - MyPlan
	case getBuyList
	
	// MARK: - Order
	case postOrderPlan(postId: Int)

	
	// MARK: - Plan List + Paging
	case getRecentlyListWithPaging(lastPlanID: Int?)
	case getBemyPlanListWithPaging(lastPlanID: Int?)
	case getSpotPlanListWithPaging(spotName: String, lastPlanID: Int?,sortCase: String)
	case getUserPlanListWithPaging(userID: Int, lastPlanID: Int?,sortCase: String)
	
	// MARK: - Plan Preview, Detail
	case getPlanPreviewData(idx : Int)
	case getPlanDetailData(idx : Int)
	case getPlanDetailTransportData(idx: Int)
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

      case .getBuyList:
        base += "/plan/orders"
      
    case .getPopularTravelList, .getNewTravelList, .getSuggestTravelList, .getRecentTripList
        :
      base += "/post"
      
    case .getTravelSpotList:
      base += "/plan/regions"
    
		case .postUserLogout:
			base += "/logout"
					
    case  .postSocialLogin:
      base += "/login"
					
		case .deleteUserWithdraw:
			base += "/signout"
					
		case .postSocialSignUp:
			base += "/signup"
		
		case .getNickNameCheck:
			base += "/user"
      
    case .getTravelSpotDetailList:
      base += "/area"
      
    case .getNicknameDetailList:
        base += "/user"
          
		case  .postScrap,.deleteScrap:
      base += "/plan/scrap"
					
		case .getScrapList:
			base += "/plan"
      
    case .getScrapEmptyList:
      base += "/post/random"

    case .getHomeOrderList,.getHomeRecentlyList,.getHomeBemyPlanList:
      base += "/plans"
			
		case .getRecentlyListWithPaging,
						.getSpotPlanListWithPaging,
						.getUserPlanListWithPaging,
					  .getBemyPlanListWithPaging:
			base += "/plans"
					
				case .getPlanPreviewData,.getPlanDetailData, .getPlanDetailTransportData,.postOrderPlan :
				base += "/plan"
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
    case .getPlanPreviewData(let idx):
      return "/\(idx)/preview"
    case .getTravelSpotDetailList(let areaID,_,_,_):
      return "/\(areaID)"
			case .postScrap(let postId),.deleteScrap(let postId):
      return "/\(postId)"
    case .getNicknameDetailList(let userID,_,_,_):
      return "/\(userID)/posts"
    case .getScrapEmptyList:
      return "/"
    
		case .getScrapList:
      return "/bookmark"
    case .getNewTravelList, .getRecentTripList:
      return "/new"
    case .getSuggestTravelList:
      return "/suggest"
    case .getPlanDetailData(let idx):
      return "/\(idx)"
		case .getPlanDetailTransportData(let idx):
			return "/\(idx)/moveInfo"

    case .getNickNameCheck:
      return "/name/check"
			case .getHomeBemyPlanList,.getBemyPlanListWithPaging:
        return "/bemyplanPick"
			case .postOrderPlan:
				return "/order"
    default :
      return ""
    }
  }
  
  // MARK: - Method
  /// - note :
  ///  각 case 별로 get,post,delete,put 인지 정의합니다.
  var method: Moya.Method {
    switch self{
			case .sampleAPI, .postScrap, .postSocialLogin, .postSocialSignUp,.postOrderPlan:
      return .post
			case .deleteUserWithdraw,.deleteScrap:
      return .delete
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
      
    case .getTravelSpotDetailList(_, let page,_, let sort):
      params["page"] = page
      params["pageSize"] = 5
      params["sort"] = sort
      
    case .getNicknameDetailList(_, let page, _, let sort):
      params["page"] = page
      params["pageSize"] = 5
      params["sort"] = sort
      

    case .getScrapList(let lastId,let sort):
				if let lastId = lastId {
					params["lastPlanId"] = lastId
				}
      params["sort"] = sort
			params["size"] = 10

    case .getNewTravelList(let page):
      params["page"] = page
    case .getSuggestTravelList(let page, let sort):
      params["page"] = page
      params["sort"] = sort
      
    case .postSocialLogin(let socialToken, let socialType):
      params["token"] = socialToken
      params["socialType"] = socialType
      
    case .postSocialSignUp(let socialToken, let socialType, let nickName,let email):
			params["email"] = email
      params["token"] = socialToken
      params["socialType"] = socialType
      params["nickname"] = nickName
				
    case .getNickNameCheck(let nickName):
      params["nickname"] = nickName
        
      case .getHomeOrderList:
        params["size"] = 10
        params["sort"] = "orderCnt"
				params["sort"] = "desc"
        params["region"] = "JEJU"
				
			case .getHomeRecentlyList:
				params["size"] = 5
				params["sort"] = "createdAt,desc"
				params["region"] = "JEJU"
				
			case .getHomeBemyPlanList:
				params["size"] = 5
				params["sort"] = "createdAt,desc"
				params["region"] = "JEJU"
				
			case .getBuyList:
				params["sort"] = "createdAt"
				params["size"] = 20
				
			case .getRecentlyListWithPaging(let lastPlanID):
				params["sort"] = "createdAt"
				params["size"] = 10
				params["region"] = "JEJU"
				if let id = lastPlanID {
					params["lastPlanId"] = id
				}
			
			case .getBemyPlanListWithPaging(let lastPlanID):
				params["sort"] = "createdAt"
				params["size"] = 10
				params["region"] = "JEJU"
				if let id = lastPlanID {
					params["lastPlanId"] = id
				}
				
			case .getSpotPlanListWithPaging(let spotName,let lastPlanID, let sortCase):
				params["region"] = spotName
				params["sort"] = sortCase
				params["size"] = 10
				if let id = lastPlanID {
					params["lastPlanId"] = id
				}
				
			case .getUserPlanListWithPaging(let userID, let lastPlanID , let sortCase):
				params["region"] = "JEJU"
				params["sort"] = sortCase
				params["size"] = 10
				params["userId"] = userID
				if let id = lastPlanID {
					params["lastPlanId"] = id
				}
			case .postOrderPlan(let planID) :
				params["planId"] = planID
				
			case .deleteUserWithdraw(let reason) :
				params["reasonForWithdrawal"] = reason
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
			case .sampleAPI, .getTravelSpotDetailList, .getNicknameDetailList, .getScrapList, .getNewTravelList,
					.getSuggestTravelList, .postScrap,.deleteScrap,.getHomeOrderList,.getHomeRecentlyList,
					.getHomeBemyPlanList,.getBuyList,.getRecentlyListWithPaging, .getSpotPlanListWithPaging,
					.getUserPlanListWithPaging, .getBemyPlanListWithPaging,.getNickNameCheck:
      return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
    case .postSocialLogin, .postSocialSignUp :
      return JSONEncoding.default
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
			case .sampleAPI,.getTravelSpotDetailList, .getNicknameDetailList,
					.getScrapList,.getNewTravelList, .getSuggestTravelList,
					.postScrap,.deleteScrap,.postSocialLogin, .postSocialSignUp,
					.getNickNameCheck,.getHomeOrderList,.getHomeRecentlyList,
					.getHomeBemyPlanList,.getBuyList,.getRecentlyListWithPaging,
					.getSpotPlanListWithPaging,.getUserPlanListWithPaging,
					.getBemyPlanListWithPaging,.postOrderPlan,.deleteUserWithdraw:
      return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
    default:
      return .requestPlain
      
    }
  }

  public var headers: [String: String]? {

		if let sessionID = UserDefaults.standard.string(forKey: UserDefaultKey.sessionID) {
			return ["Content-Type": "application/json",
							"Visit-Option": "MEMBERSHIP",
							"Authorization" : sessionID]
		} else {
			return ["Content-Type": "application/json",
							"Visit-Option": "MEMBERSHIP",
							"Authorization" : Config.PreviewAccount.guestSessionID]
		}
  }
  
  public var validationType: ValidationType {
    return .successCodes
  }
  
  typealias Response = Codable
}
