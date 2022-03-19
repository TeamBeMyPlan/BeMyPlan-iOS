//
//  ImageSizeFetcherOperation.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/15.
//

import UIKit

final class ImageSizeFetcherOp: Operation {
  
  /// Callback to call at the end of the operation
  let callback: ImageSizeFetcher.Callback?
  
  /// Request data task
  let request: URLSessionDataTask
  
  /// Partial data
  private(set) var receivedData = Data()
  
  /// URL of the operation
  var url: URL? {
    return self.request.currentRequest?.url
  }
  
  /// Initialize a new operation for a given url.
  ///
  /// - Parameters:
  ///   - request: request to perform.
  ///   - callback: callback to call at the end of the operation.
  init(_ request: URLSessionDataTask, callback: ImageSizeFetcher.Callback?) {
    self.request = request
    self.callback = callback
  }
  
  ///MARK: - Operation Override Methods
  
  override func start() {
    guard !self.isCancelled else { return }
    self.request.resume()
  }
  
  override func cancel() {
    self.request.cancel()
    super.cancel()
  }
  
  //MARK: - Internal Helper Methods
  
  func onReceiveData(_ data: Data) {
    guard !self.isCancelled else { return }
    self.receivedData.append(data)
    
    // not enough data collected for anything
    guard data.count >= 2 else { return }
    
    // attempt to parse received data, if enough we can stop download
    do {
      if let result = try ImageSizeFetcherParser(sourceURL: self.url!, data) {
        self.callback?(nil,result)
        self.cancel()
      }
      // nothing received, continue accumulating data
    } catch let err { // parse has failed
      self.callback?(err,nil)
      self.cancel()
    }
  }
  
  func onEndWithError(_ error: Error?) {
    // download has failed, return to callback with the description of the error
    self.callback?(ImageParserErrors.network(error),nil)
    self.cancel()
  }
  
}
