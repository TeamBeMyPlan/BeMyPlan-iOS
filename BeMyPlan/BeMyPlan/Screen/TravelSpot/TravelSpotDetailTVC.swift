//
//  TravelSpotDetailTVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/07.
//

import UIKit

class TravelSpotDetailTVC: UITableViewCell {
  
  static let identifier = "TravelSpotDetailTVC"
  
  @IBOutlet var contentImage: UIImageView!
  @IBOutlet var nickNameLabel: UILabel!
  @IBOutlet var titleTextView: UITextView!
  @IBOutlet var scrapBtn: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUIs()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  private func setUIs() {
    titleTextView.textContainer.maximumNumberOfLines = 2
    titleTextView.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
  }
  
  @IBAction func scrapBtnTapped(_ sender: Any) {
    scrapBtn.isSelected.toggle()
  }
}
