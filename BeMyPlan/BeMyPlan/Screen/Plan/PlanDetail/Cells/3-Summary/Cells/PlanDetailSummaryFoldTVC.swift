//
//  PlanDetailSummaryFoldTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailSummaryFoldTVC: UITableViewCell,UITableViewRegisterable{

  static var isFromNib: Bool = true
  var delegate : SummaryFoldDelegate?
  @IBOutlet var iconimageView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  func setFoldState(isFolded : Bool){
      iconimageView
        .image = isFolded ? ImageLiterals.PlanDetail.foldIcon : ImageLiterals.PlanDetail.moreIcon
  }
  @IBAction func foldButtonClicked(_ sender: Any) {
    makeVibrate()
    delegate?.foldButtonClicked()
    
  }
}

protocol SummaryFoldDelegate{
  func foldButtonClicked()
}
