//
//  BaseService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import Moya
import Alamofire
import RxSwift
import SwiftyJSON

fileprivate let provider: MoyaProvider<BaseAPI> = {
  let provider = MoyaProvider<BaseAPI>(endpointClosure: endpointClosure, session: DefaultAlamofireManager.shared)
  return provider
}()

fileprivate let endpointClosure = { (target: BaseAPI) -> Endpoint in
  let url = target.baseURL.appendingPathComponent(target.path).absoluteString
  var endpoint: Endpoint = Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
  return endpoint
}

fileprivate class DefaultAlamofireManager: Alamofire.Session {
  static let shared: DefaultAlamofireManager = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 10
    configuration.timeoutIntervalForResource = 10
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    
    return DefaultAlamofireManager(configuration: configuration)
  }()
}

class BaseService{
  static let `default` = BaseService()
  var disposeBag = DisposeBag()
  private init() {}
  
  func requestObjectInRx<T: Decodable>(_ target: BaseAPI) -> Observable<T?>{
    return Observable<T?>.create { observer in
      provider.rx
        .request(target)
        .subscribe { event in
          switch event {
            case .success(let value):
              do {
                let decoder = JSONDecoder()
                let body = try decoder.decode(ResponseObject<T>.self, from: value.data)
                observer.onNext(body.data)
                observer.onCompleted()
              } catch let error {
                observer.onError(error)
              }
            case .failure(let error):
              observer.onError(error)
          }
        }.disposed(by: self.disposeBag)
      return Disposables.create()
    }
  }
  
  func requestObject<T: Decodable>(_ target: BaseAPI, completion: @escaping (Result<T?, Error>) -> Void) {
    provider.request(target) { response in
      print("====> response")
      dump(response)
      switch response {
        case .success(let value):

          do {
            let decoder = JSONDecoder()
            
            if T.self == PlanDetailDataEntity.self || T.self == [PlanDetailTransportEntity].self {
              print("==== RESULT")
              let json = JSON(value.data)
              print(json)
            }

            
            let body = try decoder.decode(ResponseObject<T>.self, from: value.data)
            completion(.success(body.data))
          } catch let error {

            completion(.failure(error))
          }
        case .failure(let error):
          print("ERR 발생 ",T.self)
          switch error {
            case .underlying(let error, _):
              print("ERR 메세지",error.asAFError?.errorDescription)
              if error.asAFError?.isSessionTaskError ?? false {
              
              }
            default: break
          }
          completion(.failure(error))
      }
    }
  }
  
  func requestObjectWithNoResult(_ target: BaseAPI, completion: @escaping (Result<Int?, Error>) -> Void) {
    provider.request(target) { response in
      switch response {
        case .success(let value):

          completion(.success(value.statusCode))
         
        case .failure(let error):
          switch error {
            case .underlying(let error, _):
              if error.asAFError?.isSessionTaskError ?? false {
                
              }
            default: break
          }
          completion(.failure(error))
      }
    }
  }
}
