//
//  setImage.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/10.
//

import UIKit
import Kingfisher

extension UIImageView {
  func setImage(with urlString: String, placeholder: String? = nil, completion: ((UIImage?) -> Void)? = nil) {
    let cache = ImageCache.default
    if urlString == "" {
      self.image = UIImage()
    } else {
      cache.retrieveImage(forKey: urlString) { result in
        result.success { imageCache in
          if let image = imageCache.image {
            self.image = image
            completion?(image)
          } else {
            self.setNewImage(with: urlString, placeholder: placeholder, completion: completion)
          }
        }.catch { _ in
          self.setNewImage(with: urlString, placeholder: placeholder, completion: completion)
        }
      }
    }
  }
  
  private func setNewImage(with urlString: String, placeholder: String? = "img_placeholder", completion: ((UIImage?) -> Void)? = nil) {
    guard let url = URL.decodeURL(urlString: urlString) else { return }
    let resource = ImageResource(downloadURL: url, cacheKey: urlString)
    let placeholderImage = UIImage(named: "img_placeholder")
    let placeholder = placeholderImage
    
    self.kf.setImage(
      with: resource,
      placeholder: placeholder,
      options: [
        .scaleFactor(UIScreen.main.scale/1),
        .transition(.fade(0.3))
      ],
      completionHandler:  { result in
        result.success { imageResult in
          completion?(imageResult.image)
        }
      }
    )
  }
}
