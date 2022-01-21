//
//  ScrapContainerCVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/13.
//

import UIKit

class ScrapContainerCVC: UICollectionViewCell, UICollectionViewRegisterable {
  static var isFromNib: Bool = true
  public var scrapBtnClicked: ((Int) -> ())?
  private var postId:Int = 1

  @IBOutlet var contentImage: UIImageView!
  @IBOutlet var scrapBtn: UIButton!
  @IBOutlet var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUIs()
  }
  
  @IBAction func scrapBtnTapped(_ sender: Any) {
    if let scrapBtnClicked = scrapBtnClicked {
      scrapBtnClicked(postId)
    }
    scrapBtn.isSelected.toggle()
  }
  
  private func setUIs() {
    contentImage.layer.cornerRadius = 5
    contentImage.contentMode = .scaleAspectFill
  }
  
  public func setData(data: ScrapItem) {
    contentImage.setImage(with: data.thumbnailURL)
    titleLabel.text = data.title
    postId = data.postID
  }
  
}
