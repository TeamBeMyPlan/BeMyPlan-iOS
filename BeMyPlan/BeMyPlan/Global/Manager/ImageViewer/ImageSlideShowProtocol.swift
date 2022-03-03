//
//  ImageSlideShowProtocol.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/04.
//

import Foundation
import ImageSlideShowSwift

class ImageForSlide: NSObject, ImageSlideShowProtocol {
  
  private let url: URL
  let title: String?
  
  init(title: String, url: URL) {
    self.title = title
    self.url = url
  }
  
  func slideIdentifier() -> String {
    return String(describing: url)
  }
  
  func image(completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: self.url) { data, response, error in
      if let data = data, error == nil {
        let image = UIImage(data: data)
        completion(image, nil)
      } else {
        completion(nil, error)
      }
    }.resume()
  }
}
