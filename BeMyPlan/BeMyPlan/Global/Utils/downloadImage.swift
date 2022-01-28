//
//  downloadImage.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/28.
//

import UIKit
import Kingfisher

extension NSObject{
  func downloadImage(`with` urlString : String){
      guard let url = URL.init(string: urlString) else {
          return
      }
      let resource = ImageResource(downloadURL: url)

      KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
          switch result {
          case .success(let value):
              print("Image: \(value.image). Got from: \(value.cacheType)")
          case .failure(let error):
              print("Error: \(error)")
          }
      }
  }
}
