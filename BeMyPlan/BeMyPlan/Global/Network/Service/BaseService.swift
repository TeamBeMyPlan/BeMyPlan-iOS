//
//  BaseService.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import Moya
import Alamofire

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
  private init() {}
  
  func requestObject<T: Decodable>(_ target: BaseAPI, completion: @escaping (Result<T?, Error>) -> Void) {
    provider.request(target) { response in
      print("RequestObjectResponse!!")
      dump(response)
      switch response {
        case .success(let value):
          do {
            let decoder = JSONDecoder()
            let body = try decoder.decode(ResponseObject<T>.self, from: value.data)
            completion(.success(body.data))
          } catch let error {
            completion(.failure(error))
          }
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
  
  func requestArray<T: Decodable>(_ target: BaseAPI, completion: @escaping (Result<[T], Error>) -> Void) {
    provider.request(target) { response in
      switch response {
        case .success(let value):
          do {
            let decoder = JSONDecoder()
            let body = try decoder.decode(ResponseObject<[T]>.self, from: value.data)
            completion(.success(body.data ?? []))
          } catch let error {
            completion(.failure(error))
          }
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
