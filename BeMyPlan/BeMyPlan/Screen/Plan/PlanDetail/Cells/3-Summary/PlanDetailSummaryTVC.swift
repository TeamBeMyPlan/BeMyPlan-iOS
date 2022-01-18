//
//  PlanDetailSummaryTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailSummaryTVC: UITableViewCell,UITableViewRegisterable{
  
  var summaryList : [[PlanDetail.Summary]] = [[]]
  
  static var isFromNib: Bool = true
  private var isFold : Bool = true{
    didSet{
      calculateSummaryHeight()
      listTV.reloadData()
    }
  }
  private var first : CGFloat = 0,
      middle : CGFloat = 0,
      last : CGFloat = 0,
      additional : CGFloat = 0
  
  var locationList : [PlanDetail.Summary] = []{
    didSet{
      calculateSummaryHeight()
      listTV.reloadData()
    }
  }
  
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
    addDummyData()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func addDummyData(){
    locationList = [
      PlanDetail.Summary(transportCase: .walk,
                             locationName: "1번 장소",
                             time: "20"),
      
      PlanDetail.Summary(transportCase: .car,
                             locationName: "2번 장소",
                             time: "50"),
      
      PlanDetail.Summary(transportCase: .bus,
                             locationName: "3번 장소",
                             time: "100"),
      
      PlanDetail.Summary(transportCase: .walk,
                             locationName: "4번 장소",
                             time: "80"),
      
      PlanDetail.Summary(transportCase: nil,
                             locationName: "5번 장소",
                             time: nil),
    ]
  }
  
  private func calculateSummaryHeight(){
    var totalHeight : CGFloat = 0

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
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row > 5 && indexPath.row == locationList.count{
      makeVibrate()
      isFold = !isFold
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if locationList.count > 5{
      switch(indexPath.row){
        case 0:
          return first
        case locationList.count - 2:
          return last
        case locationList.count - 1:
          return additional
        default:
          return middle
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
    if locationList.count <= 5{
      return locationList.count
    }else{
      if isFold == true{
        return 6
      }else{
        return locationList.count + 1
      }
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var order : OrderCase
    
    guard let routeCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryRouteTVC.className, for: indexPath) as? PlanDetailSummaryRouteTVC else {return UITableViewCell() }
  
    if indexPath.row == 0{
      order = .first
    }else if indexPath.row == locationList.count - 1{
      order = .final
    }else{
      order = .middle
    }
    
    routeCell.setLocationData(order: order,
                              locationName: locationList[indexPath.row].locationName,
                              transportCase: locationList[indexPath.row].transportCase,
                              time: locationList[indexPath.row].time)
    if locationList.count <= 5{
      return routeCell
    }else{
      guard let moreCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryFoldTVC.className, for: indexPath) as? PlanDetailSummaryFoldTVC else {return UITableViewCell() }
      moreCell.setFoldState(isFolded: isFold)
      
      if isFold == true{
        if indexPath.row == 5 { return moreCell }
        else{ return routeCell }
      }else{
        if indexPath.row == locationList.count {return moreCell}
        else { return routeCell }
      }
    }
  }
}
