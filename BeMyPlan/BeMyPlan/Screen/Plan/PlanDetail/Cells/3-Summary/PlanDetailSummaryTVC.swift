//
//  PlanDetailSummaryTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

struct PlanDetailSummaryViewModel{
  var locationList: [PlanDetail.Summary]
  var isFold: Bool
}

class PlanDetailSummaryTVC: UITableViewCell,UITableViewRegisterable{
  
  var viewModel: PlanDetailSummaryViewModel!{
    didSet{
      calculateSummaryHeight()
      listTV.reloadData()
    }
  }
  static var isFromNib: Bool = true
  private var first : CGFloat = 0,
      middle : CGFloat = 0,
      last : CGFloat = 0,
      additional : CGFloat = 0
  
  @IBOutlet var listTV: UITableView!{
    didSet{
      listTV.delegate = self
      listTV.dataSource = self
      listTV.allowsSelection = false
      listTV.layer.cornerRadius = 5
      listTV.separatorStyle = .none
      listTV.layer.applyShadow(color: UIColor.init(red: 165/255,
                                                   green: 165/255,
                                                   blue: 165/255,
                                                   alpha: 0.25),
                               alpha: 1, x: 1, y: 1, blur: 10, spread: 0)
    }
  }
  @IBOutlet var listTVHeightConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    registerCells()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func calculateSummaryHeight(){
    var totalHeight : CGFloat = 0
    let locationList = viewModel.locationList
    let isFold = viewModel.isFold
    first = locationList.count == 1 ? 60 : 81
    middle = 58
    last = 39
    additional = locationList.count > 5 ? 32 : 0
    
    if locationList.count == 1{
      totalHeight = first + additional
    }else if locationList.count >= 5 && isFold == true{
      totalHeight = 3 * middle + first + last + additional
    }else{
      totalHeight = CGFloat((locationList.count - 2)) * middle + first + last + additional
    }
    listTVHeightConstraint.constant = totalHeight
    contentView.layoutIfNeeded()
  }
  
  private func registerCells(){
    PlanDetailSummaryRouteTVC.register(target: listTV)
    PlanDetailSummaryFoldTVC.register(target: listTV)
  }

}

extension PlanDetailSummaryTVC : UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let locationList = viewModel.locationList
    let isFold = viewModel.isFold
    
    if locationList.count > 5{
      
      if isFold == true{
        switch(indexPath.row){
          case 0:
            return first
          case 4:
            return last
          case 5:
            return additional
          default:
            return middle
        }
      }else{
        switch(indexPath.row){
          case 0:
            return first
          case locationList.count - 1:
            return last
          case locationList.count:
            return additional
          default:
            return middle
        }
      }

    }else if locationList.count > 1{
      switch(indexPath.row){
        case 0:
          return first
        case locationList.count - 1:
          return last
        default:
          return middle
      }
    }else if locationList.count == 1 {
      return first
    }else{
      return 0
    }
  }
}

extension PlanDetailSummaryTVC : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if viewModel.locationList.count <= 5{
      return viewModel.locationList.count
    }else{
      if viewModel.isFold == true {
        return 6
      }else{
        return viewModel.locationList.count + 1
      }
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var order : OrderCase
    let locationList = viewModel.locationList
    let isFold = viewModel.isFold
    
    if locationList.count <= 5{
      if indexPath.row == 0 && locationList.count == 1{
        order = .onlyOne
      }else if indexPath.row == 0{
        order = .first
      }else if indexPath.row == locationList.count - 1{
        order = .final
      }else{
        order = .middle
      }
    }else{
      if isFold == true && indexPath.row == 4{
        order = .final
      }else if (isFold == false) && (indexPath.row == locationList.count - 1){
        order = .final
      }else if indexPath.row == 0{
        order = .first
      }else{
        order = .middle
      }
    }

    var routeCell = PlanDetailSummaryRouteTVC()
    var moreCell = PlanDetailSummaryFoldTVC()
    
    if locationList.count <= 5{
      guard let infoCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryRouteTVC.className, for: indexPath) as? PlanDetailSummaryRouteTVC else {return UITableViewCell() }
      routeCell = infoCell
      routeCell.setLocationData(order: order,
                                locationName: locationList[indexPath.row].locationName,
                                transportCase:  (locationList.count == indexPath.row + 1) ? nil : locationList[indexPath.row].transportCase,
                                time: (locationList.count == indexPath.row + 1) ? "" : locationList[indexPath.row].time)
    }else{
      if (isFold == true && indexPath.row == 5) || (isFold == false && indexPath.row == locationList.count){
          guard let moreButtonCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryFoldTVC.className, for: indexPath) as? PlanDetailSummaryFoldTVC else {return UITableViewCell() }
          moreCell = moreButtonCell
        moreCell.delegate = self
        moreCell.setFoldState(isFolded: isFold)
      }else{
        guard let infoCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryRouteTVC.className, for: indexPath) as? PlanDetailSummaryRouteTVC else {return UITableViewCell() }
        routeCell = infoCell
        
        routeCell.setLocationData(order: order,
                                  locationName: locationList[indexPath.row].locationName,
                                  transportCase:  (locationList.count == indexPath.row + 1) ? nil : locationList[indexPath.row].transportCase,
                                  time: (locationList.count == indexPath.row + 1) ? "" : locationList[indexPath.row].time)
      }
    }
    
    if locationList.count <= 5{
      return routeCell
    }else{
      if (isFold == true && indexPath.row == 5) || (isFold == false && indexPath.row == locationList.count){
        return moreCell
      }else{
        return routeCell
      }
    }
  }
}

extension PlanDetailSummaryTVC : SummaryFoldDelegate{
  func foldButtonClicked() {
    viewModel.isFold = !viewModel.isFold
    let isFold = viewModel.isFold

    postObserverAction(.summaryFoldStateChanged, object: isFold)
  }
}
