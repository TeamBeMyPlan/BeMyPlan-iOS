//
//  PlanDetailVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailVC: UIViewController {

  // MARK: - Vars & Lets Part
  
  var currentDay : Int = 1
  var spotDataList : [PlanDetailData.SpotData] = [
    PlanDetailData.SpotData.init(locationTitle: "산방산",
                                 address
                                 : "제주특별자치도 제주시 애월읍 유수암리 산138",
                                 imagerUrls: [],
                                 textContent: "테스트",
                                 nextLocationData: PlanDetailData.Summary.init(transportCase: .walk, locationName: "다음장소", time: "5분")),
    
    PlanDetailData.SpotData.init(locationTitle: "산방2",
                                 address
                                 : "제주특별자치도 제주시 애월읍 유수암리 산138",
                                 imagerUrls: [],
                                 textContent: "테스트",
                                 nextLocationData: PlanDetailData.Summary.init(transportCase: .walk, locationName: "다음장소", time: "5분")),
    
    PlanDetailData.SpotData.init(locationTitle: "산방3",
                                 address
                                 : "제주특별자치도 제주시 애월읍 유수암리 산138",
                                 imagerUrls: [],
                                 textContent: "테스트",
                                 nextLocationData: PlanDetailData.Summary.init(transportCase: .walk, locationName: "다음장소", time: "5분"))
  
  ]

  // MARK: - UI Components Part
  
  @IBOutlet var mainContainerTV: UITableView!{
    didSet{
      mainContainerTV.delegate = self
      mainContainerTV.dataSource = self
      mainContainerTV.allowsSelection = false
    }
  }
  // MARK: - Life Cycle Parts
    override func viewDidLoad() {
        super.viewDidLoad()
      registerCells()

    }
  
  // MARK: - Custom Methods Parts
  
  private func registerCells(){
    PlanPreviewWriterTVC.register(target: mainContainerTV)
    PlanDetailMapContainerTVC.register(target: mainContainerTV)
    PlanDetailSelectDayTVC.register(target: mainContainerTV)
    PlanDetailSummaryTVC.register(target: mainContainerTV)
    PlanDetailInformationTVC.register(target: mainContainerTV)
  }
}


extension PlanDetailVC : UITableViewDelegate{
  
}

extension PlanDetailVC : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4 + spotDataList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch(indexPath.row){
      case 0:
        guard let writerCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewWriterTVC.className, for: indexPath) as? PlanPreviewWriterTVC else {return UITableViewCell() }
        
        writerCell.setHeaderData(author: "혜화동불가마", title: "좋은 여행지 소개 합니다 ^^")
        
        return writerCell
      case 1:
        guard let mapCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailMapContainerTVC.className, for: indexPath) as? PlanDetailMapContainerTVC else {return UITableViewCell() }
        
        
        return mapCell
      case 2:
        guard let selectDayCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSelectDayTVC.className, for: indexPath) as? PlanDetailSelectDayTVC else {return UITableViewCell() }
        
        selectDayCell.totalDay = 3
        return selectDayCell
      case 3:
        guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryTVC.className, for: indexPath) as? PlanDetailSummaryTVC else {return UITableViewCell() }
        summaryCell.setDa
        
        return summaryCell
      default :
        guard let infoCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailInformationTVC.className, for: indexPath) as? PlanDetailInformationTVC else {return UITableViewCell() }
        infoCe
        
        return infoCell
    }
    
  }
  
  
}
